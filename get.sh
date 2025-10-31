#!/bin/bash

set -e

showDebugging=false

while [[ "$#" -gt 0 ]]; do
  case $1 in
    --debug) showDebugging=true ;;
    *)               version=$1 ;;
  esac
  shift
done


if [ "$showDebugging" = true ]; then
  set -x
fi

if [ -z "$version" ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

if [ "$version" != "3" ] && [ "$version" != "4" ]; then
  echo "Unsupported version: $version"
  exit 1
fi


downloadUrl="https://github.com/godotengine/godot-demo-projects/releases/download/3.5-9e68af3/2d_dodge_the_creeps.zip"
if [ "$version" == "4" ]; then
  downloadUrl="https://github.com/godotengine/godot-demo-projects/releases/download/4.2-31d1c0c/2d_dodge_the_creeps.zip"
fi

scriptDir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
destDir="$scriptDir/v${version}"
mkdir -p "$destDir"

tmpdir=$(mktemp -d)
cd $tmpdir

wget "$downloadUrl" -O 2d_dodge_the_creeps.zip
unzip 2d_dodge_the_creeps.zip
mv dodge_the_creeps/* $destDir
rm -rf $tmpdir


