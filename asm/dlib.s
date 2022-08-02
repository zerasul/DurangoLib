.export _setVideoMode
.export _drawPixelPair
.exportzp _drawPixelPair_data: near

.zeropage
_drawPixelPair_data: .res 2, $00 ;  Reserve a local zero page pointer
_drawPixelPair_screen: .res 2, $00 ;  Reserve a local zero page pointer for screen position


.segment "CODE"

.proc _setVideoMode: near
    STA $df80
    RTS
.endproc

.proc _drawPixelPair: near
    ; Write struct pointer to zero page
    STA _drawPixelPair_data
    STX _drawPixelPair_data+1
    
    ; Initialize screen position
    LDA #$60
    STA _drawPixelPair_screen+1
    LDA #$00
    STA _drawPixelPair_screen
        
    convert_coords_to_mem:
    LDX #$00
    ; Load y coord argument in acumulator
    LDY #$01
    LDA (_drawPixelPair_data), Y
    ; Multiply y coord by 64 (64 bytes each row)
    ASL
    ; Also shift more sig byte
    TAY
    TXA
    ROL
    TAX
    TYA
    ; Shift less sig byte
    ASL
    ; Also shift more sig byte
    TAY
    TXA
    ROL
    TAX
    TYA
    ; Shift less sig byte
    ASL
    ; Also shift more sig byte
    TAY
    TXA
    ROL
    TAX
    TYA
    ; Shift less sig byte
    ASL
    ; Also shift more sig byte
    TAY
    TXA
    ROL
    TAX
    TYA
    ; Shift less sig byte
    ASL
    ; Also shift more sig byte
    TAY
    TXA
    ROL
    TAX
    TYA
    ; Shift less sig byte
    ASL
    ; Also shift more sig byte
    TAY
    TXA
    ROL
    TAX
    TYA
    ; Shift less sig byte
    ; Add to initial memory address, and save it
    CLC
    ADC _drawPixelPair_screen
    STA _drawPixelPair_screen

    ; If overflow, add one to more sig byte
    BCC conv_coor_mem_01
    INX
    conv_coor_mem_01:
    ; Add calculated offset to $11 (more sig)
    TXA
    CLC
    ADC _drawPixelPair_screen+1
    STA _drawPixelPair_screen+1

    ; Calculate X coord
    ; Load y coord
    LDY #$00
    LDA (_drawPixelPair_data), Y
    ; Divide x coord by 2 (2 pixel each byte)
    LSR
    ; Add to memory address
    CLC
    ADC _drawPixelPair_screen
    ; Store in video memory position
    STA _drawPixelPair_screen
    ; If overflow, increment left byte
    BCC conv_coor_mem_02
    INC _drawPixelPair_screen+1
    conv_coor_mem_02:
    ; Store color in accumulator
    LDY #$02
    LDA (_drawPixelPair_data), Y
    ; Draw actual pixel
    LDY #$00
    STA (_drawPixelPair_screen), Y
    RTS
.endproc


