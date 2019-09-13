  .file [name="checkpoint3.1.bin", type="bin", segments="XMega65Bin"]
.segmentdef XMega65Bin [segments="Syscall, Code, Data, Stack, Zeropage"]
.segmentdef Syscall [start=$8000, max=$81ff]
.segmentdef Code [start=$8200, min=$8200, max=$bdff]
.segmentdef Data [startAfter="Code", min=$8200, max=$bdff]
.segmentdef Stack [min=$be00, max=$beff, fill]
.segmentdef Zeropage [min=$bf00, max=$bfff, fill]
  .label VIC_MEMORY = $d018
  .label SCREEN = $400
  .label COLS = $d800
  .const WHITE = 1
  .const JMP = $4c
  .const NOP = $ea
  .label current_screen_line = 2
.segment Code
main: {
    rts
}
undefined_trap: {
    jsr exit_hypervisor
    rts
}
exit_hypervisor: {
    lda #1
    sta $d67f
    rts
}
CpuKill: {
    jsr exit_hypervisor
    rts
}
vF011Wr: {
    jsr exit_hypervisor
    rts
}
vF011Rd: {
    jsr exit_hypervisor
    rts
}
altTabKey: {
    jsr exit_hypervisor
    rts
}
restoreKey: {
    jsr exit_hypervisor
    rts
}
reset: {
    lda #$14
    sta VIC_MEMORY
    ldx #' '
    lda #<SCREEN
    sta.z memset.str
    lda #>SCREEN
    sta.z memset.str+1
    lda #<$28*$19
    sta.z memset.num
    lda #>$28*$19
    sta.z memset.num+1
    jsr memset
    ldx #WHITE
    lda #<COLS
    sta.z memset.str
    lda #>COLS
    sta.z memset.str+1
    lda #<$28*$19
    sta.z memset.num
    lda #>$28*$19
    sta.z memset.num+1
    jsr memset
    lda #<$400
    sta.z current_screen_line
    lda #>$400
    sta.z current_screen_line+1
    lda #<message
    sta.z print_to_screen.message
    lda #>message
    sta.z print_to_screen.message+1
    jsr print_to_screen
    jsr print_newline
    lda #<message1
    sta.z print_to_screen.message
    lda #>message1
    sta.z print_to_screen.message+1
    jsr print_to_screen
  b1:
    jmp b1
  .segment Data
    message: .text "mart0824 operating system stating..."
    .byte 0
    message1: .text "testing hardware"
    .byte 0
}
.segment Code
// print_to_screen(byte* zeropage(4) message)
print_to_screen: {
    .label message = 4
    ldx #0
  b1:
    ldy #0
    lda (message),y
    cmp #0
    bne b2
    rts
  b2:
    ldy #0
    lda (message),y
    sta (current_screen_line),y
    inc.z current_screen_line
    bne !+
    inc.z current_screen_line+1
  !:
    inc.z message
    bne !+
    inc.z message+1
  !:
    inx
    jmp b1
}
print_newline: {
    txa
    eor #$ff
    clc
    adc #$28+1
    clc
    adc.z current_screen_line
    sta.z current_screen_line
    bcc !+
    inc.z current_screen_line+1
  !:
    rts
}
// Copies the character c (an unsigned char) to the first num characters of the object pointed to by the argument str.
// memset(void* zeropage(6) str, byte register(X) c, word zeropage(4) num)
memset: {
    .label end = 4
    .label dst = 6
    .label num = 4
    .label str = 6
    lda.z num
    bne !+
    lda.z num+1
    beq breturn
  !:
    lda.z end
    clc
    adc.z str
    sta.z end
    lda.z end+1
    adc.z str+1
    sta.z end+1
  b2:
    lda.z dst+1
    cmp.z end+1
    bne b3
    lda.z dst
    cmp.z end
    bne b3
  breturn:
    rts
  b3:
    txa
    ldy #0
    sta (dst),y
    inc.z dst
    bne !+
    inc.z dst+1
  !:
    jmp b2
}
syscall64: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall63: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall62: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall61: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall60: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall59: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall58: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall57: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall56: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall55: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall54: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall53: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall52: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall51: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall50: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall49: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall48: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall47: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall46: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall45: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall44: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall43: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall42: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall41: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall40: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall39: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall38: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall37: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall36: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall35: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall34: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall33: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall32: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall31: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall30: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall29: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall28: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall27: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall26: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall25: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall24: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall23: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall22: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall21: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall20: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall19: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall18: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall17: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall16: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall15: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall14: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
secureExit: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
secureEntr: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall11: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall10: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall9: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall8: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall7: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall6: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall5: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall4: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall3: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall2: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
syscall1: {
    lda #'>'
    sta SCREEN+$4f
    jsr exit_hypervisor
    rts
}
.segment Syscall
SYSCALLS:
  .byte JMP
  .word syscall1
  .byte NOP
  .byte JMP
  .word syscall2
  .byte NOP
  .byte JMP
  .word syscall3
  .byte NOP
  .byte JMP
  .word syscall4
  .byte NOP
  .byte JMP
  .word syscall5
  .byte NOP
  .byte JMP
  .word syscall6
  .byte NOP
  .byte JMP
  .word syscall7
  .byte NOP
  .byte JMP
  .word syscall8
  .byte NOP
  .byte JMP
  .word syscall9
  .byte NOP
  .byte JMP
  .word syscall10
  .byte NOP
  .byte JMP
  .word syscall11
  .byte NOP
  .byte JMP
  .word secureEntr
  .byte NOP
  .byte JMP
  .word secureExit
  .byte NOP
  .byte JMP
  .word syscall14
  .byte NOP
  .byte JMP
  .word syscall15
  .byte NOP
  .byte JMP
  .word syscall16
  .byte NOP
  .byte JMP
  .word syscall17
  .byte NOP
  .byte JMP
  .word syscall18
  .byte NOP
  .byte JMP
  .word syscall19
  .byte NOP
  .byte JMP
  .word syscall20
  .byte NOP
  .byte JMP
  .word syscall21
  .byte NOP
  .byte JMP
  .word syscall22
  .byte NOP
  .byte JMP
  .word syscall23
  .byte NOP
  .byte JMP
  .word syscall24
  .byte NOP
  .byte JMP
  .word syscall25
  .byte NOP
  .byte JMP
  .word syscall26
  .byte NOP
  .byte JMP
  .word syscall27
  .byte NOP
  .byte JMP
  .word syscall28
  .byte NOP
  .byte JMP
  .word syscall29
  .byte NOP
  .byte JMP
  .word syscall30
  .byte NOP
  .byte JMP
  .word syscall31
  .byte NOP
  .byte JMP
  .word syscall32
  .byte NOP
  .byte JMP
  .word syscall33
  .byte NOP
  .byte JMP
  .word syscall34
  .byte NOP
  .byte JMP
  .word syscall35
  .byte NOP
  .byte JMP
  .word syscall36
  .byte NOP
  .byte JMP
  .word syscall37
  .byte NOP
  .byte JMP
  .word syscall38
  .byte NOP
  .byte JMP
  .word syscall39
  .byte NOP
  .byte JMP
  .word syscall40
  .byte NOP
  .byte JMP
  .word syscall41
  .byte NOP
  .byte JMP
  .word syscall42
  .byte NOP
  .byte JMP
  .word syscall43
  .byte NOP
  .byte JMP
  .word syscall44
  .byte NOP
  .byte JMP
  .word syscall45
  .byte NOP
  .byte JMP
  .word syscall46
  .byte NOP
  .byte JMP
  .word syscall47
  .byte NOP
  .byte JMP
  .word syscall48
  .byte NOP
  .byte JMP
  .word syscall49
  .byte NOP
  .byte JMP
  .word syscall50
  .byte NOP
  .byte JMP
  .word syscall51
  .byte NOP
  .byte JMP
  .word syscall52
  .byte NOP
  .byte JMP
  .word syscall53
  .byte NOP
  .byte JMP
  .word syscall54
  .byte NOP
  .byte JMP
  .word syscall55
  .byte NOP
  .byte JMP
  .word syscall56
  .byte NOP
  .byte JMP
  .word syscall57
  .byte NOP
  .byte JMP
  .word syscall58
  .byte NOP
  .byte JMP
  .word syscall59
  .byte NOP
  .byte JMP
  .word syscall60
  .byte NOP
  .byte JMP
  .word syscall61
  .byte NOP
  .byte JMP
  .word syscall62
  .byte NOP
  .byte JMP
  .word syscall63
  .byte NOP
  .byte JMP
  .word syscall64
  .byte NOP
  .align $100
TRAPS:
  .byte JMP
  .word reset
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word restoreKey
  .byte NOP
  .byte JMP
  .word altTabKey
  .byte NOP
  .byte JMP
  .word vF011Rd
  .byte NOP
  .byte JMP
  .word vF011Wr
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word undefined_trap
  .byte NOP
  .byte JMP
  .word CpuKill
  .byte NOP
