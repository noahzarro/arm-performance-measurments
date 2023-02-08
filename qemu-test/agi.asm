----------------
IN: Reset
0x00000400:  b580       push	{r7, lr}
0x00000402:  466f       mov	r7, sp
0x00000404:  f000 fbeb  bl	0xbde

----------------
IN: DefaultPreInit
0x00000bde:  4770       bx	lr

----------------
IN: Reset
0x00000408:  e7ff       b.n	0x40a

----------------
IN: Reset
0x0000040a:  f240 0000  movw	r0, #0	; 0x0
0x0000040e:  f2c2 0000  movt	r0, #8192	; 0x2000
0x00000412:  f240 0108  movw	r1, #8	; 0x8
0x00000416:  f2c2 0100  movt	r1, #8192	; 0x2000
0x0000041a:  f000 fc0e  bl	0xc3a

----------------
IN: _ZN2r08zero_bss17hfd898f235293eba1E
0x00000c3a:  b580       push	{r7, lr}
0x00000c3c:  466f       mov	r7, sp
0x00000c3e:  b08c       sub	sp, #48
0x00000c40:  9104       str	r1, [sp, #16]
0x00000c42:  9005       str	r0, [sp, #20]
0x00000c44:  9106       str	r1, [sp, #24]
0x00000c46:  e7ff       b.n	0xc48

----------------
IN: _ZN2r08zero_bss17hfd898f235293eba1E
0x00000c48:  9904       ldr	r1, [sp, #16]
0x00000c4a:  9805       ldr	r0, [sp, #20]
0x00000c4c:  4288       cmp	r0, r1
0x00000c4e:  d302       bcc.n	0xc56

----------------
IN: _ZN2r08zero_bss17hfd898f235293eba1E
0x00000c56:  9805       ldr	r0, [sp, #20]
0x00000c58:  9002       str	r0, [sp, #8]
0x00000c5a:  f000 f8c3  bl	0xde4

----------------
IN: _ZN4core3mem12maybe_uninit20MaybeUninit$LT$T$GT$6zeroed17hb530e3d2554bec6bE
0x00000de4:  b580       push	{r7, lr}
0x00000de6:  466f       mov	r7, sp
0x00000de8:  b086       sub	sp, #24
0x00000dea:  9802       ldr	r0, [sp, #8]
0x00000dec:  9000       str	r0, [sp, #0]
0x00000dee:  e7ff       b.n	0xdf0

----------------
IN: _ZN4core3mem12maybe_uninit20MaybeUninit$LT$T$GT$6zeroed17hb530e3d2554bec6bE
0x00000df0:  4668       mov	r0, sp
0x00000df2:  9001       str	r0, [sp, #4]
0x00000df4:  e7ff       b.n	0xdf6

----------------
IN: _ZN4core3mem12maybe_uninit20MaybeUninit$LT$T$GT$6zeroed17hb530e3d2554bec6bE
0x00000df6:  4668       mov	r0, sp
0x00000df8:  9003       str	r0, [sp, #12]
0x00000dfa:  2100       movs	r1, #0
0x00000dfc:  f807 1c05  strb.w	r1, [r7, #-5]
0x00000e00:  2201       movs	r2, #1
0x00000e02:  9205       str	r2, [sp, #20]
0x00000e04:  f000 f804  bl	0xe10

----------------
IN: _ZN4core10intrinsics11write_bytes17h72a2ad462b4fee65E
0x00000e10:  b580       push	{r7, lr}
0x00000e12:  466f       mov	r7, sp
0x00000e14:  b084       sub	sp, #16
0x00000e16:  9200       str	r2, [sp, #0]
0x00000e18:  460a       mov	r2, r1
0x00000e1a:  9900       ldr	r1, [sp, #0]
0x00000e1c:  9001       str	r0, [sp, #4]
0x00000e1e:  f807 2c05  strb.w	r2, [r7, #-5]
0x00000e22:  9103       str	r1, [sp, #12]
0x00000e24:  0089       lsls	r1, r1, #2
0x00000e26:  b2d2       uxtb	r2, r2
0x00000e28:  f000 fd5d  bl	0x18e6

----------------
IN: __aeabi_memset4
0x000018e6:  f7ff bf69  b.w	0x17bc

----------------
IN: _ZN17compiler_builtins3arm15__aeabi_memset417h4fa6db716820ea07E
0x000017bc:  b5d0       push	{r4, r6, r7, lr}
0x000017be:  af02       add	r7, sp, #8
0x000017c0:  4613       mov	r3, r2
0x000017c2:  b2d2       uxtb	r2, r2
0x000017c4:  2904       cmp	r1, #4
0x000017c6:  d339       bcc.n	0x183c

----------------
IN: _ZN17compiler_builtins3arm15__aeabi_memset417h4fa6db716820ea07E
0x000017c8:  0414       lsls	r4, r2, #16
0x000017ca:  f1a1 0e04  sub.w	lr, r1, #4	; 0x4
0x000017ce:  ea44 6303  orr.w	r3, r4, r3, lsl #24
0x000017d2:  2401       movs	r4, #1
0x000017d4:  ea43 2302  orr.w	r3, r3, r2, lsl #8
0x000017d8:  eb04 049e  add.w	r4, r4, lr, lsr #2
0x000017dc:  4413       add	r3, r2
0x000017de:  f014 0403  ands.w	r4, r4, #3	; 0x3
0x000017e2:  d00a       beq.n	0x17fa

----------------
IN: _ZN17compiler_builtins3arm15__aeabi_memset417h4fa6db716820ea07E
0x000017e4:  4684       mov	ip, r0
0x000017e6:  2c01       cmp	r4, #1
0x000017e8:  f84c 3b04  str.w	r3, [ip], #4
0x000017ec:  d10d       bne.n	0x180a

----------------
IN: _ZN17compiler_builtins3arm15__aeabi_memset417h4fa6db716820ea07E
0x000017ee:  4660       mov	r0, ip
0x000017f0:  4671       mov	r1, lr
0x000017f2:  f1be 0f0c  cmp.w	lr, #12	; 0xc
0x000017f6:  d219       bcs.n	0x182c

----------------
IN: _ZN17compiler_builtins3arm15__aeabi_memset417h4fa6db716820ea07E
0x000017f8:  e002       b.n	0x1800

----------------
IN: _ZN17compiler_builtins3arm15__aeabi_memset417h4fa6db716820ea07E
0x00001800:  4660       mov	r0, ip
0x00001802:  e8bd 40d0  ldmia.w	sp!, {r4, r6, r7, lr}
0x00001806:  f7ff bfd4  b.w	0x17b2

----------------
IN: _ZN17compiler_builtins3arm14__aeabi_memset17h97dd7ff4fcbdab78E
0x000017b2:  460b       mov	r3, r1
0x000017b4:  4611       mov	r1, r2
0x000017b6:  461a       mov	r2, r3
0x000017b8:  f000 b846  b.w	0x1848

----------------
IN: _ZN17compiler_builtins3mem6memset17hcaff16a87bfdb538E
0x00001848:  b5d0       push	{r4, r6, r7, lr}
0x0000184a:  af02       add	r7, sp, #8
0x0000184c:  2a0f       cmp	r2, #15
0x0000184e:  d936       bls.n	0x18be

----------------
IN: _ZN17compiler_builtins3mem6memset17hcaff16a87bfdb538E
0x000018be:  4603       mov	r3, r0
0x000018c0:  b182       cbz	r2, 0x18e4

----------------
IN: _ZN17compiler_builtins3mem6memset17hcaff16a87bfdb538E
0x000018e4:  bdd0       pop	{r4, r6, r7, pc}

----------------
IN: _ZN4core10intrinsics11write_bytes17h72a2ad462b4fee65E
0x00000e2c:  e7ff       b.n	0xe2e

----------------
IN: _ZN4core10intrinsics11write_bytes17h72a2ad462b4fee65E
0x00000e2e:  b004       add	sp, #16
0x00000e30:  bd80       pop	{r7, pc}

----------------
IN: _ZN4core3mem12maybe_uninit20MaybeUninit$LT$T$GT$6zeroed17hb530e3d2554bec6bE
0x00000e08:  e7ff       b.n	0xe0a

----------------
IN: _ZN4core3mem12maybe_uninit20MaybeUninit$LT$T$GT$6zeroed17hb530e3d2554bec6bE
0x00000e0a:  9800       ldr	r0, [sp, #0]
0x00000e0c:  b006       add	sp, #24
0x00000e0e:  bd80       pop	{r7, pc}

----------------
IN: _ZN2r08zero_bss17hfd898f235293eba1E
0x00000c5e:  4601       mov	r1, r0
0x00000c60:  9103       str	r1, [sp, #12]
0x00000c62:  9007       str	r0, [sp, #28]
0x00000c64:  9008       str	r0, [sp, #32]
0x00000c66:  e7ff       b.n	0xc68

----------------
IN: _ZN2r08zero_bss17hfd898f235293eba1E
0x00000c68:  9903       ldr	r1, [sp, #12]
0x00000c6a:  9802       ldr	r0, [sp, #8]
0x00000c6c:  f000 f83f  bl	0xcee

----------------
IN: _ZN4core3ptr14write_volatile17h9f9cf77250869ae6E
0x00000cee:  b082       sub	sp, #8
0x00000cf0:  9000       str	r0, [sp, #0]
0x00000cf2:  9101       str	r1, [sp, #4]
0x00000cf4:  6001       str	r1, [r0, #0]
0x00000cf6:  e7ff       b.n	0xcf8

----------------
IN: _ZN4core3ptr14write_volatile17h9f9cf77250869ae6E
0x00000cf8:  b002       add	sp, #8
0x00000cfa:  4770       bx	lr

----------------
IN: _ZN2r08zero_bss17hfd898f235293eba1E
0x00000c70:  e7ff       b.n	0xc72

----------------
IN: _ZN2r08zero_bss17hfd898f235293eba1E
0x00000c72:  9805       ldr	r0, [sp, #20]
0x00000c74:  9009       str	r0, [sp, #36]
0x00000c76:  2101       movs	r1, #1
0x00000c78:  910a       str	r1, [sp, #40]
0x00000c7a:  3004       adds	r0, #4
0x00000c7c:  900b       str	r0, [sp, #44]
0x00000c7e:  980b       ldr	r0, [sp, #44]
0x00000c80:  9001       str	r0, [sp, #4]
0x00000c82:  e7ff       b.n	0xc84

----------------
IN: _ZN2r08zero_bss17hfd898f235293eba1E
0x00000c84:  9801       ldr	r0, [sp, #4]
0x00000c86:  9005       str	r0, [sp, #20]
0x00000c88:  e7de       b.n	0xc48

----------------
IN: _ZN2r08zero_bss17hfd898f235293eba1E
0x00000c50:  e7ff       b.n	0xc52

----------------
IN: _ZN2r08zero_bss17hfd898f235293eba1E
0x00000c52:  b00c       add	sp, #48
0x00000c54:  bd80       pop	{r7, pc}

----------------
IN: Reset
0x0000041e:  e7ff       b.n	0x420

----------------
IN: Reset
0x00000420:  f240 0000  movw	r0, #0	; 0x0
0x00000424:  f2c2 0000  movt	r0, #8192	; 0x2000
0x00000428:  f240 0100  movw	r1, #0	; 0x0
0x0000042c:  f2c2 0100  movt	r1, #8192	; 0x2000
0x00000430:  f641 521c  movw	r2, #7452	; 0x1d1c
0x00000434:  f2c0 0200  movt	r2, #0	; 0x0
0x00000438:  f000 fc27  bl	0xc8a

----------------
IN: _ZN2r09init_data17h7ead79b4d0cf8a3fE
0x00000c8a:  b580       push	{r7, lr}
0x00000c8c:  466f       mov	r7, sp
0x00000c8e:  b08e       sub	sp, #56
0x00000c90:  9104       str	r1, [sp, #16]
0x00000c92:  9005       str	r0, [sp, #20]
0x00000c94:  9206       str	r2, [sp, #24]
0x00000c96:  9107       str	r1, [sp, #28]
0x00000c98:  e7ff       b.n	0xc9a

----------------
IN: _ZN2r09init_data17h7ead79b4d0cf8a3fE
0x00000c9a:  9904       ldr	r1, [sp, #16]
0x00000c9c:  9805       ldr	r0, [sp, #20]
0x00000c9e:  4288       cmp	r0, r1
0x00000ca0:  d302       bcc.n	0xca8

----------------
IN: _ZN2r09init_data17h7ead79b4d0cf8a3fE
0x00000ca2:  e7ff       b.n	0xca4

----------------
IN: _ZN2r09init_data17h7ead79b4d0cf8a3fE
0x00000ca4:  b00e       add	sp, #56
0x00000ca6:  bd80       pop	{r7, pc}

----------------
IN: Reset
0x0000043c:  e7ff       b.n	0x43e

----------------
IN: Reset
0x0000043e:  f000 f820  bl	0x482

----------------
IN: main
0x00000482:  b580       push	{r7, lr}
0x00000484:  466f       mov	r7, sp
0x00000486:  f000 f801  bl	0x48c

----------------
IN: _ZN5hello18__cortex_m_rt_main17h18e6c9cd1244b4c6E
0x0000048c:  b580       push	{r7, lr}
0x0000048e:  466f       mov	r7, sp
0x00000490:  b082       sub	sp, #8
0x00000492:  f641 1054  movw	r0, #6484	; 0x1954
0x00000496:  f2c0 0000  movt	r0, #0	; 0x0
0x0000049a:  210e       movs	r1, #14
0x0000049c:  f000 f857  bl	0x54e

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str17hc83f3f1c89565c14E
0x0000054e:  b580       push	{r7, lr}
0x00000550:  466f       mov	r7, sp
0x00000552:  b084       sub	sp, #16
0x00000554:  9001       str	r0, [sp, #4]
0x00000556:  9102       str	r1, [sp, #8]
0x00000558:  a801       add	r0, sp, #4
0x0000055a:  9003       str	r0, [sp, #12]
0x0000055c:  9803       ldr	r0, [sp, #12]
0x0000055e:  f000 fa7a  bl	0xa56

----------------
IN: _ZN8cortex_m9interrupt4free17ha559729e22be581eE
0x00000a56:  b580       push	{r7, lr}
0x00000a58:  466f       mov	r7, sp
0x00000a5a:  b088       sub	sp, #32
0x00000a5c:  9002       str	r0, [sp, #8]
0x00000a5e:  9006       str	r0, [sp, #24]
0x00000a60:  f000 f842  bl	0xae8

----------------
IN: _ZN8cortex_m8register7primask4read17h28c0217b6433dbbbE
0x00000ae8:  b580       push	{r7, lr}
0x00000aea:  466f       mov	r7, sp
0x00000aec:  b084       sub	sp, #16
0x00000aee:  f000 f861  bl	0xbb4

----------------
IN: __primask_r
0x00000bb4:  f3ef 8010  mrs	r0, PRIMASK
0x00000bb8:  4770       bx	lr

----------------
IN: _ZN8cortex_m8register7primask4read17h28c0217b6433dbbbE
0x00000af2:  4601       mov	r1, r0
0x00000af4:  9101       str	r1, [sp, #4]
0x00000af6:  9003       str	r0, [sp, #12]
0x00000af8:  e7ff       b.n	0xafa

----------------
IN: _ZN8cortex_m8register7primask4read17h28c0217b6433dbbbE
0x00000afa:  9801       ldr	r0, [sp, #4]
0x00000afc:  07c0       lsls	r0, r0, #31
0x00000afe:  b920       cbnz	r0, 0xb0a

----------------
IN: _ZN8cortex_m8register7primask4read17h28c0217b6433dbbbE
0x00000b00:  e7ff       b.n	0xb02

----------------
IN: _ZN8cortex_m8register7primask4read17h28c0217b6433dbbbE
0x00000b02:  2000       movs	r0, #0
0x00000b04:  f807 0c05  strb.w	r0, [r7, #-5]
0x00000b08:  e003       b.n	0xb12

----------------
IN: _ZN8cortex_m8register7primask4read17h28c0217b6433dbbbE
0x00000b12:  f817 0c05  ldrb.w	r0, [r7, #-5]
0x00000b16:  b004       add	sp, #16
0x00000b18:  bd80       pop	{r7, pc}

----------------
IN: _ZN8cortex_m9interrupt4free17ha559729e22be581eE
0x00000a64:  4601       mov	r1, r0
0x00000a66:  9103       str	r1, [sp, #12]
0x00000a68:  f807 0c02  strb.w	r0, [r7, #-2]
0x00000a6c:  e7ff       b.n	0xa6e

----------------
IN: _ZN8cortex_m9interrupt4free17ha559729e22be581eE
0x00000a6e:  f000 f828  bl	0xac2

----------------
IN: _ZN8cortex_m9interrupt7disable17he1cfdbd3aca1f303E
0x00000ac2:  b580       push	{r7, lr}
0x00000ac4:  466f       mov	r7, sp
0x00000ac6:  f000 f871  bl	0xbac

----------------
IN: __cpsid
0x00000bac:  b672       cpsid	i

----------------
IN: __cpsid
0x00000bae:  4770       bx	lr

----------------
IN: _ZN8cortex_m9interrupt7disable17he1cfdbd3aca1f303E
0x00000aca:  e7ff       b.n	0xacc

----------------
IN: _ZN8cortex_m9interrupt7disable17he1cfdbd3aca1f303E
0x00000acc:  bd80       pop	{r7, pc}

----------------
IN: _ZN8cortex_m9interrupt4free17ha559729e22be581eE
0x00000a72:  e7ff       b.n	0xa74

----------------
IN: _ZN8cortex_m9interrupt4free17ha559729e22be581eE
0x00000a74:  f000 f8a6  bl	0xbc4

----------------
IN: _ZN10bare_metal15CriticalSection3new17hc269a2e78b4f5d3cE
0x00000bc4:  4770       bx	lr

----------------
IN: _ZN8cortex_m9interrupt4free17ha559729e22be581eE
0x00000a78:  e7ff       b.n	0xa7a

----------------
IN: _ZN8cortex_m9interrupt4free17ha559729e22be581eE
0x00000a7a:  9802       ldr	r0, [sp, #8]
0x00000a7c:  a905       add	r1, sp, #20
0x00000a7e:  9104       str	r1, [sp, #16]
0x00000a80:  9904       ldr	r1, [sp, #16]
0x00000a82:  f7ff fd75  bl	0x570

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str28_$u7b$$u7b$closure$u7d$$u7d$17hcf5f0a0f874dda2bE
0x00000570:  b580       push	{r7, lr}
0x00000572:  466f       mov	r7, sp
0x00000574:  b090       sub	sp, #64
0x00000576:  9007       str	r0, [sp, #28]
0x00000578:  910d       str	r1, [sp, #52]
0x0000057a:  f240 0000  movw	r0, #0	; 0x0
0x0000057e:  f2c2 0000  movt	r0, #8192	; 0x2000
0x00000582:  f000 fa49  bl	0xa18

----------------
IN: _ZN4core6option15Option$LT$T$GT$7is_none17h1c35b2f6357c702bE
0x00000a18:  b580       push	{r7, lr}
0x00000a1a:  466f       mov	r7, sp
0x00000a1c:  b082       sub	sp, #8
0x00000a1e:  9001       str	r0, [sp, #4]
0x00000a20:  f000 f807  bl	0xa32

----------------
IN: _ZN4core6option15Option$LT$T$GT$7is_some17h101d69d82d432ca8E
0x00000a32:  b082       sub	sp, #8
0x00000a34:  9001       str	r0, [sp, #4]
0x00000a36:  6800       ldr	r0, [r0, #0]
0x00000a38:  2801       cmp	r0, #1
0x00000a3a:  d104       bne.n	0xa46

----------------
IN: _ZN4core6option15Option$LT$T$GT$7is_some17h101d69d82d432ca8E
0x00000a46:  2000       movs	r0, #0
0x00000a48:  f88d 0003  strb.w	r0, [sp, #3]
0x00000a4c:  e7ff       b.n	0xa4e

----------------
IN: _ZN4core6option15Option$LT$T$GT$7is_some17h101d69d82d432ca8E
0x00000a4e:  f89d 0003  ldrb.w	r0, [sp, #3]
0x00000a52:  b002       add	sp, #8
0x00000a54:  4770       bx	lr

----------------
IN: _ZN4core6option15Option$LT$T$GT$7is_none17h1c35b2f6357c702bE
0x00000a24:  9000       str	r0, [sp, #0]
0x00000a26:  e7ff       b.n	0xa28

----------------
IN: _ZN4core6option15Option$LT$T$GT$7is_none17h1c35b2f6357c702bE
0x00000a28:  9900       ldr	r1, [sp, #0]
0x00000a2a:  2001       movs	r0, #1
0x00000a2c:  4388       bics	r0, r1
0x00000a2e:  b002       add	sp, #8
0x00000a30:  bd80       pop	{r7, pc}

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str28_$u7b$$u7b$closure$u7d$$u7d$17hcf5f0a0f874dda2bE
0x00000586:  9006       str	r0, [sp, #24]
0x00000588:  e7ff       b.n	0x58a

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str28_$u7b$$u7b$closure$u7d$$u7d$17hcf5f0a0f874dda2bE
0x0000058a:  9806       ldr	r0, [sp, #24]
0x0000058c:  07c0       lsls	r0, r0, #31
0x0000058e:  b940       cbnz	r0, 0x5a2

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str28_$u7b$$u7b$closure$u7d$$u7d$17hcf5f0a0f874dda2bE
0x000005a2:  f000 f879  bl	0x698

----------------
IN: _ZN20cortex_m_semihosting3hio7hstdout17h2e7168ef53840297E
0x00000698:  b580       push	{r7, lr}
0x0000069a:  466f       mov	r7, sp
0x0000069c:  b084       sub	sp, #16
0x0000069e:  f641 200c  movw	r0, #6668	; 0x1a0c
0x000006a2:  f2c0 0000  movt	r0, #0	; 0x0
0x000006a6:  2204       movs	r2, #4
0x000006a8:  4611       mov	r1, r2
0x000006aa:  f000 f814  bl	0x6d6

----------------
IN: _ZN20cortex_m_semihosting3hio4open17h23b9211c43241b8cE
0x000006d6:  b580       push	{r7, lr}
0x000006d8:  466f       mov	r7, sp
0x000006da:  b09a       sub	sp, #104
0x000006dc:  9204       str	r2, [sp, #16]
0x000006de:  900c       str	r0, [sp, #48]
0x000006e0:  910d       str	r1, [sp, #52]
0x000006e2:  920e       str	r2, [sp, #56]
0x000006e4:  9012       str	r0, [sp, #72]
0x000006e6:  9113       str	r1, [sp, #76]
0x000006e8:  9014       str	r0, [sp, #80]
0x000006ea:  9115       str	r1, [sp, #84]
0x000006ec:  9914       ldr	r1, [sp, #80]
0x000006ee:  9105       str	r1, [sp, #20]
0x000006f0:  9815       ldr	r0, [sp, #84]
0x000006f2:  9006       str	r0, [sp, #24]
0x000006f4:  910f       str	r1, [sp, #60]
0x000006f6:  9010       str	r0, [sp, #64]
0x000006f8:  e7ff       b.n	0x6fa

----------------
IN: _ZN20cortex_m_semihosting3hio4open17h23b9211c43241b8cE
0x000006fa:  9906       ldr	r1, [sp, #24]
0x000006fc:  9805       ldr	r0, [sp, #20]
0x000006fe:  f000 fa5c  bl	0xbba

----------------
IN: _ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$6as_ptr17hc3fb7b6925bd1029E
0x00000bba:  b082       sub	sp, #8
0x00000bbc:  9000       str	r0, [sp, #0]
0x00000bbe:  9101       str	r1, [sp, #4]
0x00000bc0:  b002       add	sp, #8
0x00000bc2:  4770       bx	lr

----------------
IN: _ZN20cortex_m_semihosting3hio4open17h23b9211c43241b8cE
0x00000702:  9003       str	r0, [sp, #12]
0x00000704:  e7ff       b.n	0x706

----------------
IN: _ZN20cortex_m_semihosting3hio4open17h23b9211c43241b8cE
0x00000706:  9806       ldr	r0, [sp, #24]
0x00000708:  9903       ldr	r1, [sp, #12]
0x0000070a:  9101       str	r1, [sp, #4]
0x0000070c:  1e41       subs	r1, r0, #1
0x0000070e:  9102       str	r1, [sp, #8]
0x00000710:  2801       cmp	r0, #1
0x00000712:  d310       bcc.n	0x736

----------------
IN: _ZN20cortex_m_semihosting3hio4open17h23b9211c43241b8cE
0x00000714:  e7ff       b.n	0x716

----------------
IN: _ZN20cortex_m_semihosting3hio4open17h23b9211c43241b8cE
0x00000716:  9802       ldr	r0, [sp, #8]
0x00000718:  9904       ldr	r1, [sp, #16]
0x0000071a:  9a01       ldr	r2, [sp, #4]
0x0000071c:  9209       str	r2, [sp, #36]
0x0000071e:  910a       str	r1, [sp, #40]
0x00000720:  900b       str	r0, [sp, #44]
0x00000722:  2001       movs	r0, #1
0x00000724:  9016       str	r0, [sp, #88]
0x00000726:  a909       add	r1, sp, #36
0x00000728:  9117       str	r1, [sp, #92]
0x0000072a:  9018       str	r0, [sp, #96]
0x0000072c:  9119       str	r1, [sp, #100]
0x0000072e:  f000 fa07  bl	0xb40

----------------
IN: __c_m_sh_syscall
0x00000b40:  beab       bkpt	0x00ab

----------------
IN: __c_m_sh_syscall
0x00000b42:  4770       bx	lr

----------------
IN: _ZN20cortex_m_semihosting3hio4open17h23b9211c43241b8cE
0x00000732:  9000       str	r0, [sp, #0]
0x00000734:  e00b       b.n	0x74e

----------------
IN: _ZN20cortex_m_semihosting3hio4open17h23b9211c43241b8cE
0x0000074e:  9800       ldr	r0, [sp, #0]
0x00000750:  3001       adds	r0, #1
0x00000752:  b918       cbnz	r0, 0x75c

----------------
IN: _ZN20cortex_m_semihosting3hio4open17h23b9211c43241b8cE
0x0000075c:  9800       ldr	r0, [sp, #0]
0x0000075e:  9011       str	r0, [sp, #68]
0x00000760:  9008       str	r0, [sp, #32]
0x00000762:  2000       movs	r0, #0
0x00000764:  9007       str	r0, [sp, #28]
0x00000766:  e7ff       b.n	0x768

----------------
IN: _ZN20cortex_m_semihosting3hio4open17h23b9211c43241b8cE
0x00000768:  9807       ldr	r0, [sp, #28]
0x0000076a:  9908       ldr	r1, [sp, #32]
0x0000076c:  b01a       add	sp, #104
0x0000076e:  bd80       pop	{r7, pc}

----------------
IN: _ZN20cortex_m_semihosting3hio7hstdout17h2e7168ef53840297E
0x000006ae:  9002       str	r0, [sp, #8]
0x000006b0:  9103       str	r1, [sp, #12]
0x000006b2:  e7ff       b.n	0x6b4

----------------
IN: _ZN20cortex_m_semihosting3hio7hstdout17h2e7168ef53840297E
0x000006b4:  9903       ldr	r1, [sp, #12]
0x000006b6:  9802       ldr	r0, [sp, #8]
0x000006b8:  f000 f8db  bl	0x872

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$3map17h1e08f58d9524067bE
0x00000872:  b580       push	{r7, lr}
0x00000874:  466f       mov	r7, sp
0x00000876:  b08a       sub	sp, #40
0x00000878:  9001       str	r0, [sp, #4]
0x0000087a:  9102       str	r1, [sp, #8]
0x0000087c:  2001       movs	r0, #1
0x0000087e:  f807 0c0d  strb.w	r0, [r7, #-13]
0x00000882:  9801       ldr	r0, [sp, #4]
0x00000884:  b110       cbz	r0, 0x88c

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$3map17h1e08f58d9524067bE
0x0000088c:  9802       ldr	r0, [sp, #8]
0x0000088e:  9009       str	r0, [sp, #36]
0x00000890:  2100       movs	r1, #0
0x00000892:  f807 1c0d  strb.w	r1, [r7, #-13]
0x00000896:  9005       str	r0, [sp, #20]
0x00000898:  9805       ldr	r0, [sp, #20]
0x0000089a:  f7ff ff16  bl	0x6ca

----------------
IN: _ZN20cortex_m_semihosting3hio7hstdout28_$u7b$$u7b$closure$u7d$$u7d$17hedc7c13fe60b3ac2E
0x000006ca:  b083       sub	sp, #12
0x000006cc:  9002       str	r0, [sp, #8]
0x000006ce:  9000       str	r0, [sp, #0]
0x000006d0:  9800       ldr	r0, [sp, #0]
0x000006d2:  b003       add	sp, #12
0x000006d4:  4770       bx	lr

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$3map17h1e08f58d9524067bE
0x0000089e:  9000       str	r0, [sp, #0]
0x000008a0:  e007       b.n	0x8b2

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$3map17h1e08f58d9524067bE
0x000008b2:  9800       ldr	r0, [sp, #0]
0x000008b4:  9004       str	r0, [sp, #16]
0x000008b6:  2000       movs	r0, #0
0x000008b8:  9003       str	r0, [sp, #12]
0x000008ba:  e7f5       b.n	0x8a8

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$3map17h1e08f58d9524067bE
0x000008a8:  f817 0c0d  ldrb.w	r0, [r7, #-13]
0x000008ac:  07c0       lsls	r0, r0, #31
0x000008ae:  b948       cbnz	r0, 0x8c4

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$3map17h1e08f58d9524067bE
0x000008b0:  e004       b.n	0x8bc

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$3map17h1e08f58d9524067bE
0x000008bc:  9803       ldr	r0, [sp, #12]
0x000008be:  9904       ldr	r1, [sp, #16]
0x000008c0:  b00a       add	sp, #40
0x000008c2:  bd80       pop	{r7, pc}

----------------
IN: _ZN20cortex_m_semihosting3hio7hstdout17h2e7168ef53840297E
0x000006bc:  9000       str	r0, [sp, #0]
0x000006be:  9101       str	r1, [sp, #4]
0x000006c0:  e7ff       b.n	0x6c2

----------------
IN: _ZN20cortex_m_semihosting3hio7hstdout17h2e7168ef53840297E
0x000006c2:  9901       ldr	r1, [sp, #4]
0x000006c4:  9800       ldr	r0, [sp, #0]
0x000006c6:  b004       add	sp, #16
0x000006c8:  bd80       pop	{r7, pc}

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str28_$u7b$$u7b$closure$u7d$$u7d$17hcf5f0a0f874dda2bE
0x000005a6:  9003       str	r0, [sp, #12]
0x000005a8:  9104       str	r1, [sp, #16]
0x000005aa:  e7ff       b.n	0x5ac

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str28_$u7b$$u7b$closure$u7d$$u7d$17hcf5f0a0f874dda2bE
0x000005ac:  9904       ldr	r1, [sp, #16]
0x000005ae:  9803       ldr	r0, [sp, #12]
0x000005b0:  f000 f9d7  bl	0x962

----------------
IN: _ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h623450f1d4fa2d26E
0x00000962:  b087       sub	sp, #28
0x00000964:  9000       str	r0, [sp, #0]
0x00000966:  9101       str	r1, [sp, #4]
0x00000968:  9800       ldr	r0, [sp, #0]
0x0000096a:  b110       cbz	r0, 0x972

----------------
IN: _ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h623450f1d4fa2d26E
0x00000972:  9801       ldr	r0, [sp, #4]
0x00000974:  9006       str	r0, [sp, #24]
0x00000976:  9003       str	r0, [sp, #12]
0x00000978:  2000       movs	r0, #0
0x0000097a:  9002       str	r0, [sp, #8]
0x0000097c:  e002       b.n	0x984

----------------
IN: _ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h623450f1d4fa2d26E
0x00000984:  9802       ldr	r0, [sp, #8]
0x00000986:  9903       ldr	r1, [sp, #12]
0x00000988:  b007       add	sp, #28
0x0000098a:  4770       bx	lr

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str28_$u7b$$u7b$closure$u7d$$u7d$17hcf5f0a0f874dda2bE
0x000005b4:  910c       str	r1, [sp, #48]
0x000005b6:  900b       str	r0, [sp, #44]
0x000005b8:  e7ff       b.n	0x5ba

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str28_$u7b$$u7b$closure$u7d$$u7d$17hcf5f0a0f874dda2bE
0x000005ba:  980b       ldr	r0, [sp, #44]
0x000005bc:  b110       cbz	r0, 0x5c4

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str28_$u7b$$u7b$closure$u7d$$u7d$17hcf5f0a0f874dda2bE
0x000005c4:  980c       ldr	r0, [sp, #48]
0x000005c6:  900f       str	r0, [sp, #60]
0x000005c8:  900a       str	r0, [sp, #40]
0x000005ca:  2001       movs	r0, #1
0x000005cc:  9009       str	r0, [sp, #36]
0x000005ce:  9a09       ldr	r2, [sp, #36]
0x000005d0:  980a       ldr	r0, [sp, #40]
0x000005d2:  f240 0100  movw	r1, #0	; 0x0
0x000005d6:  f2c2 0100  movt	r1, #8192	; 0x2000
0x000005da:  600a       str	r2, [r1, #0]
0x000005dc:  6048       str	r0, [r1, #4]
0x000005de:  e7d8       b.n	0x592

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str28_$u7b$$u7b$closure$u7d$$u7d$17hcf5f0a0f874dda2bE
0x00000592:  f240 0000  movw	r0, #0	; 0x0
0x00000596:  f2c2 0000  movt	r0, #8192	; 0x2000
0x0000059a:  f000 fa0e  bl	0x9ba

----------------
IN: _ZN4core6option15Option$LT$T$GT$6as_mut17h39e8044c8570ef77E
0x000009ba:  b084       sub	sp, #16
0x000009bc:  9000       str	r0, [sp, #0]
0x000009be:  9002       str	r0, [sp, #8]
0x000009c0:  6800       ldr	r0, [r0, #0]
0x000009c2:  b110       cbz	r0, 0x9ca

----------------
IN: _ZN4core6option15Option$LT$T$GT$6as_mut17h39e8044c8570ef77E
0x000009c4:  e7ff       b.n	0x9c6

----------------
IN: _ZN4core6option15Option$LT$T$GT$6as_mut17h39e8044c8570ef77E
0x000009c6:  e004       b.n	0x9d2

----------------
IN: _ZN4core6option15Option$LT$T$GT$6as_mut17h39e8044c8570ef77E
0x000009d2:  9800       ldr	r0, [sp, #0]
0x000009d4:  3004       adds	r0, #4
0x000009d6:  9003       str	r0, [sp, #12]
0x000009d8:  9001       str	r0, [sp, #4]
0x000009da:  e7ff       b.n	0x9dc

----------------
IN: _ZN4core6option15Option$LT$T$GT$6as_mut17h39e8044c8570ef77E
0x000009dc:  9801       ldr	r0, [sp, #4]
0x000009de:  b004       add	sp, #16
0x000009e0:  4770       bx	lr

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str28_$u7b$$u7b$closure$u7d$$u7d$17hcf5f0a0f874dda2bE
0x0000059e:  9005       str	r0, [sp, #20]
0x000005a0:  e02b       b.n	0x5fa

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str28_$u7b$$u7b$closure$u7d$$u7d$17hcf5f0a0f874dda2bE
0x000005fa:  9805       ldr	r0, [sp, #20]
0x000005fc:  f641 11fc  movw	r1, #6652	; 0x19fc
0x00000600:  f2c0 0100  movt	r1, #0	; 0x0
0x00000604:  f000 f9ed  bl	0x9e2

----------------
IN: _ZN4core6option15Option$LT$T$GT$6unwrap17h18a111c0264e142fE
0x000009e2:  b580       push	{r7, lr}
0x000009e4:  466f       mov	r7, sp
0x000009e6:  b084       sub	sp, #16
0x000009e8:  9101       str	r1, [sp, #4]
0x000009ea:  9002       str	r0, [sp, #8]
0x000009ec:  9802       ldr	r0, [sp, #8]
0x000009ee:  2800       cmp	r0, #0
0x000009f0:  4601       mov	r1, r0
0x000009f2:  bf18       it	ne
0x000009f4:  2101       movne	r1, #1
0x000009f6:  b110       cbz	r0, 0x9fe

----------------
IN: _ZN4core6option15Option$LT$T$GT$6unwrap17h18a111c0264e142fE
0x000009f8:  e7ff       b.n	0x9fa

----------------
IN: _ZN4core6option15Option$LT$T$GT$6unwrap17h18a111c0264e142fE
0x000009fa:  e009       b.n	0xa10

----------------
IN: _ZN4core6option15Option$LT$T$GT$6unwrap17h18a111c0264e142fE
0x00000a10:  9802       ldr	r0, [sp, #8]
0x00000a12:  9003       str	r0, [sp, #12]
0x00000a14:  b004       add	sp, #16
0x00000a16:  bd80       pop	{r7, pc}

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str28_$u7b$$u7b$closure$u7d$$u7d$17hcf5f0a0f874dda2bE
0x00000608:  9002       str	r0, [sp, #8]
0x0000060a:  e7ff       b.n	0x60c

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str28_$u7b$$u7b$closure$u7d$$u7d$17hcf5f0a0f874dda2bE
0x0000060c:  9802       ldr	r0, [sp, #8]
0x0000060e:  9a07       ldr	r2, [sp, #28]
0x00000610:  6811       ldr	r1, [r2, #0]
0x00000612:  6852       ldr	r2, [r2, #4]
0x00000614:  f000 f81a  bl	0x64c

----------------
IN: _ZN71_$LT$cortex_m_semihosting..hio..HStdout$u20$as$u20$core..fmt..Write$GT$9write_str17hf694d9d8b4f8d732E
0x0000064c:  b580       push	{r7, lr}
0x0000064e:  466f       mov	r7, sp
0x00000650:  b08c       sub	sp, #48
0x00000652:  9002       str	r0, [sp, #8]
0x00000654:  9005       str	r0, [sp, #20]
0x00000656:  9106       str	r1, [sp, #24]
0x00000658:  9207       str	r2, [sp, #28]
0x0000065a:  9108       str	r1, [sp, #32]
0x0000065c:  9209       str	r2, [sp, #36]
0x0000065e:  910a       str	r1, [sp, #40]
0x00000660:  920b       str	r2, [sp, #44]
0x00000662:  980a       ldr	r0, [sp, #40]
0x00000664:  9003       str	r0, [sp, #12]
0x00000666:  980b       ldr	r0, [sp, #44]
0x00000668:  9004       str	r0, [sp, #16]
0x0000066a:  e7ff       b.n	0x66c

----------------
IN: _ZN71_$LT$cortex_m_semihosting..hio..HStdout$u20$as$u20$core..fmt..Write$GT$9write_str17hf694d9d8b4f8d732E
0x0000066c:  9a04       ldr	r2, [sp, #16]
0x0000066e:  9903       ldr	r1, [sp, #12]
0x00000670:  9802       ldr	r0, [sp, #8]
0x00000672:  f7ff ffdb  bl	0x62c

----------------
IN: _ZN20cortex_m_semihosting3hio7HStdout9write_all17had9e8a892ced9188E
0x0000062c:  b580       push	{r7, lr}
0x0000062e:  466f       mov	r7, sp
0x00000630:  b084       sub	sp, #16
0x00000632:  9001       str	r0, [sp, #4]
0x00000634:  9102       str	r1, [sp, #8]
0x00000636:  9203       str	r2, [sp, #12]
0x00000638:  6800       ldr	r0, [r0, #0]
0x0000063a:  f000 f899  bl	0x770

----------------
IN: _ZN20cortex_m_semihosting3hio9write_all17hc8a9c4aae091eb1cE
0x00000770:  b580       push	{r7, lr}
0x00000772:  466f       mov	r7, sp
0x00000774:  b09c       sub	sp, #112
0x00000776:  9009       str	r0, [sp, #36]
0x00000778:  910a       str	r1, [sp, #40]
0x0000077a:  920b       str	r2, [sp, #44]
0x0000077c:  9011       str	r0, [sp, #68]
0x0000077e:  e7ff       b.n	0x780

----------------
IN: _ZN20cortex_m_semihosting3hio9write_all17hc8a9c4aae091eb1cE
0x00000780:  980a       ldr	r0, [sp, #40]
0x00000782:  990b       ldr	r1, [sp, #44]
0x00000784:  f000 f911  bl	0x9aa

----------------
IN: _ZN4core5slice29_$LT$impl$u20$$u5b$T$u5d$$GT$8is_empty17h002e6c4d8c458d08E
0x000009aa:  b082       sub	sp, #8
0x000009ac:  9000       str	r0, [sp, #0]
0x000009ae:  9101       str	r1, [sp, #4]
0x000009b0:  fab1 f081  clz	r0, r1
0x000009b4:  0940       lsrs	r0, r0, #5
0x000009b6:  b002       add	sp, #8
0x000009b8:  4770       bx	lr

----------------
IN: _ZN20cortex_m_semihosting3hio9write_all17hc8a9c4aae091eb1cE
0x00000788:  9008       str	r0, [sp, #32]
0x0000078a:  e7ff       b.n	0x78c

----------------
IN: _ZN20cortex_m_semihosting3hio9write_all17hc8a9c4aae091eb1cE
0x0000078c:  9808       ldr	r0, [sp, #32]
0x0000078e:  07c0       lsls	r0, r0, #31
0x00000790:  b120       cbz	r0, 0x79c

----------------
IN: _ZN20cortex_m_semihosting3hio9write_all17hc8a9c4aae091eb1cE
0x0000079c:  980a       ldr	r0, [sp, #40]
0x0000079e:  990b       ldr	r1, [sp, #44]
0x000007a0:  f000 fa0b  bl	0xbba

----------------
IN: _ZN20cortex_m_semihosting3hio9write_all17hc8a9c4aae091eb1cE
0x000007a4:  9007       str	r0, [sp, #28]
0x000007a6:  e7ff       b.n	0x7a8

----------------
IN: _ZN20cortex_m_semihosting3hio9write_all17hc8a9c4aae091eb1cE
0x000007a8:  9907       ldr	r1, [sp, #28]
0x000007aa:  9a09       ldr	r2, [sp, #36]
0x000007ac:  980b       ldr	r0, [sp, #44]
0x000007ae:  920e       str	r2, [sp, #56]
0x000007b0:  910f       str	r1, [sp, #60]
0x000007b2:  9010       str	r0, [sp, #64]
0x000007b4:  2005       movs	r0, #5
0x000007b6:  9018       str	r0, [sp, #96]
0x000007b8:  a90e       add	r1, sp, #56
0x000007ba:  9119       str	r1, [sp, #100]
0x000007bc:  901a       str	r0, [sp, #104]
0x000007be:  911b       str	r1, [sp, #108]
0x000007c0:  f000 f9be  bl	0xb40

----------------
IN: _ZN20cortex_m_semihosting3hio9write_all17hc8a9c4aae091eb1cE
0x000007c4:  900d       str	r0, [sp, #52]
0x000007c6:  e7ff       b.n	0x7c8

----------------
IN: _ZN20cortex_m_semihosting3hio9write_all17hc8a9c4aae091eb1cE
0x000007c8:  980d       ldr	r0, [sp, #52]
0x000007ca:  b920       cbnz	r0, 0x7d6

----------------
IN: _ZN20cortex_m_semihosting3hio9write_all17hc8a9c4aae091eb1cE
0x000007cc:  e7ff       b.n	0x7ce

----------------
IN: _ZN20cortex_m_semihosting3hio9write_all17hc8a9c4aae091eb1cE
0x000007ce:  2000       movs	r0, #0
0x000007d0:  f807 0c3d  strb.w	r0, [r7, #-61]
0x000007d4:  e03c       b.n	0x850

----------------
IN: _ZN20cortex_m_semihosting3hio9write_all17hc8a9c4aae091eb1cE
0x00000850:  f817 0c3d  ldrb.w	r0, [r7, #-61]
0x00000854:  b01c       add	sp, #112
0x00000856:  bd80       pop	{r7, pc}

----------------
IN: _ZN20cortex_m_semihosting3hio7HStdout9write_all17had9e8a892ced9188E
0x0000063e:  9000       str	r0, [sp, #0]
0x00000640:  e7ff       b.n	0x642

----------------
IN: _ZN20cortex_m_semihosting3hio7HStdout9write_all17had9e8a892ced9188E
0x00000642:  9800       ldr	r0, [sp, #0]
0x00000644:  f000 0001  and.w	r0, r0, #1	; 0x1
0x00000648:  b004       add	sp, #16
0x0000064a:  bd80       pop	{r7, pc}

----------------
IN: _ZN71_$LT$cortex_m_semihosting..hio..HStdout$u20$as$u20$core..fmt..Write$GT$9write_str17hf694d9d8b4f8d732E
0x00000676:  9001       str	r0, [sp, #4]
0x00000678:  e7ff       b.n	0x67a

----------------
IN: _ZN71_$LT$cortex_m_semihosting..hio..HStdout$u20$as$u20$core..fmt..Write$GT$9write_str17hf694d9d8b4f8d732E
0x0000067a:  9801       ldr	r0, [sp, #4]
0x0000067c:  f000 0001  and.w	r0, r0, #1	; 0x1
0x00000680:  f000 f921  bl	0x8c6

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$7map_err17h1229562b62a6e6aaE
0x000008c6:  b580       push	{r7, lr}
0x000008c8:  466f       mov	r7, sp
0x000008ca:  b086       sub	sp, #24
0x000008cc:  f807 0c12  strb.w	r0, [r7, #-18]
0x000008d0:  2001       movs	r0, #1
0x000008d2:  f807 0c0d  strb.w	r0, [r7, #-13]
0x000008d6:  f817 1c12  ldrb.w	r1, [r7, #-18]
0x000008da:  07c8       lsls	r0, r1, #31
0x000008dc:  b110       cbz	r0, 0x8e4

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$7map_err17h1229562b62a6e6aaE
0x000008e4:  2000       movs	r0, #0
0x000008e6:  f807 0c11  strb.w	r0, [r7, #-17]
0x000008ea:  e009       b.n	0x900

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$7map_err17h1229562b62a6e6aaE
0x00000900:  f817 0c0d  ldrb.w	r0, [r7, #-13]
0x00000904:  07c0       lsls	r0, r0, #31
0x00000906:  b920       cbnz	r0, 0x912

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$7map_err17h1229562b62a6e6aaE
0x00000912:  e7fa       b.n	0x90a

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$7map_err17h1229562b62a6e6aaE
0x0000090a:  f817 0c11  ldrb.w	r0, [r7, #-17]
0x0000090e:  b006       add	sp, #24
0x00000910:  bd80       pop	{r7, pc}

----------------
IN: _ZN71_$LT$cortex_m_semihosting..hio..HStdout$u20$as$u20$core..fmt..Write$GT$9write_str17hf694d9d8b4f8d732E
0x00000684:  9000       str	r0, [sp, #0]
0x00000686:  e7ff       b.n	0x688

----------------
IN: _ZN71_$LT$cortex_m_semihosting..hio..HStdout$u20$as$u20$core..fmt..Write$GT$9write_str17hf694d9d8b4f8d732E
0x00000688:  9800       ldr	r0, [sp, #0]
0x0000068a:  f000 0001  and.w	r0, r0, #1	; 0x1
0x0000068e:  b00c       add	sp, #48
0x00000690:  bd80       pop	{r7, pc}

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str28_$u7b$$u7b$closure$u7d$$u7d$17hcf5f0a0f874dda2bE
0x00000618:  9001       str	r0, [sp, #4]
0x0000061a:  e7ff       b.n	0x61c

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str28_$u7b$$u7b$closure$u7d$$u7d$17hcf5f0a0f874dda2bE
0x0000061c:  9801       ldr	r0, [sp, #4]
0x0000061e:  f000 0001  and.w	r0, r0, #1	; 0x1
0x00000622:  f000 f977  bl	0x914

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$7map_err17h3668b64399714375E
0x00000914:  b580       push	{r7, lr}
0x00000916:  466f       mov	r7, sp
0x00000918:  b086       sub	sp, #24
0x0000091a:  f807 0c12  strb.w	r0, [r7, #-18]
0x0000091e:  2001       movs	r0, #1
0x00000920:  f807 0c0d  strb.w	r0, [r7, #-13]
0x00000924:  f817 1c12  ldrb.w	r1, [r7, #-18]
0x00000928:  07c8       lsls	r0, r1, #31
0x0000092a:  b110       cbz	r0, 0x932

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$7map_err17h3668b64399714375E
0x00000932:  2000       movs	r0, #0
0x00000934:  f807 0c11  strb.w	r0, [r7, #-17]
0x00000938:  e009       b.n	0x94e

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$7map_err17h3668b64399714375E
0x0000094e:  f817 0c0d  ldrb.w	r0, [r7, #-13]
0x00000952:  07c0       lsls	r0, r0, #31
0x00000954:  b920       cbnz	r0, 0x960

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$7map_err17h3668b64399714375E
0x00000960:  e7fa       b.n	0x958

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$7map_err17h3668b64399714375E
0x00000958:  f817 0c11  ldrb.w	r0, [r7, #-17]
0x0000095c:  b006       add	sp, #24
0x0000095e:  bd80       pop	{r7, pc}

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str28_$u7b$$u7b$closure$u7d$$u7d$17hcf5f0a0f874dda2bE
0x00000626:  f807 0c1d  strb.w	r0, [r7, #-29]
0x0000062a:  e7e2       b.n	0x5f2

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str28_$u7b$$u7b$closure$u7d$$u7d$17hcf5f0a0f874dda2bE
0x000005f2:  f817 0c1d  ldrb.w	r0, [r7, #-29]
0x000005f6:  b010       add	sp, #64
0x000005f8:  bd80       pop	{r7, pc}

----------------
IN: _ZN8cortex_m9interrupt4free17ha559729e22be581eE
0x00000a86:  4601       mov	r1, r0
0x00000a88:  9101       str	r1, [sp, #4]
0x00000a8a:  f807 0c01  strb.w	r0, [r7, #-1]
0x00000a8e:  e7ff       b.n	0xa90

----------------
IN: _ZN8cortex_m9interrupt4free17ha559729e22be581eE
0x00000a90:  9803       ldr	r0, [sp, #12]
0x00000a92:  f000 0001  and.w	r0, r0, #1	; 0x1
0x00000a96:  f000 f840  bl	0xb1a

----------------
IN: _ZN8cortex_m8register7primask7Primask9is_active17h248fcf31179295b3E
0x00000b1a:  b580       push	{r7, lr}
0x00000b1c:  466f       mov	r7, sp
0x00000b1e:  b082       sub	sp, #8
0x00000b20:  f807 0c01  strb.w	r0, [r7, #-1]
0x00000b24:  f641 21df  movw	r1, #6879	; 0x1adf
0x00000b28:  f2c0 0100  movt	r1, #0	; 0x0
0x00000b2c:  1e78       subs	r0, r7, #1
0x00000b2e:  f7ff ffce  bl	0xace

----------------
IN: _ZN77_$LT$cortex_m..register..primask..Primask$u20$as$u20$core..cmp..PartialEq$GT$2eq17h5bba1fb615695f4dE
0x00000ace:  b084       sub	sp, #16
0x00000ad0:  9000       str	r0, [sp, #0]
0x00000ad2:  9101       str	r1, [sp, #4]
0x00000ad4:  7800       ldrb	r0, [r0, #0]
0x00000ad6:  9002       str	r0, [sp, #8]
0x00000ad8:  7809       ldrb	r1, [r1, #0]
0x00000ada:  9103       str	r1, [sp, #12]
0x00000adc:  1a40       subs	r0, r0, r1
0x00000ade:  fab0 f080  clz	r0, r0
0x00000ae2:  0940       lsrs	r0, r0, #5
0x00000ae4:  b004       add	sp, #16
0x00000ae6:  4770       bx	lr

----------------
IN: _ZN8cortex_m8register7primask7Primask9is_active17h248fcf31179295b3E
0x00000b32:  9000       str	r0, [sp, #0]
0x00000b34:  e7ff       b.n	0xb36

----------------
IN: _ZN8cortex_m8register7primask7Primask9is_active17h248fcf31179295b3E
0x00000b36:  9800       ldr	r0, [sp, #0]
0x00000b38:  f000 0001  and.w	r0, r0, #1	; 0x1
0x00000b3c:  b002       add	sp, #8
0x00000b3e:  bd80       pop	{r7, pc}

----------------
IN: _ZN8cortex_m9interrupt4free17ha559729e22be581eE
0x00000a9a:  9000       str	r0, [sp, #0]
0x00000a9c:  e7ff       b.n	0xa9e

----------------
IN: _ZN8cortex_m9interrupt4free17ha559729e22be581eE
0x00000a9e:  9800       ldr	r0, [sp, #0]
0x00000aa0:  07c0       lsls	r0, r0, #31
0x00000aa2:  b928       cbnz	r0, 0xab0

----------------
IN: _ZN8cortex_m9interrupt4free17ha559729e22be581eE
0x00000ab0:  f000 f801  bl	0xab6

----------------
IN: _ZN8cortex_m9interrupt6enable17h840b176324dc0a8dE
0x00000ab6:  b580       push	{r7, lr}
0x00000ab8:  466f       mov	r7, sp
0x00000aba:  f000 f879  bl	0xbb0

----------------
IN: __cpsie
0x00000bb0:  b662       cpsie	i

----------------
IN: __cpsie
0x00000bb2:  4770       bx	lr

----------------
IN: _ZN8cortex_m9interrupt6enable17h840b176324dc0a8dE
0x00000abe:  e7ff       b.n	0xac0

----------------
IN: _ZN8cortex_m9interrupt6enable17h840b176324dc0a8dE
0x00000ac0:  bd80       pop	{r7, pc}

----------------
IN: _ZN8cortex_m9interrupt4free17ha559729e22be581eE
0x00000ab4:  e7f7       b.n	0xaa6

----------------
IN: _ZN8cortex_m9interrupt4free17ha559729e22be581eE
0x00000aa6:  9801       ldr	r0, [sp, #4]
0x00000aa8:  f000 0001  and.w	r0, r0, #1	; 0x1
0x00000aac:  b008       add	sp, #32
0x00000aae:  bd80       pop	{r7, pc}

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str17hc83f3f1c89565c14E
0x00000562:  9000       str	r0, [sp, #0]
0x00000564:  e7ff       b.n	0x566

----------------
IN: _ZN20cortex_m_semihosting6export11hstdout_str17hc83f3f1c89565c14E
0x00000566:  9800       ldr	r0, [sp, #0]
0x00000568:  f000 0001  and.w	r0, r0, #1	; 0x1
0x0000056c:  b004       add	sp, #16
0x0000056e:  bd80       pop	{r7, pc}

----------------
IN: _ZN5hello18__cortex_m_rt_main17h18e6c9cd1244b4c6E
0x000004a0:  9001       str	r0, [sp, #4]
0x000004a2:  e7ff       b.n	0x4a4

----------------
IN: _ZN5hello18__cortex_m_rt_main17h18e6c9cd1244b4c6E
0x000004a4:  9801       ldr	r0, [sp, #4]
0x000004a6:  f000 0001  and.w	r0, r0, #1	; 0x1
0x000004aa:  f641 1174  movw	r1, #6516	; 0x1974
0x000004ae:  f2c0 0100  movt	r1, #0	; 0x0
0x000004b2:  f7ff ffc7  bl	0x444

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h427854909d524d7eE
0x00000444:  b580       push	{r7, lr}
0x00000446:  466f       mov	r7, sp
0x00000448:  b086       sub	sp, #24
0x0000044a:  9102       str	r1, [sp, #8]
0x0000044c:  f807 0c09  strb.w	r0, [r7, #-9]
0x00000450:  f817 1c09  ldrb.w	r1, [r7, #-9]
0x00000454:  07c8       lsls	r0, r1, #31
0x00000456:  b110       cbz	r0, 0x45e

----------------
IN: _ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h427854909d524d7eE
0x0000045e:  b006       add	sp, #24
0x00000460:  bd80       pop	{r7, pc}

----------------
IN: _ZN5hello18__cortex_m_rt_main17h18e6c9cd1244b4c6E
0x000004b6:  e7ff       b.n	0x4b8

----------------
IN: _ZN5hello18__cortex_m_rt_main17h18e6c9cd1244b4c6E
0x000004b8:  2000       movs	r0, #0
0x000004ba:  f000 f81c  bl	0x4f6

----------------
IN: _ZN20cortex_m_semihosting5debug4exit17he8a951dc73dadd1eE
0x000004f6:  b580       push	{r7, lr}
0x000004f8:  466f       mov	r7, sp
0x000004fa:  b084       sub	sp, #16
0x000004fc:  f807 0c09  strb.w	r0, [r7, #-9]
0x00000500:  f817 1c09  ldrb.w	r1, [r7, #-9]
0x00000504:  07c8       lsls	r0, r1, #31
0x00000506:  b110       cbz	r0, 0x50e

----------------
IN: _ZN20cortex_m_semihosting5debug4exit17he8a951dc73dadd1eE
0x0000050e:  2026       movs	r0, #38
0x00000510:  f2c0 0002  movt	r0, #2	; 0x2
0x00000514:  9002       str	r0, [sp, #8]
0x00000516:  9802       ldr	r0, [sp, #8]
0x00000518:  f000 f80b  bl	0x532

----------------
IN: _ZN20cortex_m_semihosting5debug16report_exception17h074ce73431fcf67dE
0x00000532:  b580       push	{r7, lr}
0x00000534:  466f       mov	r7, sp
0x00000536:  b084       sub	sp, #16
0x00000538:  9000       str	r0, [sp, #0]
0x0000053a:  9900       ldr	r1, [sp, #0]
0x0000053c:  9101       str	r1, [sp, #4]
0x0000053e:  2018       movs	r0, #24
0x00000540:  9002       str	r0, [sp, #8]
0x00000542:  9103       str	r1, [sp, #12]
0x00000544:  f000 fafc  bl	0xb40

