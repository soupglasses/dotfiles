#!/usr/bin/env python3
from itertools import chain
from pathlib import Path
from subprocess import Popen
import argparse
import re

# Standardized folder-names.
re_standard = re.compile(r"^(thumb|thumbnail|cover|album|albumart|disc|front|insert|folder)\.(jpg|jpeg|png)$")
# Comics and manga that use the `001.jpg` naming convention (and similar).
re_comics = re.compile(r"^0*1(-.+)?\.(jpg|jpeg|png)$")
# Any compatible file.
re_compatible = re.compile(r"^.+\.(jpg|jpeg|png)$")

class SuitableFileNotFound(Exception):
    '''Raise when no file matches a set of requirements'''

def ideal_thumbnail(folder: Path) -> Path:
    '''Uses an exhaustive search of multiple regexes to find the best-fit thumbnail for a folder'''
    def files_matching(regex):
        return (file for file in folder.iterdir() if regex.match(file.name))
    try:
        return next(chain(
            files_matching(re_standard),
            files_matching(re_comics),
            files_matching(re_compatible),
        ))
    except StopIteration:
        raise SuitableFileNotFound(f"No suitable thumbnail found for {folder}")

def main():
    parser = argparse.ArgumentParser(description='Automatically sets thumbnails for a set of folders inside a folder')
    parser.add_argument("folder", nargs="+", type=Path, help="Folder(s) to add a thumbnail to")
    parser.add_argument("-r", "--recursive", action="store_true", help="Recurse into folders")
    parser.add_argument("-v", "--verbose", action="store_true", help="Print successful changes")
    args = parser.parse_args()

    folders = chain(*map(lambda f: f.glob("**"), args.folder)) if args.recursive else args.folder

    for folder in folders:
        if not folder.is_dir():
            print(f"WARN: {folder} is not a folder!")
            continue
        try:
            thumbnail = ideal_thumbnail(folder)
        except SuitableFileNotFound as error:
            print(f"WARN: {error}")
        else:
            Popen([
                "gio",
                "set",
                "--type=string",
                f"{folder.absolute()}",
                "metadata::custom-icon",
                f"file://{thumbnail.absolute()}"
            ])
            if args.verbose: print(thumbnail)


if __name__ == "__main__":
    main()
