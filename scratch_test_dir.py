import os
for entry in os.scandir('D:/yugitauapk'):
    if entry.is_dir():
        print(f"DIR: {entry.name}")
    else:
        print(f"FILE: {entry.name}")
