  .file [name="checkpoint4.1.bin", type="bin", segments="XMega65Bin"]
.segmentdef XMega65Bin [segments="Syscall, Code, Data, Stack, Zeropage"]
.segmentdef Syscall [start=$8000, max=$81ff]
.segmentdef Code [start=$8200, min=$8200, max=$bdff]
.segmentdef Data [startAfter="Code", min=$8200, max=$bdff]
.segmentdef Stack [min=$be00, max=$beff, fill]
.segmentdef Zeropage [min=$bf00, max=$bfff, fill]
  .label RASTER = $d012
  .label VIC_MEMORY = $d018
  .label SCREEN = $400
  .label BGCOL = $d021
  .label COLS = $d800
  .const BLACK = 0
  .const WHITE = 1
  .const JMP = $4c
  .const NOP = $ea
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
    .label sc = 4
    .label msg = 2
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
    lda #<SCREEN+$28
    sta.z sc
    lda #>SCREEN+$28
    sta.z sc+1
    lda #<MESSAGE
    sta.z msg
    lda #>MESSAGE
    sta.z msg+1
  __b1:
    ldy #0
    lda (msg),y
    cmp #0
    bne __b2
    jsr start_simple_program
  __b4:
    lda #$36
    cmp RASTER
    beq __b5
    lda #$42
    cmp RASTER
    beq __b5
    lda #BLACK
    sta BGCOL
    jmp __b4
  __b5:
    lda #WHITE
    sta BGCOL
    jmp __b4
  __b2:
    ldy #0
    lda (msg),y
    sta (sc),y
    inc.z sc
    bne !+
    inc.z sc+1
  !:
    inc.z msg
    bne !+
    inc.z msg+1
  !:
    jmp __b1
}
start_simple_program: {
    lda #$80
    sta $300
    lda #0
    sta $301
    lda #$81
    sta $302
    lda #0
    sta $303
    sta $304
    sta $305
    sta $306
    lda #$60
    sta $307
    lda #2
    sta $308
    lda #0
    sta $309
    lda #2
    sta $30a
    lda #1
    sta $30b
    lda #8
    sta $30c
    lda #0
    sta $30d
    sta $30e
    sta $30f
    lda #$60
    sta $310
    lda #3
    sta $d701
    lda #0
    sta $d702
    sta $d705
    lda #<$80d
    sta $d648
    lda #>$80d
    sta $d648+1
    jsr exit_hypervisor
    rts
}
// Copies the character c (an unsigned char) to the first num characters of the object pointed to by the argument str.
// memset(void* zeropage(4) str, byte register(X) c, word zeropage(2) num)
memset: {
    .label end = 2
    .label dst = 4
    .label num = 2
    .label str = 4
    lda.z num
    bne !+
    lda.z num+1
    beq __breturn
  !:
    lda.z end
    clc
    adc.z str
    sta.z end
    lda.z end+1
    adc.z str+1
    sta.z end+1
  __b2:
    lda.z dst+1
    cmp.z end+1
    bne __b3
    lda.z dst
    cmp.z end
    bne __b3
  __breturn:
    rts
  __b3:
    txa
    ldy #0
    sta (dst),y
    inc.z dst
    bne !+
    inc.z dst+1
  !:
    jmp __b2
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
.segment Data
  MESSAGE: .text "checkpoint 4.1 by mart0824"
  .byte 0
.segment Syscall
  SYSCALLS: .byte JMP
  .word syscall1
  .byte NOP, JMP
  .word syscall2
  .byte NOP, JMP
  .word syscall3
  .byte NOP, JMP
  .word syscall4
  .byte NOP, JMP
  .word syscall5
  .byte NOP, JMP
  .word syscall6
  .byte NOP, JMP
  .word syscall7
  .byte NOP, JMP
  .word syscall8
  .byte NOP, JMP
  .word syscall9
  .byte NOP, JMP
  .word syscall10
  .byte NOP, JMP
  .word syscall11
  .byte NOP, JMP
  .word secureEntr
  .byte NOP, JMP
  .word secureExit
  .byte NOP, JMP
  .word syscall14
  .byte NOP, JMP
  .word syscall15
  .byte NOP, JMP
  .word syscall16
  .byte NOP, JMP
  .word syscall17
  .byte NOP, JMP
  .word syscall18
  .byte NOP, JMP
  .word syscall19
  .byte NOP, JMP
  .word syscall20
  .byte NOP, JMP
  .word syscall21
  .byte NOP, JMP
  .word syscall22
  .byte NOP, JMP
  .word syscall23
  .byte NOP, JMP
  .word syscall24
  .byte NOP, JMP
  .word syscall25
  .byte NOP, JMP
  .word syscall26
  .byte NOP, JMP
  .word syscall27
  .byte NOP, JMP
  .word syscall28
  .byte NOP, JMP
  .word syscall29
  .byte NOP, JMP
  .word syscall30
  .byte NOP, JMP
  .word syscall31
  .byte NOP, JMP
  .word syscall32
  .byte NOP, JMP
  .word syscall33
  .byte NOP, JMP
  .word syscall34
  .byte NOP, JMP
  .word syscall35
  .byte NOP, JMP
  .word syscall36
  .byte NOP, JMP
  .word syscall37
  .byte NOP, JMP
  .word syscall38
  .byte NOP, JMP
  .word syscall39
  .byte NOP, JMP
  .word syscall40
  .byte NOP, JMP
  .word syscall41
  .byte NOP, JMP
  .word syscall42
  .byte NOP, JMP
  .word syscall43
  .byte NOP, JMP
  .word syscall44
  .byte NOP, JMP
  .word syscall45
  .byte NOP, JMP
  .word syscall46
  .byte NOP, JMP
  .word syscall47
  .byte NOP, JMP
  .word syscall48
  .byte NOP, JMP
  .word syscall49
  .byte NOP, JMP
  .word syscall50
  .byte NOP, JMP
  .word syscall51
  .byte NOP, JMP
  .word syscall52
  .byte NOP, JMP
  .word syscall53
  .byte NOP, JMP
  .word syscall54
  .byte NOP, JMP
  .word syscall55
  .byte NOP, JMP
  .word syscall56
  .byte NOP, JMP
  .word syscall57
  .byte NOP, JMP
  .word syscall58
  .byte NOP, JMP
  .word syscall59
  .byte NOP, JMP
  .word syscall60
  .byte NOP, JMP
  .word syscall61
  .byte NOP, JMP
  .word syscall62
  .byte NOP, JMP
  .word syscall63
  .byte NOP, JMP
  .word syscall64
  .byte NOP
  .align $100
  TRAPS: .byte JMP
  .word reset
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word restoreKey
  .byte NOP, JMP
  .word altTabKey
  .byte NOP, JMP
  .word vF011Rd
  .byte NOP, JMP
  .word vF011Wr
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word undefined_trap
  .byte NOP, JMP
  .word CpuKill
  .byte NOP
