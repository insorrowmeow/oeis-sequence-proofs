"""Check a directory of Lean sources in the pinned Lake environment."""
import argparse
import os
from pathlib import Path
import re
import subprocess
import tempfile


def check(directory, cache):
    modules = {path.stem: path for path in directory.glob("*.lean")}
    if not modules:
        raise ValueError(f"No Lean files in {directory}")
    env = os.environ.copy()
    env["LEAN_PATH"] = os.pathsep.join(filter(None, [str(cache), env.get("LEAN_PATH")]))
    done = set()

    def build(name):
        if name in done:
            return
        source = modules[name]
        for words in re.findall(r"^import[ \t]+([^\n]+)", source.read_text(encoding="utf-8-sig"), re.M):
            for dependency in words.split("--", 1)[0].split():
                if dependency in modules:
                    build(dependency)
        print(f"Checking {source.name}", flush=True)
        run = subprocess.run(["lean", "-R", str(directory), "-o", str(cache / (name + ".olean")),
                              str(source)], env=env, stdout=subprocess.PIPE,
                             stderr=subprocess.STDOUT, encoding="utf-8")
        if run.stdout:
            print(run.stdout, end="", flush=True)
        run.check_returncode()
        if "sorryAx" in run.stdout or "declaration uses 'sorry'" in run.stdout:
            raise ValueError(f"Incomplete proof in {source}")
        done.add(name)

    for name in sorted(modules):
        build(name)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("directories", type=Path, nargs="+")
    args = parser.parse_args()
    for folder in args.directories:
        with tempfile.TemporaryDirectory() as scratch:
            check(folder.resolve(), Path(scratch).resolve())
