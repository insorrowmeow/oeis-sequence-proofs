"""Check the local modules with Lean/mathlib 4.19.0, or run inside lake env."""
import argparse
import os
from pathlib import Path
import re
import shutil
import subprocess
import tempfile


HERE = Path(__file__).resolve().parent
WORK = HERE.parents[1] / "work"
BUNDLE = WORK / "round2" / "tools"


def verify(directory, names):
    cache = Path(directory).resolve()
    cache.mkdir(parents=True, exist_ok=True)
    exe = BUNDLE / "lean-4.19.0-windows/bin/lean.exe"
    paths = [str(cache)]
    roots = []
    if exe.exists():
        mathlib = BUNDLE / "mathlib"
        roots = [mathlib, *(mathlib / ".lake/packages").iterdir()]
        overlay = WORK / "round20-build/lib"
        if overlay.is_dir():
            paths.append(str(overlay))
        paths.extend(str(root / ".lake/build/lib/lean") for root in roots)
    else:
        exe = shutil.which("lean")
        if not exe:
            raise SystemExit("Run 'lake env python check_lean.py' in mathlib v4.19.0.")
    if os.environ.get("LEAN_PATH"):
        paths.append(os.environ["LEAN_PATH"])
    env = dict(os.environ, LEAN_PATH=os.pathsep.join(paths))
    subprocess.run([exe, "--version"], check=True)

    def build(src, root, out, *, dependency=False):
        opts = ["-DautoImplicit=false", "-DmaxSynthPendingDepth=3"] if dependency else []
        out.parent.mkdir(parents=True, exist_ok=True)
        while True:
            result = subprocess.run([exe, *opts, "-R", root, "-o", out, src], env=env,
                                    capture_output=True, encoding="utf-8")
            msg = result.stdout + result.stderr
            missing = re.search(r"of module ([\w.]+) does not exist", msg)
            if missing and roots and overlay.is_dir():
                mod = Path(*missing[1].split(".")).with_suffix(".lean")
                base = next((r for r in roots if (r / mod).is_file()), None)
                dep_out = overlay / mod.with_suffix(".olean")
                if base and not dep_out.exists():
                    build(base / mod, base, dep_out, dependency=True)
                    continue
            if msg:
                print(msg, end="", flush=True)
            result.check_returncode()
            if "sorryAx" in msg or "declaration uses 'sorry'" in msg:
                raise RuntimeError(f"Incomplete proof in {src}")
            break

    # The complete run also builds local imports before their dependants.
    visited = set()
    def check(name):
        if name in visited:
            return
        src = HERE / (name + ".lean")
        visited.add(name)
        for imp in re.findall(r"^import (\w+)\s*$", src.read_text(encoding="utf-8"), re.M):
            check(imp)
        print("Checking", name, flush=True)
        build(src, src.parent, cache / (name + ".olean"))

    for name in names or sorted(s.stem for s in HERE.glob("*.lean")):
        check(name)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--cache", type=Path, help="Retain intermediate compiled local modules")
    parser.add_argument("names", nargs="*")
    args = parser.parse_args()
    if args.cache:
        verify(args.cache, args.names)
    else:
        with tempfile.TemporaryDirectory(prefix="partition-size-") as tmp:
            verify(tmp, args.names)
