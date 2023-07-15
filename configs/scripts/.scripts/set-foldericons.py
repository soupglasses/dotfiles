#!/usr/bin/env python3
import argparse
import re
from collections.abc import Iterator
from itertools import chain
from pathlib import Path
from subprocess import Popen

# Standardized folder-names for thumbnails.
RE_THUMBNAIL = re.compile(r"^(thumb|thumbnail|cover|album|albumart|disc|front|insert|folder)\.(jpg|jpeg|png)$")
# Comics and manga that use the `001.jpg` naming convention (and similar).
RE_COMIC_COVER = re.compile(r"^0*1(-.+)?\.(jpg|jpeg|png)$")
# Any photo format that gio supports.
RE_PHOTO = re.compile(r"^.+\.(jpg|jpeg|png)$")


class SuitableFileNotFound(ValueError):
    """Raise when no file matches a set of requirements"""


def ideal_thumbnail(folder: Path) -> Path:
    """Uses an exhaustive search of multiple regexes to find the best-fit thumbnail for a folder"""

    def files_matching(regex: re.Pattern) -> Iterator[Path]:
        return (file for file in folder.iterdir() if regex.match(file.name))

    try:
        return next(chain(
            files_matching(RE_THUMBNAIL),
            files_matching(RE_COMIC_COVER),
            files_matching(RE_PHOTO),
        ))
    except StopIteration:
        raise SuitableFileNotFound(f"No suitable thumbnail found for {folder}")


def main():
    parser = argparse.ArgumentParser(description="Set thumbnails for folders automatically based on best-guess")
    parser.add_argument("folder", nargs="+", type=Path, help="Folders to set thumbnails for")
    parser.add_argument("-r", "--recursive", action="store_true", help="Recurse into folders")
    parser.add_argument("-v", "--verbose", action="store_true", help="Print successful changes")
    args = parser.parse_args()

    folders = (
        chain(*map(lambda f: f.glob("**"), args.folder))
        if args.recursive
        else args.folder
    )

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
                f"file://{thumbnail.absolute()}",
            ])
            if args.verbose: print(thumbnail)


if __name__ == "__main__":
    main()
