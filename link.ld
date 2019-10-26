ENTRY(_start);

SECTIONS
{
    . = 0x04000000;
    .text : {
        KEEP(*(.text.start)) *(.text .text.*)
    }
    .ro : {
	  *(.rodata)
	 }
     .rw : {
	  *(.data)
	  *(.bss)	  *(COMMON)
	 }
     . = ALIGN(8);
	 
     heap_low = .; /* for _sbrk */
     . = . + 0x10000; /* 64kB of heap memory */
     heap_top = .; /* for _sbrk */
     . = . + 0x10000; /* 64kB of stack memory */
     stack_top = .; /* for start.s */

     /DISCARD/ : { *(.comment) *(.note*) *(.eh_frame*) }
}
