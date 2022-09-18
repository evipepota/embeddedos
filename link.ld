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

    /DISCARD/ :
    {
        *(.ARM.exidx .ARM.exidx.*);
    }
}