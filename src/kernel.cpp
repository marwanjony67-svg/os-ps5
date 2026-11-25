#include <stdint.h>
#include "edition.h"

static volatile uint16_t* const VGA = reinterpret_cast<volatile uint16_t*>(0xB8000);

static void print_line(const char* text, uint8_t row, uint8_t color) {
    for (uint16_t i = 0; text[i] && i < 80; ++i) {
        VGA[row * 80 + i] =
            static_cast<uint16_t>(text[i]) |
            (static_cast<uint16_t>(color) << 8);
    }
}

extern "C" void kernel_main(uint32_t, uint32_t) {
    for (uint32_t i = 0; i < 80 * 25; ++i) VGA[i] = 0x1020;
    print_line("CONSOLE OS LAB", 2, 0x1F);
    print_line(EDITION_NAME, 5, 0x0B);
    print_line("BNU-style educational x86 kernel demo", 8, 0x0F);
    print_line("Booted successfully in PC emulator mode.", 10, 0x0A);
    print_line("Not compatible with PlayStation consoles.", 13, 0x0E);
    print_line("Experimental starter - not a complete OS.", 15, 0x07);
    for (;;) __asm__ volatile("hlt");
}
