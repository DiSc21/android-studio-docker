#!/bin/bash

function print_versions_and_ascii() {
  echo -e "\n-------------------------------------------------------------------"
  echo -e "--- VERSIONS INSTALLED --------------------------------------------"
  echo -e "-------------------------------------------------------------------\n"

  echo -e "git:   $(git --version | head -1)"
  echo -e "vim:   $(vim --version | head -1)"
  echo -e "cmake: $(cmake --version | head -1)"

  echo -e "\njava:"
  echo "-----"
  java -version

  echo -e "\nandroid_studio:"
  echo "---------------"
  /opt/android-studio/bin/studio.sh --version

  echo -e "\n-------------------------------------------------------------------\n"

  cat /ws/.docker/.ascii_arts/beavis_n_butthead_ascii_art
}

print_versions_and_ascii

echo "`whoami`" | sudo -S chmod 777 /dev/kvm > /dev/null 2>&1

args="$@"
#if [ -z "$args" ]; then
#  args="echo ${user_name}"
#fi

exec $args

