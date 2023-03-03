#!/bin/bash

main_file_path=./src/main.sh
realpath=NULL

install_dependencies() {
  python3 -m pip install --upgrade pip &&
  python3 -m pip install selenium &&
  brew install shc
}

set_realpath() {
  realpath=realpath=$PWD/${1#./}
  realpath=${realpath////\\/}
}

remove_second_line() {
  sed -i.bak -e '2d' $main_file_path
}

remove_temp_files() {
  rm -f "$main_file_path".bak
  rm "$main_file_path".x.c
}

write_realpath() {
  second_line=`sed '2!d' $main_file_path`

  if [[ $second_line != $realpath && $second_line ]]; then
    remove_second_line
  fi

  if [[ $second_line != $realpath ]]; then
    sed -i '.bak' '2s/^/'$realpath'\n/g' $main_file_path
  fi
}

compile_sh_to_binary() {
  shc -f $main_file_path &&
  mv "$main_file_path".x ./naumen_login
}

install_dependencies &&
set_realpath &&
write_realpath &&
compile_sh_to_binary &&
remove_temp_files &&

./naumen_login

exit 0

