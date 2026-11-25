# ConsoleOS Lab — PS5 / PS4 / PS3 Inspired PC ISOs

An original educational operating-system starter that builds three separate BIOS/Legacy bootable ISO images with console-inspired names and visual identity.

**Important:** These are PC emulator demos, not Sony PlayStation operating systems. They do not run on PS3/PS4/PS5 hardware and contain no Sony firmware, games, logos, or proprietary assets.

## Build with GitHub Actions
1. Open the repository's **Actions** tab.
2. Select **Build ConsoleOS Lab ISOs**.
3. Choose **Run workflow** (or wait for a push build).
4. Download the `consoleos-lab-isos` artifact from a successful run.

## Build locally (Ubuntu/Debian)
Install `nasm`, `g++`, `binutils`, `grub-pc-bin`, and `xorriso`, then run:

```bash
chmod +x scripts/build.sh
./scripts/build.sh
```

Three ISO files are written to `dist/`:
- `consoleos-5-inspired.iso`
- `consoleos-4-inspired.iso`
- `consoleos-3-inspired.iso`

## Test
Use a PC emulator such as QEMU. Start with a disposable virtual machine and do not install experimental images on your main computer.

## Current scope
- 32-bit x86 BIOS boot through GRUB Multiboot2
- Minimal C++ kernel and Assembly entry point
- Separate edition-branded boot screens
- Automated ISO creation

This is an early bootable kernel demonstration, not a complete OS. Graphics acceleration, controllers, audio, networking, storage drivers, user accounts, and a desktop environment are not implemented yet.

## License
MIT.
