"""Check the local modules with Lean/mathlib 4.19.0, or run inside lake env."""
import argparse
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tempfile


HERE = Path(__file__).resolve().parent


def verify(directory, names):
    cache = Path(directory).resolve()
    cache.mkdir(parents=True, exist_ok=True)
    paths = [str(cache)]
    relative_exe = Path("work/round2/tools/lean-4.19.0-windows/bin/lean.exe")
    base = next((p for p in HERE.parents if (p / relative_exe).is_file()), None)
    if base:
        exe = base / relative_exe
        mathlib = base / "work/round2/tools/mathlib"
        paths.extend(str(p) for p in (mathlib / ".lake/packages").glob("*/.lake/build/lib/lean"))
        overlay = base / "work/round20-build/lib"
        if overlay.is_dir():
            paths.append(str(overlay))
        paths.append(str(mathlib / ".lake/build/lib/lean"))
    else:
        exe = shutil.which("lean")
        if not exe:
            raise SystemExit("Run 'lake env python check_lean.py' in mathlib v4.19.0.")
    if os.environ.get("LEAN_PATH"):
        paths.append(os.environ["LEAN_PATH"])
    env = dict(os.environ, LEAN_PATH=os.pathsep.join(paths))
    subprocess.run([exe, "--version"], check=True)

    def build(src, root, out):
        result = subprocess.run([exe, "-R", root, "-o", out, src], env=env,
                                capture_output=True, encoding="utf-8")
        msg = result.stdout + result.stderr
        if msg:
            print(msg, end="", flush=True)
        result.check_returncode()
        if "sorryAx" in msg or "declaration uses 'sorry'" in msg:
            raise RuntimeError(f"Incomplete proof in {src}")

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
    # Lean emits Unicode diagnostics even on Windows consoles using a legacy encoding.
    sys.stdout.reconfigure(errors="backslashreplace")
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--cache", type=Path, help="Retain intermediate compiled local modules")
    parser.add_argument("names", nargs="*")
    args = parser.parse_args()
    if args.cache:
        verify(args.cache, args.names)
    else:
        with tempfile.TemporaryDirectory(prefix="lean-proof-") as tmp:
            verify(tmp, args.names)

