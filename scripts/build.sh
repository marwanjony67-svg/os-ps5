#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BUILD="$ROOT/build"
DIST="$ROOT/dist"
mkdir -p "$BUILD" "$DIST"
for tool in nasm g++ ld grub-mkrescue; do
  command -v "$tool" >/dev/null 2>&1 || { echo "Missing build tool: $tool"; exit 1; }
done

nasm -f elf32 "$ROOT/src/boot.asm" -o "$BUILD/boot.o"

build_edition() {
  local id="$1"
  local title="$2"
  local stage="$BUILD/iso-$id"
  printf '#define EDITION_NAME "%s"\n' "$title" > "$BUILD/edition.h"
  g++ -m32 -std=c++20 -ffreestanding -fno-exceptions -fno-rtti \
    -fno-stack-protector -fno-pic -fno-pie -O2 -Wall -Wextra \
    -I"$BUILD" -c "$ROOT/src/kernel.cpp" -o "$BUILD/kernel-$id.o"
  ld -m elf_i386 -Ttext 0x100000 -e _start -nostdlib \
    "$BUILD/boot.o" "$BUILD/kernel-$id.o" -o "$BUILD/kernel-$id.elf"

  rm -rf "$stage"
  mkdir -p "$stage/boot/grub"
  cp "$BUILD/kernel-$id.elf" "$stage/boot/kernel.elf"
  sed "s/ConsoleOS Lab/$title/" "$ROOT/grub/grub.cfg" > "$stage/boot/grub/grub.cfg"
  grub-mkrescue -o "$DIST/$id.iso" "$stage"
  echo "Created $DIST/$id.iso"
}

build_edition "consoleos-5-inspired" "PS5 Inspired Edition"
build_edition "consoleos-4-inspired" "PS4 Inspired Edition"
build_edition "consoleos-3-inspired" "PS3 Inspired Edition"
