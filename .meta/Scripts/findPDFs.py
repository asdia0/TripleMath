from pathlib import Path
import glob
import shutil
import os

root = os.getcwd()

for path in Path(root).rglob('*'):  # iterate over all
    if path.suffix.lower() == ".pdf":  # check if the path pattern matches
        print(path)
        for f in glob.glob(str(path)):
            shutil.copy(f, root + "/.meta/PDF/")