#!/bin/sh

find . -maxdepth 1 -type f -size +4G -name "*tgz" | while read f
do
  dir="`basename $f`_split"
  split --verbose -d -b 4G "$f" "$f.part" &&
  md5sum "$f.part"* > "$f.split.md5sum" &&
  mkdir -p "$dir" &&
  mv "$f.part"* "$f.split.md5sum" "$dir"
done
