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

declare -a files=('lib/data/models/product_model.dart'
   'lib/data/repositories/product_repository.dart'
   'lib/redux/product/product_actions.dart'
   'lib/redux/product/product_reducer.dart'
   'lib/redux/product/product_state.dart'
   'lib/redux/product/product_middleware.dart'
   'lib/redux/product/product_selectors.dart'
   'lib/ui/product/product_edit.dart'
   'lib/ui/product/product_edit_vm.dart'
   'lib/ui/product/product_item.dart'
   'lib/ui/product/product_list_vm.dart'
   'lib/ui/product/product_list.dart'
   'lib/ui/product/product_screen.dart')

for i in "${files[@]}"
do
   filename=$(echo $i | sed "s/product/$module/g")
   echo "Creating file: $filename"
   cp $i $filename
   sed -i "s/product/$module/g" $filename
   sed -i "s/Product/$Module/g" $filename
done





