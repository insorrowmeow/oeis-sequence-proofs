"""Rebuild the certificates with Lean/mathlib 4.19.0, or inside 'lake env'."""
from pathlib import Path
import os
import re
import shutil
import subprocess
import sys
import tempfile

HERE = Path(__file__).resolve().parent
WORK = HERE.parents[1] / "work"
TOOLS = WORK / "round2" / "tools"
MODULES = ["PerimeterFinite", "PerimeterPartitions", "PerimeterLimit", "PerimeterCumulative",
           "CumulativeLimit", "Moment", "BoundaryGap", "SharpFinite", "SharpLimit", "MeanLimit",
           "PositiveCorrection", "PrimePerimeter"]


def verify(names):
    bundled = TOOLS / "lean-4.19.0-windows" / "bin" / "lean.exe"
    lean = str(bundled) if bundled.is_file() else shutil.which("lean")
    if not lean:
        raise SystemExit("Run under 'lake env python check_lean.py' with mathlib v4.19.0.")
    with tempfile.TemporaryDirectory(prefix="perimeter-lean-") as tmp:
        cache = Path(tmp)
        paths = [str(cache)]
        roots = []
        if bundled.is_file():
            mathlib = TOOLS / "mathlib"
            roots = [mathlib, *(mathlib / ".lake" / "packages").iterdir()]
            builds = [r / ".lake/build/lib/lean" for r in roots]
            # The bundled mathlib cache is partial. Keep additional oleans
            # in workspace scratch and leave the original distribution intact.
            overlay = WORK / "round20-build" / "lib"
            if not (overlay / "Mathlib").is_dir():
                for src in (builds[0] / "Mathlib").rglob("*.olean"):
                    dst = overlay / src.relative_to(builds[0])
                    dst.parent.mkdir(parents=True, exist_ok=True)
                    if not dst.exists():
                        os.link(src, dst)
            paths += [str(overlay), *(str(b) for b in builds if b.is_dir())]
        if os.environ.get("LEAN_PATH"):
            paths.append(os.environ["LEAN_PATH"])
        env = dict(os.environ, LEAN_PATH=os.pathsep.join(paths))

        def build(src, root, dst):
            dst.parent.mkdir(parents=True, exist_ok=True)
            while True:
                run = subprocess.run([lean, "-R", str(root), "-o", str(dst), str(src)],
                                     env=env, encoding="utf-8", stdout=subprocess.PIPE,
                                     stderr=subprocess.STDOUT)
                missing = re.search(r"of module ([\w.]+) does not exist", run.stdout)
                if run.returncode and roots and missing:
                    dep = Path(*missing[1].split(".")).with_suffix(".lean")
                    base = next((r for r in roots if (r / dep).is_file()), None)
                    out = overlay / dep.with_suffix(".olean")
                    if base and not out.exists():
                        print("Building dependency", missing[1], flush=True)
                        build(base / dep, base, out)
                        continue
                if run.stdout:
                    print(run.stdout, end="", flush=True)
                run.check_returncode()
                break

        subprocess.run([lean, "--version"], check=True)
        for name in names:
            print("Checking", name, flush=True)
            build(HERE / (name + ".lean"), HERE, cache / (name + ".olean"))


if __name__ == "__main__":
    verify(sys.argv[1:] or MODULES)
