#!/usr/bin/env bash
set -e

echo "Beginning bash script by removing all .o, .lis, and .out files."
rm -f -- *.o *.lis *.out

glob() {
	# https://stackoverflow.com/a/15515152/5041327
	[ -e "$1" ] && echo "$@"
}

CFLAGS="-g -m64 -Wall -Wextra -Wpedantic -fsanitize=address -fstack-protector -fno-pie -no-pie"
CXXFLAGS="$CFLAGS -std=c++17"

for f in $(glob *.asm); do
	nasm -f elf64 -g -gdwarf -o "$f.o" "$f"
done

for f in $(glob *.cpp); do
	g++ -c $CXXFLAGS -o "$f.o" "$f"
done

for f in $(glob *.c); do
	gcc -c $CFLAGS -o "$f.o" "$f"	
done

g++ $CXXFLAGS -o "$(basename "$PWD").out" ./*.o

rm -f -- *.o *.lis
