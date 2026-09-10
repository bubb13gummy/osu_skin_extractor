#!/bin/bash

success=0
fail=1

check_package() {
  if [ -e /usr/bin/unzip ]; then
    echo "[+] Found 'unzip' :P"
  else
    echo "[!] 'unzip' not found in PATH"
    read -p "[+] Download it? [Y/N]: " KUY

    if [[ "$KUY" -eq "Y" || "$KUY" -eq "y" ]]; then
      y | sudo pacman -S unzip
    elif [[ "$KUY" -eq "N" || "$KUY" -eq "n" ]]; then
      echo "[!] 'unzip' still not found in PATH!!"
      exit $fail
    fi
  fi
}

if [ $# -eq 0 ]; then
  echo "[?] Usage: $0 /path/to/skin.osk"
  exit $fail
fi

arg="$1"

if [ -z "$arg" ]; then
  echo "[!] Error: argument should not be empty >:("
  exit $fail
fi

extract() {
  copy_arg="${arg}_extract"
  code=$(
    unzip $arg -d $copy_arg >/dev/null 2>&1
    echo $?
  )
  path=$(realpath "$copy_arg")
  if [[ "$code" -eq 0 && -d "$path" ]]; then
    echo -e "[+] Extracted!! Folder saved at: $path\n[<3] Enjoy!!"
    exit $success
  else
    echo "[!] Extract failed! :("
    exit $fail
  fi
}

check_package
extract
