import os, os.path
from pathlib import Path

DIR = os.getcwd() + "/figures/"
fileNames = [name for name in os.listdir(DIR) if os.path.isfile(os.path.join(DIR, name))]

print("Enter name of figure to delete: ")
s = input()

for fileName in fileNames:
    if Path(fileName).stem == s:
        try:
            os.remove(os.path.join(DIR, fileName))
            print("Deleted " + fileName)
        except:
            continue