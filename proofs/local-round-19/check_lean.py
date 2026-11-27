"""Rebuild the local certificates, or run under 'lake env python' in mathlib."""

import os
from pathlib import Path
import shutil
import subprocess
import tempfile


HERE = Path(__file__).resolve().parent


def lean_environment(cache):
    tools = HERE.parents[1] / "work" / "round2" / "tools"
    bundled = tools / "lean-4.19.0-windows" / "bin" / "lean.exe"
    paths = [str(cache)]
    if bundled.is_file():
        lean = str(bundled)
        mathlib = tools / "mathlib"
        roots = [mathlib, *(mathlib / ".lake" / "packages").iterdir()]
        paths.extend(str(build) for root in roots
                     if (build := root / ".lake" / "build" / "lib" / "lean").is_dir())
    else:
        lean = shutil.which("lean")
        if lean is None:
            raise SystemExit("Run this script under 'lake env python' in a mathlib project.")
    if os.environ.get("LEAN_PATH"):
        paths.append(os.environ["LEAN_PATH"])
    return lean, dict(os.environ, LEAN_PATH=os.pathsep.join(paths))


if __name__ == "__main__":
    with tempfile.TemporaryDirectory(prefix="round19-lean-") as directory:
        cache = Path(directory)
        lean, env = lean_environment(cache)
        subprocess.run([lean, "--version"], check=True, env=env)
        for name in ("HiveCount", "HiveCycles", "HurwitzZero", "Hurwitz33",
                     "ThreeFactorDrop", "ThreeFactors"):
            print(f"Checking {name}.lean", flush=True)
            subprocess.run(
                [lean, "-R", str(HERE), "-o", str(cache / f"{name}.olean"),
                 str(HERE / f"{name}.lean")], check=True, env=env
            )
