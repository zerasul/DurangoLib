; ---------------------------------------------------------------------------
; vectors.s
; ---------------------------------------------------------------------------
;
; Defines the interrupt vector table.

.import _main

.segment  "VECTORS"

.addr      _main    ; NMI vector
.addr      _main    ; Reset vector
.addr      _main    ; IRQ/BRK vector
