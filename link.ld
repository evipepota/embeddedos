MEMORY
{
    FLASH : ORIGIN = 0x00000000 + 16K, LENGTH = 512K - 16K
    RAM : ORIGIN = 0x20000000, LENGTH = 192K
}

ENTRY(Reset);

EXTERN(RESET_VECTOR);

SECTIONS
{
    .vector_table ORIGIN(FLASH) : 
    {
        LONG(ORIGIN(RAM) + LENGTH(RAM));
        KEEP(*(.vector_table.reset_vector));
    } > FLASH

    .text : 
    {
        *(.text .text.*);
    } > FLASH

    .rodata :
    {
        *(.rodata .rodata.*);
    } > FLASH

    .bss (NOLOAD):
    {
        _sbss = .;
        *(.bss .bss.*);
        _ebss = .;
    } > RAM

    .data : AT(ADDR(.rodata) + SIZEOF(.rodata))
    {
        _sdata = .;
        *(.data .data.*);
        _edata = .;
    } > RAM

    _sidata = LOADADDR(.data);

    /DISCARD/ :
    {
        *(.ARM.exidx .ARM.exidx.*);
    }
}