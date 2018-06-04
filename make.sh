#!/bin/bash

module="$1"
Module="$(tr '[:lower:]' '[:upper:]' <<< ${module:0:1})${module:1}"

[ $# -eq 0 ] && { echo "Usage: $0 module-name"; exit 1; }

## Create new directories 

if [ ! -d "lib/redux/$module" ]
then
   echo "Creating directory: lib/redux/$module"
   mkdir "lib/redux/$module"
   exit
fi

if [ ! -d "lib/ui/$module" ]
then
   echo "Creating directory: lib/ui/$module"
   mkdir "lib/ui/$module"
   exit
fi

## Create new files

declare -a files=("lib/data/models/product_model.dart"
   "lib/data/repositories/product_repository.dart")

for i in "${files[@]}"
do
   filename=$(echo $i | sed "s/product/$module/g")
   echo "Creating file: $filename"
   cp $i $filename
   sed -i "s/product/$module/g" $filename
   sed -i "s/Product/$Module/g" $filename
done





