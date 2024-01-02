# search base directory containing Makefile.in
dir:=$(shell dir="."; while [ true ]; do ls $$dir | grep -q Makefile.in && break || dir="$$dir/.."; done; echo $$dir)

include ${dir}/Makefile.in

