#!/bin/sh
# Find all files in CWD > 4gb
find . -maxdepth 1 -type f -size +4G -name "*tgz" | while read f
do
  dir="`basename $f`_split"
  # Split them into 4GB pieces
  split --verbose -d -b 4G "$f" "$f.part"
  # Create a checksum file
  md5sum "$f.part"* > "$f.split.md5sum"
  # Move them all to their own folder
  mkdir -p "$dir"
  mv "$f.part"* "$f.split.md5sum" "$dir"
done
