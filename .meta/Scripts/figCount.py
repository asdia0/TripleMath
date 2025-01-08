import os, os.path
from pathlib import Path

DIR = os.getcwd() + "/figures/"
fileNames = [name for name in os.listdir(DIR) if os.path.isfile(os.path.join(DIR, name))]
auxFileNames = [int(Path(name).stem) for name in fileNames]
intFileNames = list(set(auxFileNames))

minInt = intFileNames[0]
maxInt = intFileNames[-1] + 1

allInts = [x for x in range(minInt, maxInt)]
missingInts = list(set(intFileNames) ^ set(allInts))

nextFigInt = maxInt if len(missingInts) == 0 else missingInts[0]

print(f"Next figure number is: {nextFigInt}")