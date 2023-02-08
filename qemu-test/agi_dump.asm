
hello:	file format elf32-littlearm

Disassembly of section .text:

00000400 <Reset>:
     400: 80 b5        	push	{r7, lr}
     402: 6f 46        	mov	r7, sp
     404: 00 f0 eb fb  	bl	0xbde <__pre_init>      @ imm = #2006
     408: ff e7        	b	0x40a <Reset+0xa>       @ imm = #-2
     40a: 40 f2 00 00  	movw	r0, #0
     40e: c2 f2 00 00  	movt	r0, #8192
     412: 40 f2 08 01  	movw	r1, #8
     416: c2 f2 00 01  	movt	r1, #8192
     41a: 00 f0 0e fc  	bl	0xc3a <r0::zero_bss::hfd898f235293eba1> @ imm = #2076
     41e: ff e7        	b	0x420 <Reset+0x20>      @ imm = #-2
     420: 40 f2 00 00  	movw	r0, #0
     424: c2 f2 00 00  	movt	r0, #8192
     428: 40 f2 00 01  	movw	r1, #0
     42c: c2 f2 00 01  	movt	r1, #8192
     430: 41 f6 1c 52  	movw	r2, #7452
     434: c0 f2 00 02  	movt	r2, #0
     438: 00 f0 27 fc  	bl	0xc8a <r0::init_data::h7ead79b4d0cf8a3f> @ imm = #2126
     43c: ff e7        	b	0x43e <Reset+0x3e>      @ imm = #-2
     43e: 00 f0 20 f8  	bl	0x482 <main>            @ imm = #64
     442: fe de        	trap

00000444 <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h427854909d524d7eE>:
     444: 80 b5        	push	{r7, lr}
     446: 6f 46        	mov	r7, sp
     448: 86 b0        	sub	sp, #24
     44a: 02 91        	str	r1, [sp, #8]
     44c: 07 f8 09 0c  	strb	r0, [r7, #-9]
     450: 17 f8 09 1c  	ldrb	r1, [r7, #-9]
     454: c8 07        	lsls	r0, r1, #31
     456: 10 b1        	cbz	r0, 0x45e <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h427854909d524d7eE+0x1a> @ imm = #4
     458: ff e7        	b	0x45a <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h427854909d524d7eE+0x16> @ imm = #-2
     45a: 02 e0        	b	0x462 <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h427854909d524d7eE+0x1e> @ imm = #4
     45c: fe de        	trap
     45e: 06 b0        	add	sp, #24
     460: 80 bd        	pop	{r7, pc}
     462: 02 98        	ldr	r0, [sp, #8]
     464: 69 46        	mov	r1, sp
     466: 08 60        	str	r0, [r1]
     468: 41 f6 18 10  	movw	r0, #6424
     46c: c0 f2 00 00  	movt	r0, #0
     470: 41 f6 44 13  	movw	r3, #6468
     474: c0 f2 00 03  	movt	r3, #0
     478: 2b 21        	movs	r1, #43
     47a: 04 aa        	add	r2, sp, #16
     47c: 00 f0 11 fd  	bl	0xea2 <core::result::unwrap_failed::h2638fbe3b922fd33> @ imm = #2594
     480: fe de        	trap

00000482 <main>:
     482: 80 b5        	push	{r7, lr}
     484: 6f 46        	mov	r7, sp
     486: 00 f0 01 f8  	bl	0x48c <hello::__cortex_m_rt_main::h18e6c9cd1244b4c6> @ imm = #2
     48a: fe de        	trap

0000048c <hello::__cortex_m_rt_main::h18e6c9cd1244b4c6>:
     48c: 80 b5        	push	{r7, lr}
     48e: 6f 46        	mov	r7, sp
     490: 82 b0        	sub	sp, #8
     492: 41 f6 54 10  	movw	r0, #6484
     496: c0 f2 00 00  	movt	r0, #0
     49a: 0e 21        	movs	r1, #14
     49c: 00 f0 57 f8  	bl	0x54e <cortex_m_semihosting::export::hstdout_str::hc83f3f1c89565c14> @ imm = #174
     4a0: 01 90        	str	r0, [sp, #4]
     4a2: ff e7        	b	0x4a4 <hello::__cortex_m_rt_main::h18e6c9cd1244b4c6+0x18> @ imm = #-2
     4a4: 01 98        	ldr	r0, [sp, #4]
     4a6: 00 f0 01 00  	and	r0, r0, #1
     4aa: 41 f6 74 11  	movw	r1, #6516
     4ae: c0 f2 00 01  	movt	r1, #0
     4b2: ff f7 c7 ff  	bl	0x444 <_ZN4core6result19Result$LT$T$C$E$GT$6unwrap17h427854909d524d7eE> @ imm = #-114
     4b6: ff e7        	b	0x4b8 <hello::__cortex_m_rt_main::h18e6c9cd1244b4c6+0x2c> @ imm = #-2
     4b8: 00 20        	movs	r0, #0
     4ba: 00 f0 1c f8  	bl	0x4f6 <cortex_m_semihosting::debug::exit::he8a951dc73dadd1e> @ imm = #56
     4be: ff e7        	b	0x4c0 <hello::__cortex_m_rt_main::h18e6c9cd1244b4c6+0x34> @ imm = #-2
     4c0: fe e7        	b	0x4c0 <hello::__cortex_m_rt_main::h18e6c9cd1244b4c6+0x34> @ imm = #-4

000004c2 <<() as core::fmt::Debug>::fmt::h625ae0b8ee5144e0>:
     4c2: 80 b5        	push	{r7, lr}
     4c4: 6f 46        	mov	r7, sp
     4c6: 84 b0        	sub	sp, #16
     4c8: 00 91        	str	r1, [sp]
     4ca: 01 46        	mov	r1, r0
     4cc: 00 98        	ldr	r0, [sp]
     4ce: 02 91        	str	r1, [sp, #8]
     4d0: 03 90        	str	r0, [sp, #12]
     4d2: 41 f6 84 11  	movw	r1, #6532
     4d6: c0 f2 00 01  	movt	r1, #0
     4da: 02 22        	movs	r2, #2
     4dc: 00 f0 06 fd  	bl	0xeec <core::fmt::Formatter::pad::hc6b04d945a84cf61> @ imm = #2572
     4e0: 01 90        	str	r0, [sp, #4]
     4e2: ff e7        	b	0x4e4 <<() as core::fmt::Debug>::fmt::h625ae0b8ee5144e0+0x22> @ imm = #-2
     4e4: 01 98        	ldr	r0, [sp, #4]
     4e6: 00 f0 01 00  	and	r0, r0, #1
     4ea: 04 b0        	add	sp, #16
     4ec: 80 bd        	pop	{r7, pc}

000004ee <core::ptr::drop_in_place<()>::hc86b60acedc564ed>:
     4ee: 81 b0        	sub	sp, #4
     4f0: 00 90        	str	r0, [sp]
     4f2: 01 b0        	add	sp, #4
     4f4: 70 47        	bx	lr

000004f6 <cortex_m_semihosting::debug::exit::he8a951dc73dadd1e>:
     4f6: 80 b5        	push	{r7, lr}
     4f8: 6f 46        	mov	r7, sp
     4fa: 84 b0        	sub	sp, #16
     4fc: 07 f8 09 0c  	strb	r0, [r7, #-9]
     500: 17 f8 09 1c  	ldrb	r1, [r7, #-9]
     504: c8 07        	lsls	r0, r1, #31
     506: 10 b1        	cbz	r0, 0x50e <cortex_m_semihosting::debug::exit::he8a951dc73dadd1e+0x18> @ imm = #4
     508: ff e7        	b	0x50a <cortex_m_semihosting::debug::exit::he8a951dc73dadd1e+0x14> @ imm = #-2
     50a: 08 e0        	b	0x51e <cortex_m_semihosting::debug::exit::he8a951dc73dadd1e+0x28> @ imm = #16
     50c: fe de        	trap
     50e: 26 20        	movs	r0, #38
     510: c0 f2 02 00  	movt	r0, #2
     514: 02 90        	str	r0, [sp, #8]
     516: 02 98        	ldr	r0, [sp, #8]
     518: 00 f0 0b f8  	bl	0x532 <cortex_m_semihosting::debug::report_exception::h074ce73431fcf67d> @ imm = #22
     51c: 07 e0        	b	0x52e <cortex_m_semihosting::debug::exit::he8a951dc73dadd1e+0x38> @ imm = #14
     51e: 23 20        	movs	r0, #35
     520: c0 f2 02 00  	movt	r0, #2
     524: 03 90        	str	r0, [sp, #12]
     526: 03 98        	ldr	r0, [sp, #12]
     528: 00 f0 03 f8  	bl	0x532 <cortex_m_semihosting::debug::report_exception::h074ce73431fcf67d> @ imm = #6
     52c: ff e7        	b	0x52e <cortex_m_semihosting::debug::exit::he8a951dc73dadd1e+0x38> @ imm = #-2
     52e: 04 b0        	add	sp, #16
     530: 80 bd        	pop	{r7, pc}

00000532 <cortex_m_semihosting::debug::report_exception::h074ce73431fcf67d>:
     532: 80 b5        	push	{r7, lr}
     534: 6f 46        	mov	r7, sp
     536: 84 b0        	sub	sp, #16
     538: 00 90        	str	r0, [sp]
     53a: 00 99        	ldr	r1, [sp]
     53c: 01 91        	str	r1, [sp, #4]
     53e: 18 20        	movs	r0, #24
     540: 02 90        	str	r0, [sp, #8]
     542: 03 91        	str	r1, [sp, #12]
     544: 00 f0 fc fa  	bl	0xb40 <__c_m_sh_syscall> @ imm = #1528
     548: ff e7        	b	0x54a <cortex_m_semihosting::debug::report_exception::h074ce73431fcf67d+0x18> @ imm = #-2
     54a: 04 b0        	add	sp, #16
     54c: 80 bd        	pop	{r7, pc}

0000054e <cortex_m_semihosting::export::hstdout_str::hc83f3f1c89565c14>:
     54e: 80 b5        	push	{r7, lr}
     550: 6f 46        	mov	r7, sp
     552: 84 b0        	sub	sp, #16
     554: 01 90        	str	r0, [sp, #4]
     556: 02 91        	str	r1, [sp, #8]
     558: 01 a8        	add	r0, sp, #4
     55a: 03 90        	str	r0, [sp, #12]
     55c: 03 98        	ldr	r0, [sp, #12]
     55e: 00 f0 7a fa  	bl	0xa56 <cortex_m::interrupt::free::ha559729e22be581e> @ imm = #1268
     562: 00 90        	str	r0, [sp]
     564: ff e7        	b	0x566 <cortex_m_semihosting::export::hstdout_str::hc83f3f1c89565c14+0x18> @ imm = #-2
     566: 00 98        	ldr	r0, [sp]
     568: 00 f0 01 00  	and	r0, r0, #1
     56c: 04 b0        	add	sp, #16
     56e: 80 bd        	pop	{r7, pc}

00000570 <cortex_m_semihosting::export::hstdout_str::{{closure}}::hcf5f0a0f874dda2b>:
     570: 80 b5        	push	{r7, lr}
     572: 6f 46        	mov	r7, sp
     574: 90 b0        	sub	sp, #64
     576: 07 90        	str	r0, [sp, #28]
     578: 0d 91        	str	r1, [sp, #52]
     57a: 40 f2 00 00  	movw	r0, #0
     57e: c2 f2 00 00  	movt	r0, #8192
     582: 00 f0 49 fa  	bl	0xa18 <core::option::Option<T>::is_none::h1c35b2f6357c702b> @ imm = #1170
     586: 06 90        	str	r0, [sp, #24]
     588: ff e7        	b	0x58a <cortex_m_semihosting::export::hstdout_str::{{closure}}::hcf5f0a0f874dda2b+0x1a> @ imm = #-2
     58a: 06 98        	ldr	r0, [sp, #24]
     58c: c0 07        	lsls	r0, r0, #31
     58e: 40 b9        	cbnz	r0, 0x5a2 <cortex_m_semihosting::export::hstdout_str::{{closure}}::hcf5f0a0f874dda2b+0x32> @ imm = #16
     590: ff e7        	b	0x592 <cortex_m_semihosting::export::hstdout_str::{{closure}}::hcf5f0a0f874dda2b+0x22> @ imm = #-2
     592: 40 f2 00 00  	movw	r0, #0
     596: c2 f2 00 00  	movt	r0, #8192
     59a: 00 f0 0e fa  	bl	0x9ba <core::option::Option<T>::as_mut::h39e8044c8570ef77> @ imm = #1052
     59e: 05 90        	str	r0, [sp, #20]
     5a0: 2b e0        	b	0x5fa <cortex_m_semihosting::export::hstdout_str::{{closure}}::hcf5f0a0f874dda2b+0x8a> @ imm = #86
     5a2: 00 f0 79 f8  	bl	0x698 <cortex_m_semihosting::hio::hstdout::h2e7168ef53840297> @ imm = #242
     5a6: 03 90        	str	r0, [sp, #12]
     5a8: 04 91        	str	r1, [sp, #16]
     5aa: ff e7        	b	0x5ac <cortex_m_semihosting::export::hstdout_str::{{closure}}::hcf5f0a0f874dda2b+0x3c> @ imm = #-2
     5ac: 04 99        	ldr	r1, [sp, #16]
     5ae: 03 98        	ldr	r0, [sp, #12]
     5b0: 00 f0 d7 f9  	bl	0x962 <_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h623450f1d4fa2d26E> @ imm = #942
     5b4: 0c 91        	str	r1, [sp, #48]
     5b6: 0b 90        	str	r0, [sp, #44]
     5b8: ff e7        	b	0x5ba <cortex_m_semihosting::export::hstdout_str::{{closure}}::hcf5f0a0f874dda2b+0x4a> @ imm = #-2
     5ba: 0b 98        	ldr	r0, [sp, #44]
     5bc: 10 b1        	cbz	r0, 0x5c4 <cortex_m_semihosting::export::hstdout_str::{{closure}}::hcf5f0a0f874dda2b+0x54> @ imm = #4
     5be: ff e7        	b	0x5c0 <cortex_m_semihosting::export::hstdout_str::{{closure}}::hcf5f0a0f874dda2b+0x50> @ imm = #-2
     5c0: 0e e0        	b	0x5e0 <cortex_m_semihosting::export::hstdout_str::{{closure}}::hcf5f0a0f874dda2b+0x70> @ imm = #28
     5c2: fe de        	trap
     5c4: 0c 98        	ldr	r0, [sp, #48]
     5c6: 0f 90        	str	r0, [sp, #60]
     5c8: 0a 90        	str	r0, [sp, #40]
     5ca: 01 20        	movs	r0, #1
     5cc: 09 90        	str	r0, [sp, #36]
     5ce: 09 9a        	ldr	r2, [sp, #36]
     5d0: 0a 98        	ldr	r0, [sp, #40]
     5d2: 40 f2 00 01  	movw	r1, #0
     5d6: c2 f2 00 01  	movt	r1, #8192
     5da: 0a 60        	str	r2, [r1]
     5dc: 48 60        	str	r0, [r1, #4]
     5de: d8 e7        	b	0x592 <cortex_m_semihosting::export::hstdout_str::{{closure}}::hcf5f0a0f874dda2b+0x22> @ imm = #-80
     5e0: 41 f6 ec 10  	movw	r0, #6636
     5e4: c0 f2 00 00  	movt	r0, #0
     5e8: 00 f0 36 f9  	bl	0x858 <_ZN153_$LT$core..result..Result$LT$T$C$F$GT$$u20$as$u20$core..ops..try_trait..FromResidual$LT$core..result..Result$LT$core..convert..Infallible$C$E$GT$$GT$$GT$13from_residual17ha7fb9afdf6d70593E> @ imm = #620
     5ec: 07 f8 1d 0c  	strb	r0, [r7, #-29]
     5f0: ff e7        	b	0x5f2 <cortex_m_semihosting::export::hstdout_str::{{closure}}::hcf5f0a0f874dda2b+0x82> @ imm = #-2
     5f2: 17 f8 1d 0c  	ldrb	r0, [r7, #-29]
     5f6: 10 b0        	add	sp, #64
     5f8: 80 bd        	pop	{r7, pc}
     5fa: 05 98        	ldr	r0, [sp, #20]
     5fc: 41 f6 fc 11  	movw	r1, #6652
     600: c0 f2 00 01  	movt	r1, #0
     604: 00 f0 ed f9  	bl	0x9e2 <core::option::Option<T>::unwrap::h18a111c0264e142f> @ imm = #986
     608: 02 90        	str	r0, [sp, #8]
     60a: ff e7        	b	0x60c <cortex_m_semihosting::export::hstdout_str::{{closure}}::hcf5f0a0f874dda2b+0x9c> @ imm = #-2
     60c: 02 98        	ldr	r0, [sp, #8]
     60e: 07 9a        	ldr	r2, [sp, #28]
     610: 11 68        	ldr	r1, [r2]
     612: 52 68        	ldr	r2, [r2, #4]
     614: 00 f0 1a f8  	bl	0x64c <<cortex_m_semihosting::hio::HStdout as core::fmt::Write>::write_str::hf694d9d8b4f8d732> @ imm = #52
     618: 01 90        	str	r0, [sp, #4]
     61a: ff e7        	b	0x61c <cortex_m_semihosting::export::hstdout_str::{{closure}}::hcf5f0a0f874dda2b+0xac> @ imm = #-2
     61c: 01 98        	ldr	r0, [sp, #4]
     61e: 00 f0 01 00  	and	r0, r0, #1
     622: 00 f0 77 f9  	bl	0x914 <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h3668b64399714375E> @ imm = #750
     626: 07 f8 1d 0c  	strb	r0, [r7, #-29]
     62a: e2 e7        	b	0x5f2 <cortex_m_semihosting::export::hstdout_str::{{closure}}::hcf5f0a0f874dda2b+0x82> @ imm = #-60

0000062c <cortex_m_semihosting::hio::HStdout::write_all::had9e8a892ced9188>:
     62c: 80 b5        	push	{r7, lr}
     62e: 6f 46        	mov	r7, sp
     630: 84 b0        	sub	sp, #16
     632: 01 90        	str	r0, [sp, #4]
     634: 02 91        	str	r1, [sp, #8]
     636: 03 92        	str	r2, [sp, #12]
     638: 00 68        	ldr	r0, [r0]
     63a: 00 f0 99 f8  	bl	0x770 <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c> @ imm = #306
     63e: 00 90        	str	r0, [sp]
     640: ff e7        	b	0x642 <cortex_m_semihosting::hio::HStdout::write_all::had9e8a892ced9188+0x16> @ imm = #-2
     642: 00 98        	ldr	r0, [sp]
     644: 00 f0 01 00  	and	r0, r0, #1
     648: 04 b0        	add	sp, #16
     64a: 80 bd        	pop	{r7, pc}

0000064c <<cortex_m_semihosting::hio::HStdout as core::fmt::Write>::write_str::hf694d9d8b4f8d732>:
     64c: 80 b5        	push	{r7, lr}
     64e: 6f 46        	mov	r7, sp
     650: 8c b0        	sub	sp, #48
     652: 02 90        	str	r0, [sp, #8]
     654: 05 90        	str	r0, [sp, #20]
     656: 06 91        	str	r1, [sp, #24]
     658: 07 92        	str	r2, [sp, #28]
     65a: 08 91        	str	r1, [sp, #32]
     65c: 09 92        	str	r2, [sp, #36]
     65e: 0a 91        	str	r1, [sp, #40]
     660: 0b 92        	str	r2, [sp, #44]
     662: 0a 98        	ldr	r0, [sp, #40]
     664: 03 90        	str	r0, [sp, #12]
     666: 0b 98        	ldr	r0, [sp, #44]
     668: 04 90        	str	r0, [sp, #16]
     66a: ff e7        	b	0x66c <<cortex_m_semihosting::hio::HStdout as core::fmt::Write>::write_str::hf694d9d8b4f8d732+0x20> @ imm = #-2
     66c: 04 9a        	ldr	r2, [sp, #16]
     66e: 03 99        	ldr	r1, [sp, #12]
     670: 02 98        	ldr	r0, [sp, #8]
     672: ff f7 db ff  	bl	0x62c <cortex_m_semihosting::hio::HStdout::write_all::had9e8a892ced9188> @ imm = #-74
     676: 01 90        	str	r0, [sp, #4]
     678: ff e7        	b	0x67a <<cortex_m_semihosting::hio::HStdout as core::fmt::Write>::write_str::hf694d9d8b4f8d732+0x2e> @ imm = #-2
     67a: 01 98        	ldr	r0, [sp, #4]
     67c: 00 f0 01 00  	and	r0, r0, #1
     680: 00 f0 21 f9  	bl	0x8c6 <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h1229562b62a6e6aaE> @ imm = #578
     684: 00 90        	str	r0, [sp]
     686: ff e7        	b	0x688 <<cortex_m_semihosting::hio::HStdout as core::fmt::Write>::write_str::hf694d9d8b4f8d732+0x3c> @ imm = #-2
     688: 00 98        	ldr	r0, [sp]
     68a: 00 f0 01 00  	and	r0, r0, #1
     68e: 0c b0        	add	sp, #48
     690: 80 bd        	pop	{r7, pc}

00000692 <<cortex_m_semihosting::hio::HStdout as core::fmt::Write>::write_str::{{closure}}::haff10b53ef3ea1cc>:
     692: 82 b0        	sub	sp, #8
     694: 02 b0        	add	sp, #8
     696: 70 47        	bx	lr

00000698 <cortex_m_semihosting::hio::hstdout::h2e7168ef53840297>:
     698: 80 b5        	push	{r7, lr}
     69a: 6f 46        	mov	r7, sp
     69c: 84 b0        	sub	sp, #16
     69e: 41 f6 0c 20  	movw	r0, #6668
     6a2: c0 f2 00 00  	movt	r0, #0
     6a6: 04 22        	movs	r2, #4
     6a8: 11 46        	mov	r1, r2
     6aa: 00 f0 14 f8  	bl	0x6d6 <cortex_m_semihosting::hio::open::h23b9211c43241b8c> @ imm = #40
     6ae: 02 90        	str	r0, [sp, #8]
     6b0: 03 91        	str	r1, [sp, #12]
     6b2: ff e7        	b	0x6b4 <cortex_m_semihosting::hio::hstdout::h2e7168ef53840297+0x1c> @ imm = #-2
     6b4: 03 99        	ldr	r1, [sp, #12]
     6b6: 02 98        	ldr	r0, [sp, #8]
     6b8: 00 f0 db f8  	bl	0x872 <_ZN4core6result19Result$LT$T$C$E$GT$3map17h1e08f58d9524067bE> @ imm = #438
     6bc: 00 90        	str	r0, [sp]
     6be: 01 91        	str	r1, [sp, #4]
     6c0: ff e7        	b	0x6c2 <cortex_m_semihosting::hio::hstdout::h2e7168ef53840297+0x2a> @ imm = #-2
     6c2: 01 99        	ldr	r1, [sp, #4]
     6c4: 00 98        	ldr	r0, [sp]
     6c6: 04 b0        	add	sp, #16
     6c8: 80 bd        	pop	{r7, pc}

000006ca <cortex_m_semihosting::hio::hstdout::{{closure}}::hedc7c13fe60b3ac2>:
     6ca: 83 b0        	sub	sp, #12
     6cc: 02 90        	str	r0, [sp, #8]
     6ce: 00 90        	str	r0, [sp]
     6d0: 00 98        	ldr	r0, [sp]
     6d2: 03 b0        	add	sp, #12
     6d4: 70 47        	bx	lr

000006d6 <cortex_m_semihosting::hio::open::h23b9211c43241b8c>:
     6d6: 80 b5        	push	{r7, lr}
     6d8: 6f 46        	mov	r7, sp
     6da: 9a b0        	sub	sp, #104
     6dc: 04 92        	str	r2, [sp, #16]
     6de: 0c 90        	str	r0, [sp, #48]
     6e0: 0d 91        	str	r1, [sp, #52]
     6e2: 0e 92        	str	r2, [sp, #56]
     6e4: 12 90        	str	r0, [sp, #72]
     6e6: 13 91        	str	r1, [sp, #76]
     6e8: 14 90        	str	r0, [sp, #80]
     6ea: 15 91        	str	r1, [sp, #84]
     6ec: 14 99        	ldr	r1, [sp, #80]
     6ee: 05 91        	str	r1, [sp, #20]
     6f0: 15 98        	ldr	r0, [sp, #84]
     6f2: 06 90        	str	r0, [sp, #24]
     6f4: 0f 91        	str	r1, [sp, #60]
     6f6: 10 90        	str	r0, [sp, #64]
     6f8: ff e7        	b	0x6fa <cortex_m_semihosting::hio::open::h23b9211c43241b8c+0x24> @ imm = #-2
     6fa: 06 99        	ldr	r1, [sp, #24]
     6fc: 05 98        	ldr	r0, [sp, #20]
     6fe: 00 f0 5c fa  	bl	0xbba <core::slice::<impl [T]>::as_ptr::hc3fb7b6925bd1029> @ imm = #1208
     702: 03 90        	str	r0, [sp, #12]
     704: ff e7        	b	0x706 <cortex_m_semihosting::hio::open::h23b9211c43241b8c+0x30> @ imm = #-2
     706: 06 98        	ldr	r0, [sp, #24]
     708: 03 99        	ldr	r1, [sp, #12]
     70a: 01 91        	str	r1, [sp, #4]
     70c: 41 1e        	subs	r1, r0, #1
     70e: 02 91        	str	r1, [sp, #8]
     710: 01 28        	cmp	r0, #1
     712: 10 d3        	blo	0x736 <cortex_m_semihosting::hio::open::h23b9211c43241b8c+0x60> @ imm = #32
     714: ff e7        	b	0x716 <cortex_m_semihosting::hio::open::h23b9211c43241b8c+0x40> @ imm = #-2
     716: 02 98        	ldr	r0, [sp, #8]
     718: 04 99        	ldr	r1, [sp, #16]
     71a: 01 9a        	ldr	r2, [sp, #4]
     71c: 09 92        	str	r2, [sp, #36]
     71e: 0a 91        	str	r1, [sp, #40]
     720: 0b 90        	str	r0, [sp, #44]
     722: 01 20        	movs	r0, #1
     724: 16 90        	str	r0, [sp, #88]
     726: 09 a9        	add	r1, sp, #36
     728: 17 91        	str	r1, [sp, #92]
     72a: 18 90        	str	r0, [sp, #96]
     72c: 19 91        	str	r1, [sp, #100]
     72e: 00 f0 07 fa  	bl	0xb40 <__c_m_sh_syscall> @ imm = #1038
     732: 00 90        	str	r0, [sp]
     734: 0b e0        	b	0x74e <cortex_m_semihosting::hio::open::h23b9211c43241b8c+0x78> @ imm = #22
     736: 41 f6 80 20  	movw	r0, #6784
     73a: c0 f2 00 00  	movt	r0, #0
     73e: 41 f6 70 22  	movw	r2, #6768
     742: c0 f2 00 02  	movt	r2, #0
     746: 21 21        	movs	r1, #33
     748: 00 f0 7d fb  	bl	0xe46 <core::panicking::panic::h270cbf344f752e6a> @ imm = #1786
     74c: fe de        	trap
     74e: 00 98        	ldr	r0, [sp]
     750: 01 30        	adds	r0, #1
     752: 18 b9        	cbnz	r0, 0x75c <cortex_m_semihosting::hio::open::h23b9211c43241b8c+0x86> @ imm = #6
     754: ff e7        	b	0x756 <cortex_m_semihosting::hio::open::h23b9211c43241b8c+0x80> @ imm = #-2
     756: 01 20        	movs	r0, #1
     758: 07 90        	str	r0, [sp, #28]
     75a: 05 e0        	b	0x768 <cortex_m_semihosting::hio::open::h23b9211c43241b8c+0x92> @ imm = #10
     75c: 00 98        	ldr	r0, [sp]
     75e: 11 90        	str	r0, [sp, #68]
     760: 08 90        	str	r0, [sp, #32]
     762: 00 20        	movs	r0, #0
     764: 07 90        	str	r0, [sp, #28]
     766: ff e7        	b	0x768 <cortex_m_semihosting::hio::open::h23b9211c43241b8c+0x92> @ imm = #-2
     768: 07 98        	ldr	r0, [sp, #28]
     76a: 08 99        	ldr	r1, [sp, #32]
     76c: 1a b0        	add	sp, #104
     76e: 80 bd        	pop	{r7, pc}

00000770 <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c>:
     770: 80 b5        	push	{r7, lr}
     772: 6f 46        	mov	r7, sp
     774: 9c b0        	sub	sp, #112
     776: 09 90        	str	r0, [sp, #36]
     778: 0a 91        	str	r1, [sp, #40]
     77a: 0b 92        	str	r2, [sp, #44]
     77c: 11 90        	str	r0, [sp, #68]
     77e: ff e7        	b	0x780 <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0x10> @ imm = #-2
     780: 0a 98        	ldr	r0, [sp, #40]
     782: 0b 99        	ldr	r1, [sp, #44]
     784: 00 f0 11 f9  	bl	0x9aa <core::slice::<impl [T]>::is_empty::h002e6c4d8c458d08> @ imm = #546
     788: 08 90        	str	r0, [sp, #32]
     78a: ff e7        	b	0x78c <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0x1c> @ imm = #-2
     78c: 08 98        	ldr	r0, [sp, #32]
     78e: c0 07        	lsls	r0, r0, #31
     790: 20 b1        	cbz	r0, 0x79c <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0x2c> @ imm = #8
     792: ff e7        	b	0x794 <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0x24> @ imm = #-2
     794: 00 20        	movs	r0, #0
     796: 07 f8 3d 0c  	strb	r0, [r7, #-61]
     79a: 59 e0        	b	0x850 <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0xe0> @ imm = #178
     79c: 0a 98        	ldr	r0, [sp, #40]
     79e: 0b 99        	ldr	r1, [sp, #44]
     7a0: 00 f0 0b fa  	bl	0xbba <core::slice::<impl [T]>::as_ptr::hc3fb7b6925bd1029> @ imm = #1046
     7a4: 07 90        	str	r0, [sp, #28]
     7a6: ff e7        	b	0x7a8 <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0x38> @ imm = #-2
     7a8: 07 99        	ldr	r1, [sp, #28]
     7aa: 09 9a        	ldr	r2, [sp, #36]
     7ac: 0b 98        	ldr	r0, [sp, #44]
     7ae: 0e 92        	str	r2, [sp, #56]
     7b0: 0f 91        	str	r1, [sp, #60]
     7b2: 10 90        	str	r0, [sp, #64]
     7b4: 05 20        	movs	r0, #5
     7b6: 18 90        	str	r0, [sp, #96]
     7b8: 0e a9        	add	r1, sp, #56
     7ba: 19 91        	str	r1, [sp, #100]
     7bc: 1a 90        	str	r0, [sp, #104]
     7be: 1b 91        	str	r1, [sp, #108]
     7c0: 00 f0 be f9  	bl	0xb40 <__c_m_sh_syscall> @ imm = #892
     7c4: 0d 90        	str	r0, [sp, #52]
     7c6: ff e7        	b	0x7c8 <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0x58> @ imm = #-2
     7c8: 0d 98        	ldr	r0, [sp, #52]
     7ca: 20 b9        	cbnz	r0, 0x7d6 <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0x66> @ imm = #8
     7cc: ff e7        	b	0x7ce <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0x5e> @ imm = #-2
     7ce: 00 20        	movs	r0, #0
     7d0: 07 f8 3d 0c  	strb	r0, [r7, #-61]
     7d4: 3c e0        	b	0x850 <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0xe0> @ imm = #120
     7d6: 0d a8        	add	r0, sp, #52
     7d8: 12 90        	str	r0, [sp, #72]
     7da: 0d 98        	ldr	r0, [sp, #52]
     7dc: 0b 99        	ldr	r1, [sp, #44]
     7de: 88 42        	cmp	r0, r1
     7e0: 04 d9        	bls	0x7ec <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0x7c> @ imm = #8
     7e2: ff e7        	b	0x7e4 <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0x74> @ imm = #-2
     7e4: 01 20        	movs	r0, #1
     7e6: 07 f8 3d 0c  	strb	r0, [r7, #-61]
     7ea: 31 e0        	b	0x850 <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0xe0> @ imm = #98
     7ec: 0d 99        	ldr	r1, [sp, #52]
     7ee: 05 91        	str	r1, [sp, #20]
     7f0: 13 91        	str	r1, [sp, #76]
     7f2: 0b 98        	ldr	r0, [sp, #44]
     7f4: 42 1a        	subs	r2, r0, r1
     7f6: 06 92        	str	r2, [sp, #24]
     7f8: 88 42        	cmp	r0, r1
     7fa: 08 d3        	blo	0x80e <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0x9e> @ imm = #16
     7fc: ff e7        	b	0x7fe <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0x8e> @ imm = #-2
     7fe: 06 98        	ldr	r0, [sp, #24]
     800: 14 90        	str	r0, [sp, #80]
     802: 0a 98        	ldr	r0, [sp, #40]
     804: 0b 99        	ldr	r1, [sp, #44]
     806: 00 f0 d8 f9  	bl	0xbba <core::slice::<impl [T]>::as_ptr::hc3fb7b6925bd1029> @ imm = #944
     80a: 04 90        	str	r0, [sp, #16]
     80c: 0b e0        	b	0x826 <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0xb6> @ imm = #22
     80e: 41 f6 80 20  	movw	r0, #6784
     812: c0 f2 00 00  	movt	r0, #0
     816: 41 f6 a4 22  	movw	r2, #6820
     81a: c0 f2 00 02  	movt	r2, #0
     81e: 21 21        	movs	r1, #33
     820: 00 f0 11 fb  	bl	0xe46 <core::panicking::panic::h270cbf344f752e6a> @ imm = #1570
     824: fe de        	trap
     826: 04 98        	ldr	r0, [sp, #16]
     828: 06 99        	ldr	r1, [sp, #24]
     82a: 15 90        	str	r0, [sp, #84]
     82c: 16 91        	str	r1, [sp, #88]
     82e: 08 44        	add	r0, r1
     830: 17 90        	str	r0, [sp, #92]
     832: 17 98        	ldr	r0, [sp, #92]
     834: 03 90        	str	r0, [sp, #12]
     836: ff e7        	b	0x838 <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0xc8> @ imm = #-2
     838: 05 99        	ldr	r1, [sp, #20]
     83a: 03 98        	ldr	r0, [sp, #12]
     83c: 00 f0 82 f9  	bl	0xb44 <core::slice::raw::from_raw_parts::hfb378e54151e7aae> @ imm = #772
     840: 01 90        	str	r0, [sp, #4]
     842: 02 91        	str	r1, [sp, #8]
     844: ff e7        	b	0x846 <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0xd6> @ imm = #-2
     846: 02 98        	ldr	r0, [sp, #8]
     848: 01 99        	ldr	r1, [sp, #4]
     84a: 0a 91        	str	r1, [sp, #40]
     84c: 0b 90        	str	r0, [sp, #44]
     84e: 97 e7        	b	0x780 <cortex_m_semihosting::hio::write_all::hc8a9c4aae091eb1c+0x10> @ imm = #-210
     850: 17 f8 3d 0c  	ldrb	r0, [r7, #-61]
     854: 1c b0        	add	sp, #112
     856: 80 bd        	pop	{r7, pc}

00000858 <_ZN153_$LT$core..result..Result$LT$T$C$F$GT$$u20$as$u20$core..ops..try_trait..FromResidual$LT$core..result..Result$LT$core..convert..Infallible$C$E$GT$$GT$$GT$13from_residual17ha7fb9afdf6d70593E>:
     858: 80 b5        	push	{r7, lr}
     85a: 6f 46        	mov	r7, sp
     85c: 84 b0        	sub	sp, #16
     85e: 00 f0 a1 f8  	bl	0x9a4 <<T as core::convert::From<T>>::from::h6f6f4b197e0033b6> @ imm = #322
     862: ff e7        	b	0x864 <_ZN153_$LT$core..result..Result$LT$T$C$F$GT$$u20$as$u20$core..ops..try_trait..FromResidual$LT$core..result..Result$LT$core..convert..Infallible$C$E$GT$$GT$$GT$13from_residual17ha7fb9afdf6d70593E+0xc> @ imm = #-2
     864: 01 20        	movs	r0, #1
     866: 07 f8 09 0c  	strb	r0, [r7, #-9]
     86a: 17 f8 09 0c  	ldrb	r0, [r7, #-9]
     86e: 04 b0        	add	sp, #16
     870: 80 bd        	pop	{r7, pc}

00000872 <_ZN4core6result19Result$LT$T$C$E$GT$3map17h1e08f58d9524067bE>:
     872: 80 b5        	push	{r7, lr}
     874: 6f 46        	mov	r7, sp
     876: 8a b0        	sub	sp, #40
     878: 01 90        	str	r0, [sp, #4]
     87a: 02 91        	str	r1, [sp, #8]
     87c: 01 20        	movs	r0, #1
     87e: 07 f8 0d 0c  	strb	r0, [r7, #-13]
     882: 01 98        	ldr	r0, [sp, #4]
     884: 10 b1        	cbz	r0, 0x88c <_ZN4core6result19Result$LT$T$C$E$GT$3map17h1e08f58d9524067bE+0x1a> @ imm = #4
     886: ff e7        	b	0x888 <_ZN4core6result19Result$LT$T$C$E$GT$3map17h1e08f58d9524067bE+0x16> @ imm = #-2
     888: 0b e0        	b	0x8a2 <_ZN4core6result19Result$LT$T$C$E$GT$3map17h1e08f58d9524067bE+0x30> @ imm = #22
     88a: fe de        	trap
     88c: 02 98        	ldr	r0, [sp, #8]
     88e: 09 90        	str	r0, [sp, #36]
     890: 00 21        	movs	r1, #0
     892: 07 f8 0d 1c  	strb	r1, [r7, #-13]
     896: 05 90        	str	r0, [sp, #20]
     898: 05 98        	ldr	r0, [sp, #20]
     89a: ff f7 16 ff  	bl	0x6ca <cortex_m_semihosting::hio::hstdout::{{closure}}::hedc7c13fe60b3ac2> @ imm = #-468
     89e: 00 90        	str	r0, [sp]
     8a0: 07 e0        	b	0x8b2 <_ZN4core6result19Result$LT$T$C$E$GT$3map17h1e08f58d9524067bE+0x40> @ imm = #14
     8a2: 01 20        	movs	r0, #1
     8a4: 03 90        	str	r0, [sp, #12]
     8a6: ff e7        	b	0x8a8 <_ZN4core6result19Result$LT$T$C$E$GT$3map17h1e08f58d9524067bE+0x36> @ imm = #-2
     8a8: 17 f8 0d 0c  	ldrb	r0, [r7, #-13]
     8ac: c0 07        	lsls	r0, r0, #31
     8ae: 48 b9        	cbnz	r0, 0x8c4 <_ZN4core6result19Result$LT$T$C$E$GT$3map17h1e08f58d9524067bE+0x52> @ imm = #18
     8b0: 04 e0        	b	0x8bc <_ZN4core6result19Result$LT$T$C$E$GT$3map17h1e08f58d9524067bE+0x4a> @ imm = #8
     8b2: 00 98        	ldr	r0, [sp]
     8b4: 04 90        	str	r0, [sp, #16]
     8b6: 00 20        	movs	r0, #0
     8b8: 03 90        	str	r0, [sp, #12]
     8ba: f5 e7        	b	0x8a8 <_ZN4core6result19Result$LT$T$C$E$GT$3map17h1e08f58d9524067bE+0x36> @ imm = #-22
     8bc: 03 98        	ldr	r0, [sp, #12]
     8be: 04 99        	ldr	r1, [sp, #16]
     8c0: 0a b0        	add	sp, #40
     8c2: 80 bd        	pop	{r7, pc}
     8c4: fa e7        	b	0x8bc <_ZN4core6result19Result$LT$T$C$E$GT$3map17h1e08f58d9524067bE+0x4a> @ imm = #-12

000008c6 <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h1229562b62a6e6aaE>:
     8c6: 80 b5        	push	{r7, lr}
     8c8: 6f 46        	mov	r7, sp
     8ca: 86 b0        	sub	sp, #24
     8cc: 07 f8 12 0c  	strb	r0, [r7, #-18]
     8d0: 01 20        	movs	r0, #1
     8d2: 07 f8 0d 0c  	strb	r0, [r7, #-13]
     8d6: 17 f8 12 1c  	ldrb	r1, [r7, #-18]
     8da: c8 07        	lsls	r0, r1, #31
     8dc: 10 b1        	cbz	r0, 0x8e4 <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h1229562b62a6e6aaE+0x1e> @ imm = #4
     8de: ff e7        	b	0x8e0 <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h1229562b62a6e6aaE+0x1a> @ imm = #-2
     8e0: 04 e0        	b	0x8ec <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h1229562b62a6e6aaE+0x26> @ imm = #8
     8e2: fe de        	trap
     8e4: 00 20        	movs	r0, #0
     8e6: 07 f8 11 0c  	strb	r0, [r7, #-17]
     8ea: 09 e0        	b	0x900 <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h1229562b62a6e6aaE+0x3a> @ imm = #18
     8ec: 00 20        	movs	r0, #0
     8ee: 07 f8 0d 0c  	strb	r0, [r7, #-13]
     8f2: ff f7 ce fe  	bl	0x692 <<cortex_m_semihosting::hio::HStdout as core::fmt::Write>::write_str::{{closure}}::haff10b53ef3ea1cc> @ imm = #-612
     8f6: ff e7        	b	0x8f8 <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h1229562b62a6e6aaE+0x32> @ imm = #-2
     8f8: 01 20        	movs	r0, #1
     8fa: 07 f8 11 0c  	strb	r0, [r7, #-17]
     8fe: ff e7        	b	0x900 <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h1229562b62a6e6aaE+0x3a> @ imm = #-2
     900: 17 f8 0d 0c  	ldrb	r0, [r7, #-13]
     904: c0 07        	lsls	r0, r0, #31
     906: 20 b9        	cbnz	r0, 0x912 <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h1229562b62a6e6aaE+0x4c> @ imm = #8
     908: ff e7        	b	0x90a <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h1229562b62a6e6aaE+0x44> @ imm = #-2
     90a: 17 f8 11 0c  	ldrb	r0, [r7, #-17]
     90e: 06 b0        	add	sp, #24
     910: 80 bd        	pop	{r7, pc}
     912: fa e7        	b	0x90a <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h1229562b62a6e6aaE+0x44> @ imm = #-12

00000914 <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h3668b64399714375E>:
     914: 80 b5        	push	{r7, lr}
     916: 6f 46        	mov	r7, sp
     918: 86 b0        	sub	sp, #24
     91a: 07 f8 12 0c  	strb	r0, [r7, #-18]
     91e: 01 20        	movs	r0, #1
     920: 07 f8 0d 0c  	strb	r0, [r7, #-13]
     924: 17 f8 12 1c  	ldrb	r1, [r7, #-18]
     928: c8 07        	lsls	r0, r1, #31
     92a: 10 b1        	cbz	r0, 0x932 <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h3668b64399714375E+0x1e> @ imm = #4
     92c: ff e7        	b	0x92e <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h3668b64399714375E+0x1a> @ imm = #-2
     92e: 04 e0        	b	0x93a <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h3668b64399714375E+0x26> @ imm = #8
     930: fe de        	trap
     932: 00 20        	movs	r0, #0
     934: 07 f8 11 0c  	strb	r0, [r7, #-17]
     938: 09 e0        	b	0x94e <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h3668b64399714375E+0x3a> @ imm = #18
     93a: 00 20        	movs	r0, #0
     93c: 07 f8 0d 0c  	strb	r0, [r7, #-13]
     940: 00 f0 28 f8  	bl	0x994 <core::ops::function::FnOnce::call_once::h0a081f00a2c9adfd> @ imm = #80
     944: ff e7        	b	0x946 <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h3668b64399714375E+0x32> @ imm = #-2
     946: 01 20        	movs	r0, #1
     948: 07 f8 11 0c  	strb	r0, [r7, #-17]
     94c: ff e7        	b	0x94e <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h3668b64399714375E+0x3a> @ imm = #-2
     94e: 17 f8 0d 0c  	ldrb	r0, [r7, #-13]
     952: c0 07        	lsls	r0, r0, #31
     954: 20 b9        	cbnz	r0, 0x960 <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h3668b64399714375E+0x4c> @ imm = #8
     956: ff e7        	b	0x958 <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h3668b64399714375E+0x44> @ imm = #-2
     958: 17 f8 11 0c  	ldrb	r0, [r7, #-17]
     95c: 06 b0        	add	sp, #24
     95e: 80 bd        	pop	{r7, pc}
     960: fa e7        	b	0x958 <_ZN4core6result19Result$LT$T$C$E$GT$7map_err17h3668b64399714375E+0x44> @ imm = #-12

00000962 <_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h623450f1d4fa2d26E>:
     962: 87 b0        	sub	sp, #28
     964: 00 90        	str	r0, [sp]
     966: 01 91        	str	r1, [sp, #4]
     968: 00 98        	ldr	r0, [sp]
     96a: 10 b1        	cbz	r0, 0x972 <_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h623450f1d4fa2d26E+0x10> @ imm = #4
     96c: ff e7        	b	0x96e <_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h623450f1d4fa2d26E+0xc> @ imm = #-2
     96e: 06 e0        	b	0x97e <_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h623450f1d4fa2d26E+0x1c> @ imm = #12
     970: fe de        	trap
     972: 01 98        	ldr	r0, [sp, #4]
     974: 06 90        	str	r0, [sp, #24]
     976: 03 90        	str	r0, [sp, #12]
     978: 00 20        	movs	r0, #0
     97a: 02 90        	str	r0, [sp, #8]
     97c: 02 e0        	b	0x984 <_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h623450f1d4fa2d26E+0x22> @ imm = #4
     97e: 01 20        	movs	r0, #1
     980: 02 90        	str	r0, [sp, #8]
     982: ff e7        	b	0x984 <_ZN79_$LT$core..result..Result$LT$T$C$E$GT$$u20$as$u20$core..ops..try_trait..Try$GT$6branch17h623450f1d4fa2d26E+0x22> @ imm = #-2
     984: 02 98        	ldr	r0, [sp, #8]
     986: 03 99        	ldr	r1, [sp, #12]
     988: 07 b0        	add	sp, #28
     98a: 70 47        	bx	lr

0000098c <core::mem::drop::h80fa3230a1ed09e0>:
     98c: 81 b0        	sub	sp, #4
     98e: ff e7        	b	0x990 <core::mem::drop::h80fa3230a1ed09e0+0x4> @ imm = #-2
     990: 01 b0        	add	sp, #4
     992: 70 47        	bx	lr

00000994 <core::ops::function::FnOnce::call_once::h0a081f00a2c9adfd>:
     994: 80 b5        	push	{r7, lr}
     996: 6f 46        	mov	r7, sp
     998: 82 b0        	sub	sp, #8
     99a: ff f7 f7 ff  	bl	0x98c <core::mem::drop::h80fa3230a1ed09e0> @ imm = #-18
     99e: ff e7        	b	0x9a0 <core::ops::function::FnOnce::call_once::h0a081f00a2c9adfd+0xc> @ imm = #-2
     9a0: 02 b0        	add	sp, #8
     9a2: 80 bd        	pop	{r7, pc}

000009a4 <<T as core::convert::From<T>>::from::h6f6f4b197e0033b6>:
     9a4: 81 b0        	sub	sp, #4
     9a6: 01 b0        	add	sp, #4
     9a8: 70 47        	bx	lr

000009aa <core::slice::<impl [T]>::is_empty::h002e6c4d8c458d08>:
     9aa: 82 b0        	sub	sp, #8
     9ac: 00 90        	str	r0, [sp]
     9ae: 01 91        	str	r1, [sp, #4]
     9b0: b1 fa 81 f0  	clz	r0, r1
     9b4: 40 09        	lsrs	r0, r0, #5
     9b6: 02 b0        	add	sp, #8
     9b8: 70 47        	bx	lr

000009ba <core::option::Option<T>::as_mut::h39e8044c8570ef77>:
     9ba: 84 b0        	sub	sp, #16
     9bc: 00 90        	str	r0, [sp]
     9be: 02 90        	str	r0, [sp, #8]
     9c0: 00 68        	ldr	r0, [r0]
     9c2: 10 b1        	cbz	r0, 0x9ca <core::option::Option<T>::as_mut::h39e8044c8570ef77+0x10> @ imm = #4
     9c4: ff e7        	b	0x9c6 <core::option::Option<T>::as_mut::h39e8044c8570ef77+0xc> @ imm = #-2
     9c6: 04 e0        	b	0x9d2 <core::option::Option<T>::as_mut::h39e8044c8570ef77+0x18> @ imm = #8
     9c8: fe de        	trap
     9ca: 00 20        	movs	r0, #0
     9cc: 01 90        	str	r0, [sp, #4]
     9ce: 01 90        	str	r0, [sp, #4]
     9d0: 04 e0        	b	0x9dc <core::option::Option<T>::as_mut::h39e8044c8570ef77+0x22> @ imm = #8
     9d2: 00 98        	ldr	r0, [sp]
     9d4: 04 30        	adds	r0, #4
     9d6: 03 90        	str	r0, [sp, #12]
     9d8: 01 90        	str	r0, [sp, #4]
     9da: ff e7        	b	0x9dc <core::option::Option<T>::as_mut::h39e8044c8570ef77+0x22> @ imm = #-2
     9dc: 01 98        	ldr	r0, [sp, #4]
     9de: 04 b0        	add	sp, #16
     9e0: 70 47        	bx	lr

000009e2 <core::option::Option<T>::unwrap::h18a111c0264e142f>:
     9e2: 80 b5        	push	{r7, lr}
     9e4: 6f 46        	mov	r7, sp
     9e6: 84 b0        	sub	sp, #16
     9e8: 01 91        	str	r1, [sp, #4]
     9ea: 02 90        	str	r0, [sp, #8]
     9ec: 02 98        	ldr	r0, [sp, #8]
     9ee: 00 28        	cmp	r0, #0
     9f0: 01 46        	mov	r1, r0
     9f2: 18 bf        	it	ne
     9f4: 01 21        	movne	r1, #1
     9f6: 10 b1        	cbz	r0, 0x9fe <core::option::Option<T>::unwrap::h18a111c0264e142f+0x1c> @ imm = #4
     9f8: ff e7        	b	0x9fa <core::option::Option<T>::unwrap::h18a111c0264e142f+0x18> @ imm = #-2
     9fa: 09 e0        	b	0xa10 <core::option::Option<T>::unwrap::h18a111c0264e142f+0x2e> @ imm = #18
     9fc: fe de        	trap
     9fe: 01 9a        	ldr	r2, [sp, #4]
     a00: 41 f6 b4 20  	movw	r0, #6836
     a04: c0 f2 00 00  	movt	r0, #0
     a08: 2b 21        	movs	r1, #43
     a0a: 00 f0 1c fa  	bl	0xe46 <core::panicking::panic::h270cbf344f752e6a> @ imm = #1080
     a0e: fe de        	trap
     a10: 02 98        	ldr	r0, [sp, #8]
     a12: 03 90        	str	r0, [sp, #12]
     a14: 04 b0        	add	sp, #16
     a16: 80 bd        	pop	{r7, pc}

00000a18 <core::option::Option<T>::is_none::h1c35b2f6357c702b>:
     a18: 80 b5        	push	{r7, lr}
     a1a: 6f 46        	mov	r7, sp
     a1c: 82 b0        	sub	sp, #8
     a1e: 01 90        	str	r0, [sp, #4]
     a20: 00 f0 07 f8  	bl	0xa32 <core::option::Option<T>::is_some::h101d69d82d432ca8> @ imm = #14
     a24: 00 90        	str	r0, [sp]
     a26: ff e7        	b	0xa28 <core::option::Option<T>::is_none::h1c35b2f6357c702b+0x10> @ imm = #-2
     a28: 00 99        	ldr	r1, [sp]
     a2a: 01 20        	movs	r0, #1
     a2c: 88 43        	bics	r0, r1
     a2e: 02 b0        	add	sp, #8
     a30: 80 bd        	pop	{r7, pc}

00000a32 <core::option::Option<T>::is_some::h101d69d82d432ca8>:
     a32: 82 b0        	sub	sp, #8
     a34: 01 90        	str	r0, [sp, #4]
     a36: 00 68        	ldr	r0, [r0]
     a38: 01 28        	cmp	r0, #1
     a3a: 04 d1        	bne	0xa46 <core::option::Option<T>::is_some::h101d69d82d432ca8+0x14> @ imm = #8
     a3c: ff e7        	b	0xa3e <core::option::Option<T>::is_some::h101d69d82d432ca8+0xc> @ imm = #-2
     a3e: 01 20        	movs	r0, #1
     a40: 8d f8 03 00  	strb.w	r0, [sp, #3]
     a44: 03 e0        	b	0xa4e <core::option::Option<T>::is_some::h101d69d82d432ca8+0x1c> @ imm = #6
     a46: 00 20        	movs	r0, #0
     a48: 8d f8 03 00  	strb.w	r0, [sp, #3]
     a4c: ff e7        	b	0xa4e <core::option::Option<T>::is_some::h101d69d82d432ca8+0x1c> @ imm = #-2
     a4e: 9d f8 03 00  	ldrb.w	r0, [sp, #3]
     a52: 02 b0        	add	sp, #8
     a54: 70 47        	bx	lr

00000a56 <cortex_m::interrupt::free::ha559729e22be581e>:
     a56: 80 b5        	push	{r7, lr}
     a58: 6f 46        	mov	r7, sp
     a5a: 88 b0        	sub	sp, #32
     a5c: 02 90        	str	r0, [sp, #8]
     a5e: 06 90        	str	r0, [sp, #24]
     a60: 00 f0 42 f8  	bl	0xae8 <cortex_m::register::primask::read::h28c0217b6433dbbb> @ imm = #132
     a64: 01 46        	mov	r1, r0
     a66: 03 91        	str	r1, [sp, #12]
     a68: 07 f8 02 0c  	strb	r0, [r7, #-2]
     a6c: ff e7        	b	0xa6e <cortex_m::interrupt::free::ha559729e22be581e+0x18> @ imm = #-2
     a6e: 00 f0 28 f8  	bl	0xac2 <cortex_m::interrupt::disable::he1cfdbd3aca1f303> @ imm = #80
     a72: ff e7        	b	0xa74 <cortex_m::interrupt::free::ha559729e22be581e+0x1e> @ imm = #-2
     a74: 00 f0 a6 f8  	bl	0xbc4 <bare_metal::CriticalSection::new::hc269a2e78b4f5d3c> @ imm = #332
     a78: ff e7        	b	0xa7a <cortex_m::interrupt::free::ha559729e22be581e+0x24> @ imm = #-2
     a7a: 02 98        	ldr	r0, [sp, #8]
     a7c: 05 a9        	add	r1, sp, #20
     a7e: 04 91        	str	r1, [sp, #16]
     a80: 04 99        	ldr	r1, [sp, #16]
     a82: ff f7 75 fd  	bl	0x570 <cortex_m_semihosting::export::hstdout_str::{{closure}}::hcf5f0a0f874dda2b> @ imm = #-1302
     a86: 01 46        	mov	r1, r0
     a88: 01 91        	str	r1, [sp, #4]
     a8a: 07 f8 01 0c  	strb	r0, [r7, #-1]
     a8e: ff e7        	b	0xa90 <cortex_m::interrupt::free::ha559729e22be581e+0x3a> @ imm = #-2
     a90: 03 98        	ldr	r0, [sp, #12]
     a92: 00 f0 01 00  	and	r0, r0, #1
     a96: 00 f0 40 f8  	bl	0xb1a <cortex_m::register::primask::Primask::is_active::h248fcf31179295b3> @ imm = #128
     a9a: 00 90        	str	r0, [sp]
     a9c: ff e7        	b	0xa9e <cortex_m::interrupt::free::ha559729e22be581e+0x48> @ imm = #-2
     a9e: 00 98        	ldr	r0, [sp]
     aa0: c0 07        	lsls	r0, r0, #31
     aa2: 28 b9        	cbnz	r0, 0xab0 <cortex_m::interrupt::free::ha559729e22be581e+0x5a> @ imm = #10
     aa4: ff e7        	b	0xaa6 <cortex_m::interrupt::free::ha559729e22be581e+0x50> @ imm = #-2
     aa6: 01 98        	ldr	r0, [sp, #4]
     aa8: 00 f0 01 00  	and	r0, r0, #1
     aac: 08 b0        	add	sp, #32
     aae: 80 bd        	pop	{r7, pc}
     ab0: 00 f0 01 f8  	bl	0xab6 <cortex_m::interrupt::enable::h840b176324dc0a8d> @ imm = #2
     ab4: f7 e7        	b	0xaa6 <cortex_m::interrupt::free::ha559729e22be581e+0x50> @ imm = #-18

00000ab6 <cortex_m::interrupt::enable::h840b176324dc0a8d>:
     ab6: 80 b5        	push	{r7, lr}
     ab8: 6f 46        	mov	r7, sp
     aba: 00 f0 79 f8  	bl	0xbb0 <__cpsie>         @ imm = #242
     abe: ff e7        	b	0xac0 <cortex_m::interrupt::enable::h840b176324dc0a8d+0xa> @ imm = #-2
     ac0: 80 bd        	pop	{r7, pc}

00000ac2 <cortex_m::interrupt::disable::he1cfdbd3aca1f303>:
     ac2: 80 b5        	push	{r7, lr}
     ac4: 6f 46        	mov	r7, sp
     ac6: 00 f0 71 f8  	bl	0xbac <__cpsid>         @ imm = #226
     aca: ff e7        	b	0xacc <cortex_m::interrupt::disable::he1cfdbd3aca1f303+0xa> @ imm = #-2
     acc: 80 bd        	pop	{r7, pc}

00000ace <<cortex_m::register::primask::Primask as core::cmp::PartialEq>::eq::h5bba1fb615695f4d>:
     ace: 84 b0        	sub	sp, #16
     ad0: 00 90        	str	r0, [sp]
     ad2: 01 91        	str	r1, [sp, #4]
     ad4: 00 78        	ldrb	r0, [r0]
     ad6: 02 90        	str	r0, [sp, #8]
     ad8: 09 78        	ldrb	r1, [r1]
     ada: 03 91        	str	r1, [sp, #12]
     adc: 40 1a        	subs	r0, r0, r1
     ade: b0 fa 80 f0  	clz	r0, r0
     ae2: 40 09        	lsrs	r0, r0, #5
     ae4: 04 b0        	add	sp, #16
     ae6: 70 47        	bx	lr

00000ae8 <cortex_m::register::primask::read::h28c0217b6433dbbb>:
     ae8: 80 b5        	push	{r7, lr}
     aea: 6f 46        	mov	r7, sp
     aec: 84 b0        	sub	sp, #16
     aee: 00 f0 61 f8  	bl	0xbb4 <__primask_r>     @ imm = #194
     af2: 01 46        	mov	r1, r0
     af4: 01 91        	str	r1, [sp, #4]
     af6: 03 90        	str	r0, [sp, #12]
     af8: ff e7        	b	0xafa <cortex_m::register::primask::read::h28c0217b6433dbbb+0x12> @ imm = #-2
     afa: 01 98        	ldr	r0, [sp, #4]
     afc: c0 07        	lsls	r0, r0, #31
     afe: 20 b9        	cbnz	r0, 0xb0a <cortex_m::register::primask::read::h28c0217b6433dbbb+0x22> @ imm = #8
     b00: ff e7        	b	0xb02 <cortex_m::register::primask::read::h28c0217b6433dbbb+0x1a> @ imm = #-2
     b02: 00 20        	movs	r0, #0
     b04: 07 f8 05 0c  	strb	r0, [r7, #-5]
     b08: 03 e0        	b	0xb12 <cortex_m::register::primask::read::h28c0217b6433dbbb+0x2a> @ imm = #6
     b0a: 01 20        	movs	r0, #1
     b0c: 07 f8 05 0c  	strb	r0, [r7, #-5]
     b10: ff e7        	b	0xb12 <cortex_m::register::primask::read::h28c0217b6433dbbb+0x2a> @ imm = #-2
     b12: 17 f8 05 0c  	ldrb	r0, [r7, #-5]
     b16: 04 b0        	add	sp, #16
     b18: 80 bd        	pop	{r7, pc}

00000b1a <cortex_m::register::primask::Primask::is_active::h248fcf31179295b3>:
     b1a: 80 b5        	push	{r7, lr}
     b1c: 6f 46        	mov	r7, sp
     b1e: 82 b0        	sub	sp, #8
     b20: 07 f8 01 0c  	strb	r0, [r7, #-1]
     b24: 41 f6 df 21  	movw	r1, #6879
     b28: c0 f2 00 01  	movt	r1, #0
     b2c: 78 1e        	subs	r0, r7, #1
     b2e: ff f7 ce ff  	bl	0xace <<cortex_m::register::primask::Primask as core::cmp::PartialEq>::eq::h5bba1fb615695f4d> @ imm = #-100
     b32: 00 90        	str	r0, [sp]
     b34: ff e7        	b	0xb36 <cortex_m::register::primask::Primask::is_active::h248fcf31179295b3+0x1c> @ imm = #-2
     b36: 00 98        	ldr	r0, [sp]
     b38: 00 f0 01 00  	and	r0, r0, #1
     b3c: 02 b0        	add	sp, #8
     b3e: 80 bd        	pop	{r7, pc}

00000b40 <__c_m_sh_syscall>:
     b40: ab be        	bkpt	#171
     b42: 70 47        	bx	lr

00000b44 <core::slice::raw::from_raw_parts::hfb378e54151e7aae>:
     b44: 80 b5        	push	{r7, lr}
     b46: 6f 46        	mov	r7, sp
     b48: 84 b0        	sub	sp, #16
     b4a: 02 90        	str	r0, [sp, #8]
     b4c: 03 91        	str	r1, [sp, #12]
     b4e: 00 f0 07 f8  	bl	0xb60 <core::ptr::slice_from_raw_parts::h8a52ade058133b58> @ imm = #14
     b52: 00 90        	str	r0, [sp]
     b54: 01 91        	str	r1, [sp, #4]
     b56: ff e7        	b	0xb58 <core::slice::raw::from_raw_parts::hfb378e54151e7aae+0x14> @ imm = #-2
     b58: 01 99        	ldr	r1, [sp, #4]
     b5a: 00 98        	ldr	r0, [sp]
     b5c: 04 b0        	add	sp, #16
     b5e: 80 bd        	pop	{r7, pc}

00000b60 <core::ptr::slice_from_raw_parts::h8a52ade058133b58>:
     b60: 80 b5        	push	{r7, lr}
     b62: 6f 46        	mov	r7, sp
     b64: 86 b0        	sub	sp, #24
     b66: 02 91        	str	r1, [sp, #8]
     b68: 04 90        	str	r0, [sp, #16]
     b6a: 05 91        	str	r1, [sp, #20]
     b6c: 00 f0 0d f8  	bl	0xb8a <core::ptr::const_ptr::<impl *const T>::cast::h142377e510bcc11e> @ imm = #26
     b70: 03 90        	str	r0, [sp, #12]
     b72: ff e7        	b	0xb74 <core::ptr::slice_from_raw_parts::h8a52ade058133b58+0x14> @ imm = #-2
     b74: 02 99        	ldr	r1, [sp, #8]
     b76: 03 98        	ldr	r0, [sp, #12]
     b78: 00 f0 0b f8  	bl	0xb92 <core::ptr::metadata::from_raw_parts::h8acfe3717788e838> @ imm = #22
     b7c: 00 90        	str	r0, [sp]
     b7e: 01 91        	str	r1, [sp, #4]
     b80: ff e7        	b	0xb82 <core::ptr::slice_from_raw_parts::h8a52ade058133b58+0x22> @ imm = #-2
     b82: 01 99        	ldr	r1, [sp, #4]
     b84: 00 98        	ldr	r0, [sp]
     b86: 06 b0        	add	sp, #24
     b88: 80 bd        	pop	{r7, pc}

00000b8a <core::ptr::const_ptr::<impl *const T>::cast::h142377e510bcc11e>:
     b8a: 81 b0        	sub	sp, #4
     b8c: 00 90        	str	r0, [sp]
     b8e: 01 b0        	add	sp, #4
     b90: 70 47        	bx	lr

00000b92 <core::ptr::metadata::from_raw_parts::h8acfe3717788e838>:
     b92: 86 b0        	sub	sp, #24
     b94: 04 90        	str	r0, [sp, #16]
     b96: 05 91        	str	r1, [sp, #20]
     b98: 02 90        	str	r0, [sp, #8]
     b9a: 03 91        	str	r1, [sp, #12]
     b9c: 02 99        	ldr	r1, [sp, #8]
     b9e: 03 98        	ldr	r0, [sp, #12]
     ba0: 00 91        	str	r1, [sp]
     ba2: 01 90        	str	r0, [sp, #4]
     ba4: 00 98        	ldr	r0, [sp]
     ba6: 01 99        	ldr	r1, [sp, #4]
     ba8: 06 b0        	add	sp, #24
     baa: 70 47        	bx	lr

00000bac <__cpsid>:
     bac: 72 b6        	cpsid i
     bae: 70 47        	bx	lr

00000bb0 <__cpsie>:
     bb0: 62 b6        	cpsie i
     bb2: 70 47        	bx	lr

00000bb4 <__primask_r>:
     bb4: ef f3 10 80  	mrs	r0, primask
     bb8: 70 47        	bx	lr

00000bba <core::slice::<impl [T]>::as_ptr::hc3fb7b6925bd1029>:
     bba: 82 b0        	sub	sp, #8
     bbc: 00 90        	str	r0, [sp]
     bbe: 01 91        	str	r1, [sp, #4]
     bc0: 02 b0        	add	sp, #8
     bc2: 70 47        	bx	lr

00000bc4 <bare_metal::CriticalSection::new::hc269a2e78b4f5d3c>:
     bc4: 70 47        	bx	lr

00000bc6 <UsageFault>:
     bc6: 80 b5        	push	{r7, lr}
     bc8: 6f 46        	mov	r7, sp
     bca: 82 b0        	sub	sp, #8
     bcc: ff e7        	b	0xbce <UsageFault+0x8>  @ imm = #-2
     bce: 04 20        	movs	r0, #4
     bd0: 07 f8 01 0c  	strb	r0, [r7, #-1]
     bd4: 17 f8 01 0c  	ldrb	r0, [r7, #-1]
     bd8: 00 f0 02 f8  	bl	0xbe0 <core::sync::atomic::compiler_fence::h8fb87df87ced713e> @ imm = #4
     bdc: f7 e7        	b	0xbce <UsageFault+0x8>  @ imm = #-18

00000bde <__pre_init>:
     bde: 70 47        	bx	lr

00000be0 <core::sync::atomic::compiler_fence::h8fb87df87ced713e>:
     be0: 80 b5        	push	{r7, lr}
     be2: 6f 46        	mov	r7, sp
     be4: 8a b0        	sub	sp, #40
     be6: 07 f8 19 0c  	strb	r0, [r7, #-25]
     bea: 17 f8 19 0c  	ldrb	r0, [r7, #-25]
     bee: 02 90        	str	r0, [sp, #8]
     bf0: 02 99        	ldr	r1, [sp, #8]
     bf2: df e8 01 f0  	tbb	[pc, r1]

00000bf6 <$d.1>:
     bf6:	04 14 15 16	.word	0x16151404
     bfa:	17 00		.short	0x0017

00000bfc <$t.2>:
     bfc: fe de        	trap
     bfe: 69 46        	mov	r1, sp
     c00: 00 20        	movs	r0, #0
     c02: 08 60        	str	r0, [r1]
     c04: 41 f6 14 31  	movw	r1, #6932
     c08: c0 f2 00 01  	movt	r1, #0
     c0c: 41 f6 1c 33  	movw	r3, #6940
     c10: c0 f2 00 03  	movt	r3, #0
     c14: 04 a8        	add	r0, sp, #16
     c16: 01 22        	movs	r2, #1
     c18: 00 f0 8e f8  	bl	0xd38 <core::fmt::Arguments::new_v1::h36055252fb015018> @ imm = #284
     c1c: 05 e0        	b	0xc2a <$t.2+0x2e>       @ imm = #10
     c1e: 02 e0        	b	0xc26 <$t.2+0x2a>       @ imm = #4
     c20: 01 e0        	b	0xc26 <$t.2+0x2a>       @ imm = #2
     c22: 00 e0        	b	0xc26 <$t.2+0x2a>       @ imm = #0
     c24: ff e7        	b	0xc26 <$t.2+0x2a>       @ imm = #-2
     c26: 0a b0        	add	sp, #40
     c28: 80 bd        	pop	{r7, pc}
     c2a: 41 f6 6c 31  	movw	r1, #7020
     c2e: c0 f2 00 01  	movt	r1, #0
     c32: 04 a8        	add	r0, sp, #16
     c34: 00 f0 1f f9  	bl	0xe76 <core::panicking::panic_fmt::h50c5062ff886a90c> @ imm = #574
     c38: fe de        	trap

00000c3a <r0::zero_bss::hfd898f235293eba1>:
     c3a: 80 b5        	push	{r7, lr}
     c3c: 6f 46        	mov	r7, sp
     c3e: 8c b0        	sub	sp, #48
     c40: 04 91        	str	r1, [sp, #16]
     c42: 05 90        	str	r0, [sp, #20]
     c44: 06 91        	str	r1, [sp, #24]
     c46: ff e7        	b	0xc48 <r0::zero_bss::hfd898f235293eba1+0xe> @ imm = #-2
     c48: 04 99        	ldr	r1, [sp, #16]
     c4a: 05 98        	ldr	r0, [sp, #20]
     c4c: 88 42        	cmp	r0, r1
     c4e: 02 d3        	blo	0xc56 <r0::zero_bss::hfd898f235293eba1+0x1c> @ imm = #4
     c50: ff e7        	b	0xc52 <r0::zero_bss::hfd898f235293eba1+0x18> @ imm = #-2
     c52: 0c b0        	add	sp, #48
     c54: 80 bd        	pop	{r7, pc}
     c56: 05 98        	ldr	r0, [sp, #20]
     c58: 02 90        	str	r0, [sp, #8]
     c5a: 00 f0 c3 f8  	bl	0xde4 <core::mem::maybe_uninit::MaybeUninit<T>::zeroed::hb530e3d2554bec6b> @ imm = #390
     c5e: 01 46        	mov	r1, r0
     c60: 03 91        	str	r1, [sp, #12]
     c62: 07 90        	str	r0, [sp, #28]
     c64: 08 90        	str	r0, [sp, #32]
     c66: ff e7        	b	0xc68 <r0::zero_bss::hfd898f235293eba1+0x2e> @ imm = #-2
     c68: 03 99        	ldr	r1, [sp, #12]
     c6a: 02 98        	ldr	r0, [sp, #8]
     c6c: 00 f0 3f f8  	bl	0xcee <core::ptr::write_volatile::h9f9cf77250869ae6> @ imm = #126
     c70: ff e7        	b	0xc72 <r0::zero_bss::hfd898f235293eba1+0x38> @ imm = #-2
     c72: 05 98        	ldr	r0, [sp, #20]
     c74: 09 90        	str	r0, [sp, #36]
     c76: 01 21        	movs	r1, #1
     c78: 0a 91        	str	r1, [sp, #40]
     c7a: 04 30        	adds	r0, #4
     c7c: 0b 90        	str	r0, [sp, #44]
     c7e: 0b 98        	ldr	r0, [sp, #44]
     c80: 01 90        	str	r0, [sp, #4]
     c82: ff e7        	b	0xc84 <r0::zero_bss::hfd898f235293eba1+0x4a> @ imm = #-2
     c84: 01 98        	ldr	r0, [sp, #4]
     c86: 05 90        	str	r0, [sp, #20]
     c88: de e7        	b	0xc48 <r0::zero_bss::hfd898f235293eba1+0xe> @ imm = #-68

00000c8a <r0::init_data::h7ead79b4d0cf8a3f>:
     c8a: 80 b5        	push	{r7, lr}
     c8c: 6f 46        	mov	r7, sp
     c8e: 8e b0        	sub	sp, #56
     c90: 04 91        	str	r1, [sp, #16]
     c92: 05 90        	str	r0, [sp, #20]
     c94: 06 92        	str	r2, [sp, #24]
     c96: 07 91        	str	r1, [sp, #28]
     c98: ff e7        	b	0xc9a <r0::init_data::h7ead79b4d0cf8a3f+0x10> @ imm = #-2
     c9a: 04 99        	ldr	r1, [sp, #16]
     c9c: 05 98        	ldr	r0, [sp, #20]
     c9e: 88 42        	cmp	r0, r1
     ca0: 02 d3        	blo	0xca8 <r0::init_data::h7ead79b4d0cf8a3f+0x1e> @ imm = #4
     ca2: ff e7        	b	0xca4 <r0::init_data::h7ead79b4d0cf8a3f+0x1a> @ imm = #-2
     ca4: 0e b0        	add	sp, #56
     ca6: 80 bd        	pop	{r7, pc}
     ca8: 05 98        	ldr	r0, [sp, #20]
     caa: 02 90        	str	r0, [sp, #8]
     cac: 06 98        	ldr	r0, [sp, #24]
     cae: 00 f0 25 f8  	bl	0xcfc <core::ptr::read::he74963328a401954> @ imm = #74
     cb2: 03 90        	str	r0, [sp, #12]
     cb4: ff e7        	b	0xcb6 <r0::init_data::h7ead79b4d0cf8a3f+0x2c> @ imm = #-2
     cb6: 03 99        	ldr	r1, [sp, #12]
     cb8: 02 98        	ldr	r0, [sp, #8]
     cba: 00 f0 33 f8  	bl	0xd24 <core::ptr::write::h3ea293ac685372cc> @ imm = #102
     cbe: ff e7        	b	0xcc0 <r0::init_data::h7ead79b4d0cf8a3f+0x36> @ imm = #-2
     cc0: 05 98        	ldr	r0, [sp, #20]
     cc2: 08 90        	str	r0, [sp, #32]
     cc4: 01 21        	movs	r1, #1
     cc6: 09 91        	str	r1, [sp, #36]
     cc8: 04 30        	adds	r0, #4
     cca: 0a 90        	str	r0, [sp, #40]
     ccc: 0a 98        	ldr	r0, [sp, #40]
     cce: 01 90        	str	r0, [sp, #4]
     cd0: ff e7        	b	0xcd2 <r0::init_data::h7ead79b4d0cf8a3f+0x48> @ imm = #-2
     cd2: 01 98        	ldr	r0, [sp, #4]
     cd4: 05 90        	str	r0, [sp, #20]
     cd6: 06 98        	ldr	r0, [sp, #24]
     cd8: 0b 90        	str	r0, [sp, #44]
     cda: 01 21        	movs	r1, #1
     cdc: 0c 91        	str	r1, [sp, #48]
     cde: 04 30        	adds	r0, #4
     ce0: 0d 90        	str	r0, [sp, #52]
     ce2: 0d 98        	ldr	r0, [sp, #52]
     ce4: 00 90        	str	r0, [sp]
     ce6: ff e7        	b	0xce8 <r0::init_data::h7ead79b4d0cf8a3f+0x5e> @ imm = #-2
     ce8: 00 98        	ldr	r0, [sp]
     cea: 06 90        	str	r0, [sp, #24]
     cec: d5 e7        	b	0xc9a <r0::init_data::h7ead79b4d0cf8a3f+0x10> @ imm = #-86

00000cee <core::ptr::write_volatile::h9f9cf77250869ae6>:
     cee: 82 b0        	sub	sp, #8
     cf0: 00 90        	str	r0, [sp]
     cf2: 01 91        	str	r1, [sp, #4]
     cf4: 01 60        	str	r1, [r0]
     cf6: ff e7        	b	0xcf8 <core::ptr::write_volatile::h9f9cf77250869ae6+0xa> @ imm = #-2
     cf8: 02 b0        	add	sp, #8
     cfa: 70 47        	bx	lr

00000cfc <core::ptr::read::he74963328a401954>:
     cfc: 88 b0        	sub	sp, #32
     cfe: 01 90        	str	r0, [sp, #4]
     d00: 03 90        	str	r0, [sp, #12]
     d02: 06 98        	ldr	r0, [sp, #24]
     d04: 02 90        	str	r0, [sp, #8]
     d06: ff e7        	b	0xd08 <core::ptr::read::he74963328a401954+0xc> @ imm = #-2
     d08: 02 a8        	add	r0, sp, #8
     d0a: 04 90        	str	r0, [sp, #16]
     d0c: ff e7        	b	0xd0e <core::ptr::read::he74963328a401954+0x12> @ imm = #-2
     d0e: 01 98        	ldr	r0, [sp, #4]
     d10: 00 68        	ldr	r0, [r0]
     d12: 02 90        	str	r0, [sp, #8]
     d14: 02 98        	ldr	r0, [sp, #8]
     d16: 00 90        	str	r0, [sp]
     d18: 05 90        	str	r0, [sp, #20]
     d1a: 07 90        	str	r0, [sp, #28]
     d1c: ff e7        	b	0xd1e <core::ptr::read::he74963328a401954+0x22> @ imm = #-2
     d1e: 00 98        	ldr	r0, [sp]
     d20: 08 b0        	add	sp, #32
     d22: 70 47        	bx	lr

00000d24 <core::ptr::write::h3ea293ac685372cc>:
     d24: 83 b0        	sub	sp, #12
     d26: 00 91        	str	r1, [sp]
     d28: 01 46        	mov	r1, r0
     d2a: 00 98        	ldr	r0, [sp]
     d2c: 01 90        	str	r0, [sp, #4]
     d2e: 02 91        	str	r1, [sp, #8]
     d30: 01 98        	ldr	r0, [sp, #4]
     d32: 08 60        	str	r0, [r1]
     d34: 03 b0        	add	sp, #12
     d36: 70 47        	bx	lr

00000d38 <core::fmt::Arguments::new_v1::h36055252fb015018>:
     d38: 80 b5        	push	{r7, lr}
     d3a: 6f 46        	mov	r7, sp
     d3c: 94 b0        	sub	sp, #80
     d3e: 02 93        	str	r3, [sp, #8]
     d40: 03 92        	str	r2, [sp, #12]
     d42: 04 91        	str	r1, [sp, #16]
     d44: 05 90        	str	r0, [sp, #20]
     d46: b8 68        	ldr	r0, [r7, #8]
     d48: 06 90        	str	r0, [sp, #24]
     d4a: 10 91        	str	r1, [sp, #64]
     d4c: 11 92        	str	r2, [sp, #68]
     d4e: 12 93        	str	r3, [sp, #72]
     d50: 13 90        	str	r0, [sp, #76]
     d52: 82 42        	cmp	r2, r0
     d54: 0a d3        	blo	0xd6c <core::fmt::Arguments::new_v1::h36055252fb015018+0x34> @ imm = #20
     d56: ff e7        	b	0xd58 <core::fmt::Arguments::new_v1::h36055252fb015018+0x20> @ imm = #-2
     d58: 03 99        	ldr	r1, [sp, #12]
     d5a: 06 98        	ldr	r0, [sp, #24]
     d5c: 42 1c        	adds	r2, r0, #1
     d5e: 00 20        	movs	r0, #0
     d60: 91 42        	cmp	r1, r2
     d62: 88 bf        	it	hi
     d64: 01 20        	movhi	r0, #1
     d66: 07 f8 31 0c  	strb	r0, [r7, #-49]
     d6a: 03 e0        	b	0xd74 <core::fmt::Arguments::new_v1::h36055252fb015018+0x3c> @ imm = #6
     d6c: 01 20        	movs	r0, #1
     d6e: 07 f8 31 0c  	strb	r0, [r7, #-49]
     d72: ff e7        	b	0xd74 <core::fmt::Arguments::new_v1::h36055252fb015018+0x3c> @ imm = #-2
     d74: 17 f8 31 0c  	ldrb	r0, [r7, #-49]
     d78: c0 07        	lsls	r0, r0, #31
     d7a: d8 b9        	cbnz	r0, 0xdb4 <core::fmt::Arguments::new_v1::h36055252fb015018+0x7c> @ imm = #54
     d7c: ff e7        	b	0xd7e <core::fmt::Arguments::new_v1::h36055252fb015018+0x46> @ imm = #-2
     d7e: 06 98        	ldr	r0, [sp, #24]
     d80: 05 99        	ldr	r1, [sp, #20]
     d82: 02 9a        	ldr	r2, [sp, #8]
     d84: 03 9b        	ldr	r3, [sp, #12]
     d86: dd f8 10 c0  	ldr.w	r12, [sp, #16]
     d8a: 4f f0 00 0e  	mov.w	lr, #0
     d8e: cd f8 3c e0  	str.w	lr, [sp, #60]
     d92: cd f8 38 e0  	str.w	lr, [sp, #56]
     d96: cd f8 38 e0  	str.w	lr, [sp, #56]
     d9a: c1 f8 00 c0  	str.w	r12, [r1]
     d9e: 4b 60        	str	r3, [r1, #4]
     da0: dd f8 38 c0  	ldr.w	r12, [sp, #56]
     da4: 0f 9b        	ldr	r3, [sp, #60]
     da6: c1 f8 08 c0  	str.w	r12, [r1, #8]
     daa: cb 60        	str	r3, [r1, #12]
     dac: 0a 61        	str	r2, [r1, #16]
     dae: 48 61        	str	r0, [r1, #20]
     db0: 14 b0        	add	sp, #80
     db2: 80 bd        	pop	{r7, pc}
     db4: 69 46        	mov	r1, sp
     db6: 00 20        	movs	r0, #0
     db8: 08 60        	str	r0, [r1]
     dba: 41 f6 88 31  	movw	r1, #7048
     dbe: c0 f2 00 01  	movt	r1, #0
     dc2: 41 f6 90 33  	movw	r3, #7056
     dc6: c0 f2 00 03  	movt	r3, #0
     dca: 08 a8        	add	r0, sp, #32
     dcc: 01 22        	movs	r2, #1
     dce: ff f7 b3 ff  	bl	0xd38 <core::fmt::Arguments::new_v1::h36055252fb015018> @ imm = #-154
     dd2: ff e7        	b	0xdd4 <core::fmt::Arguments::new_v1::h36055252fb015018+0x9c> @ imm = #-2
     dd4: 41 f6 dc 31  	movw	r1, #7132
     dd8: c0 f2 00 01  	movt	r1, #0
     ddc: 08 a8        	add	r0, sp, #32
     dde: 00 f0 4a f8  	bl	0xe76 <core::panicking::panic_fmt::h50c5062ff886a90c> @ imm = #148
     de2: fe de        	trap

00000de4 <core::mem::maybe_uninit::MaybeUninit<T>::zeroed::hb530e3d2554bec6b>:
     de4: 80 b5        	push	{r7, lr}
     de6: 6f 46        	mov	r7, sp
     de8: 86 b0        	sub	sp, #24
     dea: 02 98        	ldr	r0, [sp, #8]
     dec: 00 90        	str	r0, [sp]
     dee: ff e7        	b	0xdf0 <core::mem::maybe_uninit::MaybeUninit<T>::zeroed::hb530e3d2554bec6b+0xc> @ imm = #-2
     df0: 68 46        	mov	r0, sp
     df2: 01 90        	str	r0, [sp, #4]
     df4: ff e7        	b	0xdf6 <core::mem::maybe_uninit::MaybeUninit<T>::zeroed::hb530e3d2554bec6b+0x12> @ imm = #-2
     df6: 68 46        	mov	r0, sp
     df8: 03 90        	str	r0, [sp, #12]
     dfa: 00 21        	movs	r1, #0
     dfc: 07 f8 05 1c  	strb	r1, [r7, #-5]
     e00: 01 22        	movs	r2, #1
     e02: 05 92        	str	r2, [sp, #20]
     e04: 00 f0 04 f8  	bl	0xe10 <core::intrinsics::write_bytes::h72a2ad462b4fee65> @ imm = #8
     e08: ff e7        	b	0xe0a <core::mem::maybe_uninit::MaybeUninit<T>::zeroed::hb530e3d2554bec6b+0x26> @ imm = #-2
     e0a: 00 98        	ldr	r0, [sp]
     e0c: 06 b0        	add	sp, #24
     e0e: 80 bd        	pop	{r7, pc}

00000e10 <core::intrinsics::write_bytes::h72a2ad462b4fee65>:
     e10: 80 b5        	push	{r7, lr}
     e12: 6f 46        	mov	r7, sp
     e14: 84 b0        	sub	sp, #16
     e16: 00 92        	str	r2, [sp]
     e18: 0a 46        	mov	r2, r1
     e1a: 00 99        	ldr	r1, [sp]
     e1c: 01 90        	str	r0, [sp, #4]
     e1e: 07 f8 05 2c  	strb	r2, [r7, #-5]
     e22: 03 91        	str	r1, [sp, #12]
     e24: 89 00        	lsls	r1, r1, #2
     e26: d2 b2        	uxtb	r2, r2
     e28: 00 f0 5d fd  	bl	0x18e6 <__aeabi_memset4> @ imm = #2746
     e2c: ff e7        	b	0xe2e <core::intrinsics::write_bytes::h72a2ad462b4fee65+0x1e> @ imm = #-2
     e2e: 04 b0        	add	sp, #16
     e30: 80 bd        	pop	{r7, pc}

00000e32 <core::ptr::drop_in_place<&core::iter::adapters::copied::Copied<core::slice::iter::Iter<u8>>>::hb66371802af8cb69>:
     e32: 70 47        	bx	lr

00000e34 <<T as core::any::Any>::type_id::h8db430cca3d35d26>:
     e34: 42 f2 e0 30  	movw	r0, #9184
     e38: 44 f6 ba 31  	movw	r1, #19386
     e3c: c8 f2 ee 40  	movt	r0, #34030
     e40: cf f6 b7 71  	movt	r1, #65463
     e44: 70 47        	bx	lr

00000e46 <core::panicking::panic::h270cbf344f752e6a>:
     e46: 80 b5        	push	{r7, lr}
     e48: 6f 46        	mov	r7, sp
     e4a: 88 b0        	sub	sp, #32
     e4c: 94 46        	mov	r12, r2
     e4e: 41 f6 ec 32  	movw	r2, #7148
     e52: c0 f2 00 02  	movt	r2, #0
     e56: 00 23        	movs	r3, #0
     e58: cd e9 06 01  	strd	r0, r1, [sp, #24]
     e5c: 68 46        	mov	r0, sp
     e5e: 04 92        	str	r2, [sp, #16]
     e60: 01 22        	movs	r2, #1
     e62: 61 46        	mov	r1, r12
     e64: 01 92        	str	r2, [sp, #4]
     e66: 06 aa        	add	r2, sp, #24
     e68: 05 93        	str	r3, [sp, #20]
     e6a: cd e9 02 33  	strd	r3, r3, [sp, #8]
     e6e: 00 92        	str	r2, [sp]
     e70: 00 f0 01 f8  	bl	0xe76 <core::panicking::panic_fmt::h50c5062ff886a90c> @ imm = #2
     e74: fe de        	trap

00000e76 <core::panicking::panic_fmt::h50c5062ff886a90c>:
     e76: 80 b5        	push	{r7, lr}
     e78: 6f 46        	mov	r7, sp
     e7a: 86 b0        	sub	sp, #24
     e7c: cd e9 03 01  	strd	r0, r1, [sp, #12]
     e80: 41 f6 ec 30  	movw	r0, #7148
     e84: c0 f2 00 00  	movt	r0, #0
     e88: 01 22        	movs	r2, #1
     e8a: 02 90        	str	r0, [sp, #8]
     e8c: 41 f6 ec 30  	movw	r0, #7148
     e90: c0 f2 00 00  	movt	r0, #0
     e94: 8d f8 14 20  	strb.w	r2, [sp, #20]
     e98: 01 90        	str	r0, [sp, #4]
     e9a: 01 a8        	add	r0, sp, #4
     e9c: 00 f0 f8 fb  	bl	0x1690 <rust_begin_unwind> @ imm = #2032
     ea0: fe de        	trap

00000ea2 <core::result::unwrap_failed::h2638fbe3b922fd33>:
     ea2: 80 b5        	push	{r7, lr}
     ea4: 6f 46        	mov	r7, sp
     ea6: 8e b0        	sub	sp, #56
     ea8: 8d e8 0f 00  	stm.w	sp, {r0, r1, r2, r3}
     eac: 0a a9        	add	r1, sp, #40
     eae: 02 20        	movs	r0, #2
     eb0: 08 91        	str	r1, [sp, #32]
     eb2: 00 21        	movs	r1, #0
     eb4: 09 90        	str	r0, [sp, #36]
     eb6: cd e9 05 01  	strd	r0, r1, [sp, #20]
     eba: 41 f6 00 40  	movw	r0, #7168
     ebe: c0 f2 00 00  	movt	r0, #0
     ec2: 07 91        	str	r1, [sp, #28]
     ec4: 04 90        	str	r0, [sp, #16]
     ec6: 41 f2 7b 60  	movw	r0, #5755
     eca: c0 f2 00 00  	movt	r0, #0
     ece: b9 68        	ldr	r1, [r7, #8]
     ed0: 0d 90        	str	r0, [sp, #52]
     ed2: 02 a8        	add	r0, sp, #8
     ed4: 0c 90        	str	r0, [sp, #48]
     ed6: 41 f2 85 60  	movw	r0, #5765
     eda: c0 f2 00 00  	movt	r0, #0
     ede: 0b 90        	str	r0, [sp, #44]
     ee0: 68 46        	mov	r0, sp
     ee2: 0a 90        	str	r0, [sp, #40]
     ee4: 04 a8        	add	r0, sp, #16
     ee6: ff f7 c6 ff  	bl	0xe76 <core::panicking::panic_fmt::h50c5062ff886a90c> @ imm = #-116
     eea: fe de        	trap

00000eec <core::fmt::Formatter::pad::hc6b04d945a84cf61>:
     eec: f0 b5        	push	{r4, r5, r6, r7, lr}
     eee: 03 af        	add	r7, sp, #12
     ef0: 2d e9 00 0f  	push.w	{r8, r9, r10, r11}
     ef4: 81 b0        	sub	sp, #4
     ef6: 88 46        	mov	r8, r1
     ef8: d0 f8 08 c0  	ldr.w	r12, [r0, #8]
     efc: 01 69        	ldr	r1, [r0, #16]
     efe: 81 46        	mov	r9, r0
     f00: bc f1 01 0f  	cmp.w	r12, #1
     f04: 18 bf        	it	ne
     f06: 01 29        	cmpne	r1, #1
     f08: 23 d1        	bne	0xf52 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x66> @ imm = #70
     f0a: 01 29        	cmp	r1, #1
     f0c: 6f d1        	bne	0xfee <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x102> @ imm = #222
     f0e: d9 f8 14 30  	ldr.w	r3, [r9, #20]
     f12: 08 eb 02 01  	add.w	r1, r8, r2
     f16: 4f f0 00 0a  	mov.w	r10, #0
     f1a: 45 46        	mov	r5, r8
     f1c: 1b bb        	cbnz	r3, 0xf66 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x7a> @ imm = #70
     f1e: 8d 42        	cmp	r5, r1
     f20: 65 d0        	beq	0xfee <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x102> @ imm = #202
     f22: 95 f9 00 10  	ldrsb.w	r1, [r5]
     f26: b1 f1 ff 3f  	cmp.w	r1, #4294967295
     f2a: 04 dc        	bgt	0xf36 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x4a> @ imm = #8
     f2c: c9 b2        	uxtb	r1, r1
     f2e: e0 29        	cmp	r1, #224
     f30: 28 bf        	it	hs
     f32: f0 29        	cmphs	r1, #240
     f34: 47 d2        	bhs	0xfc6 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0xda> @ imm = #142
     f36: ba f1 00 0f  	cmp.w	r10, #0
     f3a: 3b d0        	beq	0xfb4 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0xc8> @ imm = #118
     f3c: 92 45        	cmp	r10, r2
     f3e: 37 d2        	bhs	0xfb0 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0xc4> @ imm = #110
     f40: 18 f9 0a 00  	ldrsb.w	r0, [r8, r10]
     f44: 10 f1 40 0f  	cmn.w	r0, #64
     f48: 34 da        	bge	0xfb4 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0xc8> @ imm = #104
     f4a: 00 21        	movs	r1, #0
     f4c: 4f f0 00 0a  	mov.w	r10, #0
     f50: 31 e0        	b	0xfb6 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0xca> @ imm = #98
     f52: d9 e9 06 01  	ldrd	r0, r1, [r9, #24]
     f56: b2 e0        	b	0x10be <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x1d2> @ imm = #356
     f58: b5 1c        	adds	r5, r6, #2
     f5a: aa eb 06 00  	sub.w	r0, r10, r6
     f5e: 01 3b        	subs	r3, #1
     f60: 00 eb 05 0a  	add.w	r10, r0, r5
     f64: db d0        	beq	0xf1e <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x32> @ imm = #-74
     f66: 8d 42        	cmp	r5, r1
     f68: 41 d0        	beq	0xfee <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x102> @ imm = #130
     f6a: 2e 46        	mov	r6, r5
     f6c: 15 f9 01 4b  	ldrsb	r4, [r5], #1
     f70: b4 f1 ff 3f  	cmp.w	r4, #4294967295
     f74: f1 dc        	bgt	0xf5a <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x6e> @ imm = #-30
     f76: e5 b2        	uxtb	r5, r4
     f78: e0 2d        	cmp	r5, #224
     f7a: ed d3        	blo	0xf58 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x6c> @ imm = #-38
     f7c: f0 2d        	cmp	r5, #240
     f7e: 15 d3        	blo	0xfac <core::fmt::Formatter::pad::hc6b04d945a84cf61+0xc0> @ imm = #42
     f80: b0 78        	ldrb	r0, [r6, #2]
     f82: 05 f0 07 05  	and	r5, r5, #7
     f86: 74 78        	ldrb	r4, [r6, #1]
     f88: 00 f0 3f 00  	and	r0, r0, #63
     f8c: 04 f0 3f 0e  	and	lr, r4, #63
     f90: f4 78        	ldrb	r4, [r6, #3]
     f92: 80 01        	lsls	r0, r0, #6
     f94: 40 ea 0e 30  	orr.w	r0, r0, lr, lsl #12
     f98: 04 f0 3f 04  	and	r4, r4, #63
     f9c: 20 44        	add	r0, r4
     f9e: 40 ea 85 40  	orr.w	r0, r0, r5, lsl #18
     fa2: b0 f5 88 1f  	cmp.w	r0, #1114112
     fa6: 22 d0        	beq	0xfee <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x102> @ imm = #68
     fa8: 35 1d        	adds	r5, r6, #4
     faa: d6 e7        	b	0xf5a <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x6e> @ imm = #-84
     fac: f5 1c        	adds	r5, r6, #3
     fae: d4 e7        	b	0xf5a <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x6e> @ imm = #-88
     fb0: 92 45        	cmp	r10, r2
     fb2: ca d1        	bne	0xf4a <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x5e> @ imm = #-108
     fb4: 41 46        	mov	r1, r8
     fb6: 00 29        	cmp	r1, #0
     fb8: 0c bf        	ite	eq
     fba: 92 46        	moveq	r10, r2
     fbc: 88 46        	movne	r8, r1
     fbe: bc f1 00 0f  	cmp.w	r12, #0
     fc2: 18 d1        	bne	0xff6 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x10a> @ imm = #48
     fc4: 76 e0        	b	0x10b4 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x1c8> @ imm = #236
     fc6: ab 78        	ldrb	r3, [r5, #2]
     fc8: 01 f0 07 01  	and	r1, r1, #7
     fcc: 68 78        	ldrb	r0, [r5, #1]
     fce: 03 f0 3f 03  	and	r3, r3, #63
     fd2: ee 78        	ldrb	r6, [r5, #3]
     fd4: 00 f0 3f 00  	and	r0, r0, #63
     fd8: 9b 01        	lsls	r3, r3, #6
     fda: 43 ea 00 30  	orr.w	r0, r3, r0, lsl #12
     fde: 06 f0 3f 03  	and	r3, r6, #63
     fe2: 18 44        	add	r0, r3
     fe4: 40 ea 81 40  	orr.w	r0, r0, r1, lsl #18
     fe8: b0 f5 88 1f  	cmp.w	r0, #1114112
     fec: a3 d1        	bne	0xf36 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x4a> @ imm = #-186
     fee: 92 46        	mov	r10, r2
     ff0: bc f1 00 0f  	cmp.w	r12, #0
     ff4: 5e d0        	beq	0x10b4 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x1c8> @ imm = #188
     ff6: d9 f8 0c 40  	ldr.w	r4, [r9, #12]
     ffa: ba f1 10 0f  	cmp.w	r10, #16
     ffe: 0b d2        	bhs	0x1018 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x12c> @ imm = #22
    1000: ba f1 00 0f  	cmp.w	r10, #0
    1004: 0d d0        	beq	0x1022 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x136> @ imm = #26
    1006: aa f1 01 00  	sub.w	r0, r10, #1
    100a: 0a f0 03 01  	and	r1, r10, #3
    100e: 03 28        	cmp	r0, #3
    1010: 09 d2        	bhs	0x1026 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x13a> @ imm = #18
    1012: 00 20        	movs	r0, #0
    1014: 42 46        	mov	r2, r8
    1016: 24 e0        	b	0x1062 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x176> @ imm = #72
    1018: 40 46        	mov	r0, r8
    101a: 51 46        	mov	r1, r10
    101c: 00 f0 95 f8  	bl	0x114a <core::str::count::do_count_chars::hb27a9e6e5078edb3> @ imm = #298
    1020: 36 e0        	b	0x1090 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x1a4> @ imm = #108
    1022: 00 20        	movs	r0, #0
    1024: 34 e0        	b	0x1090 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x1a4> @ imm = #104
    1026: 2a f0 03 03  	bic	r3, r10, #3
    102a: 00 20        	movs	r0, #0
    102c: 42 46        	mov	r2, r8
    102e: 12 f9 04 6b  	ldrsb	r6, [r2], #4
    1032: 16 f1 41 0f  	cmn.w	r6, #65
    1036: c8 bf        	it	gt
    1038: 01 30        	addgt	r0, #1
    103a: 12 f9 03 6c  	ldrsb	r6, [r2, #-3]
    103e: 16 f1 41 0f  	cmn.w	r6, #65
    1042: c8 bf        	it	gt
    1044: 01 30        	addgt	r0, #1
    1046: 12 f9 02 6c  	ldrsb	r6, [r2, #-2]
    104a: 16 f1 41 0f  	cmn.w	r6, #65
    104e: c8 bf        	it	gt
    1050: 01 30        	addgt	r0, #1
    1052: 12 f9 01 6c  	ldrsb	r6, [r2, #-1]
    1056: 16 f1 41 0f  	cmn.w	r6, #65
    105a: c8 bf        	it	gt
    105c: 01 30        	addgt	r0, #1
    105e: 04 3b        	subs	r3, #4
    1060: e5 d1        	bne	0x102e <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x142> @ imm = #-54
    1062: a9 b1        	cbz	r1, 0x1090 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x1a4> @ imm = #42
    1064: 92 f9 00 30  	ldrsb.w	r3, [r2]
    1068: 13 f1 41 0f  	cmn.w	r3, #65
    106c: c8 bf        	it	gt
    106e: 01 30        	addgt	r0, #1
    1070: 01 29        	cmp	r1, #1
    1072: 0d d0        	beq	0x1090 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x1a4> @ imm = #26
    1074: 92 f9 01 30  	ldrsb.w	r3, [r2, #1]
    1078: 13 f1 41 0f  	cmn.w	r3, #65
    107c: c8 bf        	it	gt
    107e: 01 30        	addgt	r0, #1
    1080: 02 29        	cmp	r1, #2
    1082: 05 d0        	beq	0x1090 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x1a4> @ imm = #10
    1084: 92 f9 02 10  	ldrsb.w	r1, [r2, #2]
    1088: 11 f1 41 0f  	cmn.w	r1, #65
    108c: c8 bf        	it	gt
    108e: 01 30        	addgt	r0, #1
    1090: 84 42        	cmp	r4, r0
    1092: 0f d9        	bls	0x10b4 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x1c8> @ imm = #30
    1094: 99 f8 20 10  	ldrb.w	r1, [r9, #32]
    1098: 45 46        	mov	r5, r8
    109a: ca 1e        	subs	r2, r1, #3
    109c: 18 bf        	it	ne
    109e: 0a 46        	movne	r2, r1
    10a0: 91 07        	lsls	r1, r2, #30
    10a2: a4 eb 00 01  	sub.w	r1, r4, r0
    10a6: 12 d0        	beq	0x10ce <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x1e2> @ imm = #36
    10a8: 01 2a        	cmp	r2, #1
    10aa: 12 d1        	bne	0x10d2 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x1e6> @ imm = #36
    10ac: 00 20        	movs	r0, #0
    10ae: 00 90        	str	r0, [sp]
    10b0: 08 46        	mov	r0, r1
    10b2: 12 e0        	b	0x10da <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x1ee> @ imm = #36
    10b4: d9 f8 1c 10  	ldr.w	r1, [r9, #28]
    10b8: 52 46        	mov	r2, r10
    10ba: d9 f8 18 00  	ldr.w	r0, [r9, #24]
    10be: cb 68        	ldr	r3, [r1, #12]
    10c0: 41 46        	mov	r1, r8
    10c2: 01 b0        	add	sp, #4
    10c4: bd e8 00 0f  	pop.w	{r8, r9, r10, r11}
    10c8: bd e8 f0 40  	pop.w	{r4, r5, r6, r7, lr}
    10cc: 18 47        	bx	r3
    10ce: 00 20        	movs	r0, #0
    10d0: 02 e0        	b	0x10d8 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x1ec> @ imm = #4
    10d2: 48 08        	lsrs	r0, r1, #1
    10d4: 01 31        	adds	r1, #1
    10d6: 49 08        	lsrs	r1, r1, #1
    10d8: 00 91        	str	r1, [sp]
    10da: d9 f8 04 40  	ldr.w	r4, [r9, #4]
    10de: 00 f1 01 0b  	add.w	r11, r0, #1
    10e2: d9 e9 06 86  	ldrd	r8, r6, [r9, #24]
    10e6: bb f1 01 0b  	subs.w	r11, r11, #1
    10ea: 06 d0        	beq	0x10fa <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x20e> @ imm = #12
    10ec: 32 69        	ldr	r2, [r6, #16]
    10ee: 40 46        	mov	r0, r8
    10f0: 21 46        	mov	r1, r4
    10f2: 90 47        	blx	r2
    10f4: 00 28        	cmp	r0, #0
    10f6: f6 d0        	beq	0x10e6 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x1fa> @ imm = #-20
    10f8: 0d e0        	b	0x1116 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x22a> @ imm = #26
    10fa: b4 f5 88 19  	subs.w	r9, r4, #1114112
    10fe: 00 98        	ldr	r0, [sp]
    1100: 18 bf        	it	ne
    1102: 81 46        	movne	r9, r0
    1104: b4 f5 88 1f  	cmp.w	r4, #1114112
    1108: 05 d0        	beq	0x1116 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x22a> @ imm = #10
    110a: f3 68        	ldr	r3, [r6, #12]
    110c: 40 46        	mov	r0, r8
    110e: 29 46        	mov	r1, r5
    1110: 52 46        	mov	r2, r10
    1112: 98 47        	blx	r3
    1114: 20 b1        	cbz	r0, 0x1120 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x234> @ imm = #8
    1116: 01 20        	movs	r0, #1
    1118: 01 b0        	add	sp, #4
    111a: bd e8 00 0f  	pop.w	{r8, r9, r10, r11}
    111e: f0 bd        	pop	{r4, r5, r6, r7, pc}
    1120: 00 25        	movs	r5, #0
    1122: a9 45        	cmp	r9, r5
    1124: 08 d0        	beq	0x1138 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x24c> @ imm = #16
    1126: 32 69        	ldr	r2, [r6, #16]
    1128: 40 46        	mov	r0, r8
    112a: 21 46        	mov	r1, r4
    112c: 90 47        	blx	r2
    112e: 01 35        	adds	r5, #1
    1130: 00 28        	cmp	r0, #0
    1132: f6 d0        	beq	0x1122 <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x236> @ imm = #-20
    1134: 69 1e        	subs	r1, r5, #1
    1136: 00 e0        	b	0x113a <core::fmt::Formatter::pad::hc6b04d945a84cf61+0x24e> @ imm = #0
    1138: 49 46        	mov	r1, r9
    113a: 00 20        	movs	r0, #0
    113c: 49 45        	cmp	r1, r9
    113e: 38 bf        	it	lo
    1140: 01 20        	movlo	r0, #1
    1142: 01 b0        	add	sp, #4
    1144: bd e8 00 0f  	pop.w	{r8, r9, r10, r11}
    1148: f0 bd        	pop	{r4, r5, r6, r7, pc}

0000114a <core::str::count::do_count_chars::hb27a9e6e5078edb3>:
    114a: f0 b5        	push	{r4, r5, r6, r7, lr}
    114c: 03 af        	add	r7, sp, #12
    114e: 2d e9 00 0f  	push.w	{r8, r9, r10, r11}
    1152: 81 b0        	sub	sp, #4
    1154: 02 46        	mov	r2, r0
    1156: 03 30        	adds	r0, #3
    1158: 20 f0 03 05  	bic	r5, r0, #3
    115c: a8 1a        	subs	r0, r5, r2
    115e: 88 42        	cmp	r0, r1
    1160: 98 bf        	it	ls
    1162: 04 28        	cmpls	r0, #4
    1164: 0c d9        	bls	0x1180 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x36> @ imm = #24
    1166: 31 b1        	cbz	r1, 0x1176 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x2c> @ imm = #12
    1168: 48 1e        	subs	r0, r1, #1
    116a: 01 f0 03 03  	and	r3, r1, #3
    116e: 03 28        	cmp	r0, #3
    1170: 16 d2        	bhs	0x11a0 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x56> @ imm = #44
    1172: 00 20        	movs	r0, #0
    1174: 31 e0        	b	0x11da <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x90> @ imm = #98
    1176: 00 20        	movs	r0, #0
    1178: 01 b0        	add	sp, #4
    117a: bd e8 00 0f  	pop.w	{r8, r9, r10, r11}
    117e: f0 bd        	pop	{r4, r5, r6, r7, pc}
    1180: 0e 1a        	subs	r6, r1, r0
    1182: 04 2e        	cmp	r6, #4
    1184: ef d3        	blo	0x1166 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x1c> @ imm = #-34
    1186: 14 18        	adds	r4, r2, r0
    1188: 06 f0 03 03  	and	r3, r6, #3
    118c: 00 28        	cmp	r0, #0
    118e: 40 d0        	beq	0x1212 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0xc8> @ imm = #128
    1190: d1 43        	mvns	r1, r2
    1192: 0d 44        	add	r5, r1
    1194: 00 f0 03 0c  	and	r12, r0, #3
    1198: 03 2d        	cmp	r5, #3
    119a: 3c d2        	bhs	0x1216 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0xcc> @ imm = #120
    119c: 00 20        	movs	r0, #0
    119e: 57 e0        	b	0x1250 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x106> @ imm = #174
    11a0: 21 f0 03 01  	bic	r1, r1, #3
    11a4: 00 20        	movs	r0, #0
    11a6: 12 f9 04 6b  	ldrsb	r6, [r2], #4
    11aa: 16 f1 41 0f  	cmn.w	r6, #65
    11ae: c8 bf        	it	gt
    11b0: 01 30        	addgt	r0, #1
    11b2: 12 f9 03 6c  	ldrsb	r6, [r2, #-3]
    11b6: 16 f1 41 0f  	cmn.w	r6, #65
    11ba: c8 bf        	it	gt
    11bc: 01 30        	addgt	r0, #1
    11be: 12 f9 02 6c  	ldrsb	r6, [r2, #-2]
    11c2: 16 f1 41 0f  	cmn.w	r6, #65
    11c6: c8 bf        	it	gt
    11c8: 01 30        	addgt	r0, #1
    11ca: 12 f9 01 6c  	ldrsb	r6, [r2, #-1]
    11ce: 16 f1 41 0f  	cmn.w	r6, #65
    11d2: c8 bf        	it	gt
    11d4: 01 30        	addgt	r0, #1
    11d6: 04 39        	subs	r1, #4
    11d8: e5 d1        	bne	0x11a6 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x5c> @ imm = #-54
    11da: 00 2b        	cmp	r3, #0
    11dc: cc d0        	beq	0x1178 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x2e> @ imm = #-104
    11de: 92 f9 00 10  	ldrsb.w	r1, [r2]
    11e2: 11 f1 41 0f  	cmn.w	r1, #65
    11e6: c8 bf        	it	gt
    11e8: 01 30        	addgt	r0, #1
    11ea: 01 2b        	cmp	r3, #1
    11ec: c4 d0        	beq	0x1178 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x2e> @ imm = #-120
    11ee: 92 f9 01 10  	ldrsb.w	r1, [r2, #1]
    11f2: 11 f1 41 0f  	cmn.w	r1, #65
    11f6: c8 bf        	it	gt
    11f8: 01 30        	addgt	r0, #1
    11fa: 02 2b        	cmp	r3, #2
    11fc: bc d0        	beq	0x1178 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x2e> @ imm = #-136
    11fe: 92 f9 02 10  	ldrsb.w	r1, [r2, #2]
    1202: 11 f1 41 0f  	cmn.w	r1, #65
    1206: c8 bf        	it	gt
    1208: 01 30        	addgt	r0, #1
    120a: 01 b0        	add	sp, #4
    120c: bd e8 00 0f  	pop.w	{r8, r9, r10, r11}
    1210: f0 bd        	pop	{r4, r5, r6, r7, pc}
    1212: 00 20        	movs	r0, #0
    1214: 37 e0        	b	0x1286 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x13c> @ imm = #110
    1216: 20 f0 03 05  	bic	r5, r0, #3
    121a: 00 20        	movs	r0, #0
    121c: 12 f9 04 1b  	ldrsb	r1, [r2], #4
    1220: 11 f1 41 0f  	cmn.w	r1, #65
    1224: c8 bf        	it	gt
    1226: 01 30        	addgt	r0, #1
    1228: 12 f9 03 1c  	ldrsb	r1, [r2, #-3]
    122c: 11 f1 41 0f  	cmn.w	r1, #65
    1230: c8 bf        	it	gt
    1232: 01 30        	addgt	r0, #1
    1234: 12 f9 02 1c  	ldrsb	r1, [r2, #-2]
    1238: 11 f1 41 0f  	cmn.w	r1, #65
    123c: c8 bf        	it	gt
    123e: 01 30        	addgt	r0, #1
    1240: 12 f9 01 1c  	ldrsb	r1, [r2, #-1]
    1244: 11 f1 41 0f  	cmn.w	r1, #65
    1248: c8 bf        	it	gt
    124a: 01 30        	addgt	r0, #1
    124c: 04 3d        	subs	r5, #4
    124e: e5 d1        	bne	0x121c <core::str::count::do_count_chars::hb27a9e6e5078edb3+0xd2> @ imm = #-54
    1250: bc f1 00 0f  	cmp.w	r12, #0
    1254: 17 d0        	beq	0x1286 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x13c> @ imm = #46
    1256: 92 f9 00 10  	ldrsb.w	r1, [r2]
    125a: 11 f1 41 0f  	cmn.w	r1, #65
    125e: c8 bf        	it	gt
    1260: 01 30        	addgt	r0, #1
    1262: bc f1 01 0f  	cmp.w	r12, #1
    1266: 0e d0        	beq	0x1286 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x13c> @ imm = #28
    1268: 92 f9 01 10  	ldrsb.w	r1, [r2, #1]
    126c: 11 f1 41 0f  	cmn.w	r1, #65
    1270: c8 bf        	it	gt
    1272: 01 30        	addgt	r0, #1
    1274: bc f1 02 0f  	cmp.w	r12, #2
    1278: 05 d0        	beq	0x1286 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x13c> @ imm = #10
    127a: 92 f9 02 10  	ldrsb.w	r1, [r2, #2]
    127e: 11 f1 41 0f  	cmn.w	r1, #65
    1282: c8 bf        	it	gt
    1284: 01 30        	addgt	r0, #1
    1286: 4f ea 96 0b  	lsr.w	r11, r6, #2
    128a: 00 22        	movs	r2, #0
    128c: c3 b1        	cbz	r3, 0x12c0 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x176> @ imm = #48
    128e: 26 f0 03 06  	bic	r6, r6, #3
    1292: 26 44        	add	r6, r4
    1294: 96 f9 00 50  	ldrsb.w	r5, [r6]
    1298: 15 f1 41 0f  	cmn.w	r5, #65
    129c: c8 bf        	it	gt
    129e: 01 22        	movgt	r2, #1
    12a0: 01 2b        	cmp	r3, #1
    12a2: 0d d0        	beq	0x12c0 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x176> @ imm = #26
    12a4: 96 f9 01 50  	ldrsb.w	r5, [r6, #1]
    12a8: 15 f1 41 0f  	cmn.w	r5, #65
    12ac: c8 bf        	it	gt
    12ae: 01 32        	addgt	r2, #1
    12b0: 02 2b        	cmp	r3, #2
    12b2: 05 d0        	beq	0x12c0 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x176> @ imm = #10
    12b4: 96 f9 02 30  	ldrsb.w	r3, [r6, #2]
    12b8: 13 f1 41 0f  	cmn.w	r3, #65
    12bc: c8 bf        	it	gt
    12be: 01 32        	addgt	r2, #1
    12c0: 10 44        	add	r0, r2
    12c2: 4f f0 ff 1e  	mov.w	lr, #16711935
    12c6: 10 e0        	b	0x12ea <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x1a0> @ imm = #32
    12c8: 0e ea 18 21  	and.w	r1, lr, r8, lsr #8
    12cc: 28 f0 ff 22  	bic	r2, r8, #4278255360
    12d0: 11 44        	add	r1, r2
    12d2: ab eb 0a 0b  	sub.w	r11, r11, r10
    12d6: 09 eb 8a 04  	add.w	r4, r9, r10, lsl #2
    12da: 1a f0 03 06  	ands	r6, r10, #3
    12de: 01 eb 01 41  	add.w	r1, r1, r1, lsl #16
    12e2: 00 eb 11 40  	add.w	r0, r0, r1, lsr #16
    12e6: 40 f0 4f 81  	bne.w	0x1588 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x43e> @ imm = #670
    12ea: bb f1 00 0f  	cmp.w	r11, #0
    12ee: 3f f4 43 af  	beq.w	0x1178 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x2e> @ imm = #-378
    12f2: da 46        	mov	r10, r11
    12f4: bb f1 c0 0f  	cmp.w	r11, #192
    12f8: a1 46        	mov	r9, r4
    12fa: 28 bf        	it	hs
    12fc: 4f f0 c0 0a  	movhs.w	r10, #192
    1300: 4f ea 9a 04  	lsr.w	r4, r10, #2
    1304: 4f f0 00 08  	mov.w	r8, #0
    1308: b8 eb 04 1f  	cmp.w	r8, r4, lsl #4
    130c: dc d0        	beq	0x12c8 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x17e> @ imm = #-72
    130e: 01 3c        	subs	r4, #1
    1310: 24 f0 70 44  	bic	r4, r4, #4026531840
    1314: 62 1c        	adds	r2, r4, #1
    1316: 03 2c        	cmp	r4, #3
    1318: 07 d2        	bhs	0x132a <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x1e0> @ imm = #14
    131a: 4f f0 00 08  	mov.w	r8, #0
    131e: 4c 46        	mov	r4, r9
    1320: 12 f0 03 0c  	ands	r12, r2, #3
    1324: 40 f0 b8 80  	bne.w	0x1498 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x34e> @ imm = #368
    1328: ce e7        	b	0x12c8 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x17e> @ imm = #-100
    132a: 4f f6 fc 71  	movw	r1, #65532
    132e: 4f f0 00 08  	mov.w	r8, #0
    1332: c1 f6 ff 71  	movt	r1, #8191
    1336: 02 ea 01 06  	and.w	r6, r2, r1
    133a: 4c 46        	mov	r4, r9
    133c: 00 92        	str	r2, [sp]
    133e: d4 e9 00 23  	ldrd	r2, r3, [r4]
    1342: 04 3e        	subs	r6, #4
    1344: d4 e9 02 1c  	ldrd	r1, r12, [r4, #8]
    1348: 6f ea 02 0e  	mvn.w	lr, r2
    134c: 4f ea de 15  	lsr.w	r5, lr, #7
    1350: 45 ea 92 12  	orr.w	r2, r5, r2, lsr #6
    1354: 6f ea 03 05  	mvn.w	r5, r3
    1358: 22 f0 fe 32  	bic	r2, r2, #4278124286
    135c: 4f ea d5 15  	lsr.w	r5, r5, #7
    1360: 45 ea 93 13  	orr.w	r3, r5, r3, lsr #6
    1364: 42 44        	add	r2, r8
    1366: 23 f0 fe 33  	bic	r3, r3, #4278124286
    136a: 1a 44        	add	r2, r3
    136c: 6f ea 01 03  	mvn.w	r3, r1
    1370: 4f ea d3 13  	lsr.w	r3, r3, #7
    1374: 43 ea 91 11  	orr.w	r1, r3, r1, lsr #6
    1378: 21 f0 fe 31  	bic	r1, r1, #4278124286
    137c: 11 44        	add	r1, r2
    137e: 6f ea 0c 02  	mvn.w	r2, r12
    1382: 4f ea d2 12  	lsr.w	r2, r2, #7
    1386: 42 ea 9c 12  	orr.w	r2, r2, r12, lsr #6
    138a: 22 f0 fe 32  	bic	r2, r2, #4278124286
    138e: 11 44        	add	r1, r2
    1390: 22 69        	ldr	r2, [r4, #16]
    1392: 6f ea 02 03  	mvn.w	r3, r2
    1396: 4f ea d3 13  	lsr.w	r3, r3, #7
    139a: 43 ea 92 12  	orr.w	r2, r3, r2, lsr #6
    139e: 22 f0 fe 32  	bic	r2, r2, #4278124286
    13a2: 11 44        	add	r1, r2
    13a4: 62 69        	ldr	r2, [r4, #20]
    13a6: 6f ea 02 03  	mvn.w	r3, r2
    13aa: 4f ea d3 13  	lsr.w	r3, r3, #7
    13ae: 43 ea 92 12  	orr.w	r2, r3, r2, lsr #6
    13b2: 22 f0 fe 32  	bic	r2, r2, #4278124286
    13b6: 11 44        	add	r1, r2
    13b8: a2 69        	ldr	r2, [r4, #24]
    13ba: 6f ea 02 03  	mvn.w	r3, r2
    13be: 4f ea d3 13  	lsr.w	r3, r3, #7
    13c2: 43 ea 92 12  	orr.w	r2, r3, r2, lsr #6
    13c6: 22 f0 fe 32  	bic	r2, r2, #4278124286
    13ca: 11 44        	add	r1, r2
    13cc: e2 69        	ldr	r2, [r4, #28]
    13ce: 6f ea 02 03  	mvn.w	r3, r2
    13d2: 4f ea d3 13  	lsr.w	r3, r3, #7
    13d6: 43 ea 92 12  	orr.w	r2, r3, r2, lsr #6
    13da: 22 f0 fe 32  	bic	r2, r2, #4278124286
    13de: 11 44        	add	r1, r2
    13e0: 22 6a        	ldr	r2, [r4, #32]
    13e2: 6f ea 02 03  	mvn.w	r3, r2
    13e6: 4f ea d3 13  	lsr.w	r3, r3, #7
    13ea: 43 ea 92 12  	orr.w	r2, r3, r2, lsr #6
    13ee: 22 f0 fe 32  	bic	r2, r2, #4278124286
    13f2: 11 44        	add	r1, r2
    13f4: 62 6a        	ldr	r2, [r4, #36]
    13f6: 6f ea 02 03  	mvn.w	r3, r2
    13fa: 4f ea d3 13  	lsr.w	r3, r3, #7
    13fe: 43 ea 92 12  	orr.w	r2, r3, r2, lsr #6
    1402: 22 f0 fe 32  	bic	r2, r2, #4278124286
    1406: 11 44        	add	r1, r2
    1408: a2 6a        	ldr	r2, [r4, #40]
    140a: 6f ea 02 03  	mvn.w	r3, r2
    140e: 4f ea d3 13  	lsr.w	r3, r3, #7
    1412: 43 ea 92 12  	orr.w	r2, r3, r2, lsr #6
    1416: 22 f0 fe 32  	bic	r2, r2, #4278124286
    141a: 11 44        	add	r1, r2
    141c: e2 6a        	ldr	r2, [r4, #44]
    141e: 6f ea 02 03  	mvn.w	r3, r2
    1422: 4f ea d3 13  	lsr.w	r3, r3, #7
    1426: 43 ea 92 12  	orr.w	r2, r3, r2, lsr #6
    142a: 22 f0 fe 32  	bic	r2, r2, #4278124286
    142e: 11 44        	add	r1, r2
    1430: 22 6b        	ldr	r2, [r4, #48]
    1432: 6f ea 02 03  	mvn.w	r3, r2
    1436: 4f ea d3 13  	lsr.w	r3, r3, #7
    143a: 43 ea 92 12  	orr.w	r2, r3, r2, lsr #6
    143e: 22 f0 fe 32  	bic	r2, r2, #4278124286
    1442: 11 44        	add	r1, r2
    1444: 62 6b        	ldr	r2, [r4, #52]
    1446: 6f ea 02 03  	mvn.w	r3, r2
    144a: 4f ea d3 13  	lsr.w	r3, r3, #7
    144e: 43 ea 92 12  	orr.w	r2, r3, r2, lsr #6
    1452: 22 f0 fe 32  	bic	r2, r2, #4278124286
    1456: 11 44        	add	r1, r2
    1458: a2 6b        	ldr	r2, [r4, #56]
    145a: 6f ea 02 03  	mvn.w	r3, r2
    145e: 4f ea d3 13  	lsr.w	r3, r3, #7
    1462: 43 ea 92 12  	orr.w	r2, r3, r2, lsr #6
    1466: 22 f0 fe 32  	bic	r2, r2, #4278124286
    146a: 11 44        	add	r1, r2
    146c: e2 6b        	ldr	r2, [r4, #60]
    146e: 04 f1 40 04  	add.w	r4, r4, #64
    1472: 6f ea 02 03  	mvn.w	r3, r2
    1476: 4f ea d3 13  	lsr.w	r3, r3, #7
    147a: 43 ea 92 12  	orr.w	r2, r3, r2, lsr #6
    147e: 22 f0 fe 32  	bic	r2, r2, #4278124286
    1482: 02 eb 01 08  	add.w	r8, r2, r1
    1486: 7f f4 5a af  	bne.w	0x133e <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x1f4> @ imm = #-332
    148a: 00 9a        	ldr	r2, [sp]
    148c: 4f f0 ff 1e  	mov.w	lr, #16711935
    1490: 12 f0 03 0c  	ands	r12, r2, #3
    1494: 3f f4 18 af  	beq.w	0x12c8 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x17e> @ imm = #-464
    1498: 94 e8 2e 00  	ldm.w	r4, {r1, r2, r3, r5}
    149c: bc f1 01 0f  	cmp.w	r12, #1
    14a0: 6f ea 01 06  	mvn.w	r6, r1
    14a4: 4f ea d6 16  	lsr.w	r6, r6, #7
    14a8: 46 ea 91 11  	orr.w	r1, r6, r1, lsr #6
    14ac: 6f ea 02 06  	mvn.w	r6, r2
    14b0: 21 f0 fe 31  	bic	r1, r1, #4278124286
    14b4: 4f ea d6 16  	lsr.w	r6, r6, #7
    14b8: 46 ea 92 12  	orr.w	r2, r6, r2, lsr #6
    14bc: 41 44        	add	r1, r8
    14be: 22 f0 fe 32  	bic	r2, r2, #4278124286
    14c2: 11 44        	add	r1, r2
    14c4: 6f ea 03 02  	mvn.w	r2, r3
    14c8: 4f ea d2 12  	lsr.w	r2, r2, #7
    14cc: 42 ea 93 12  	orr.w	r2, r2, r3, lsr #6
    14d0: 22 f0 fe 32  	bic	r2, r2, #4278124286
    14d4: 11 44        	add	r1, r2
    14d6: 6f ea 05 02  	mvn.w	r2, r5
    14da: 4f ea d2 12  	lsr.w	r2, r2, #7
    14de: 42 ea 95 12  	orr.w	r2, r2, r5, lsr #6
    14e2: 22 f0 fe 32  	bic	r2, r2, #4278124286
    14e6: 02 eb 01 08  	add.w	r8, r2, r1
    14ea: 3f f4 ed ae  	beq.w	0x12c8 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x17e> @ imm = #-550
    14ee: 04 f1 10 06  	add.w	r6, r4, #16
    14f2: bc f1 02 0f  	cmp.w	r12, #2
    14f6: 4e ce        	ldm	r6, {r1, r2, r3, r6}
    14f8: 6f ea 01 05  	mvn.w	r5, r1
    14fc: 4f ea d5 15  	lsr.w	r5, r5, #7
    1500: 45 ea 91 11  	orr.w	r1, r5, r1, lsr #6
    1504: 6f ea 02 05  	mvn.w	r5, r2
    1508: 21 f0 fe 31  	bic	r1, r1, #4278124286
    150c: 4f ea d5 15  	lsr.w	r5, r5, #7
    1510: 45 ea 92 12  	orr.w	r2, r5, r2, lsr #6
    1514: 41 44        	add	r1, r8
    1516: 22 f0 fe 32  	bic	r2, r2, #4278124286
    151a: 11 44        	add	r1, r2
    151c: 6f ea 03 02  	mvn.w	r2, r3
    1520: 4f ea d2 12  	lsr.w	r2, r2, #7
    1524: 42 ea 93 12  	orr.w	r2, r2, r3, lsr #6
    1528: 22 f0 fe 32  	bic	r2, r2, #4278124286
    152c: 11 44        	add	r1, r2
    152e: 6f ea 06 02  	mvn.w	r2, r6
    1532: 4f ea d2 12  	lsr.w	r2, r2, #7
    1536: 42 ea 96 12  	orr.w	r2, r2, r6, lsr #6
    153a: 22 f0 fe 32  	bic	r2, r2, #4278124286
    153e: 02 eb 01 08  	add.w	r8, r2, r1
    1542: 3f f4 c1 ae  	beq.w	0x12c8 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x17e> @ imm = #-638
    1546: 04 f1 20 06  	add.w	r6, r4, #32
    154a: 4e ce        	ldm	r6, {r1, r2, r3, r6}
    154c: cd 43        	mvns	r5, r1
    154e: ed 09        	lsrs	r5, r5, #7
    1550: 45 ea 91 11  	orr.w	r1, r5, r1, lsr #6
    1554: d5 43        	mvns	r5, r2
    1556: 21 f0 fe 31  	bic	r1, r1, #4278124286
    155a: ed 09        	lsrs	r5, r5, #7
    155c: 45 ea 92 12  	orr.w	r2, r5, r2, lsr #6
    1560: 41 44        	add	r1, r8
    1562: 22 f0 fe 32  	bic	r2, r2, #4278124286
    1566: 11 44        	add	r1, r2
    1568: da 43        	mvns	r2, r3
    156a: d2 09        	lsrs	r2, r2, #7
    156c: 42 ea 93 12  	orr.w	r2, r2, r3, lsr #6
    1570: 22 f0 fe 32  	bic	r2, r2, #4278124286
    1574: 11 44        	add	r1, r2
    1576: f2 43        	mvns	r2, r6
    1578: d2 09        	lsrs	r2, r2, #7
    157a: 42 ea 96 12  	orr.w	r2, r2, r6, lsr #6
    157e: 22 f0 fe 32  	bic	r2, r2, #4278124286
    1582: 02 eb 01 08  	add.w	r8, r2, r1
    1586: 9f e6        	b	0x12c8 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x17e> @ imm = #-706
    1588: 72 1e        	subs	r2, r6, #1
    158a: 0a f0 fc 01  	and	r1, r10, #252
    158e: 22 f0 40 46  	bic	r6, r2, #3221225472
    1592: 73 1c        	adds	r3, r6, #1
    1594: 09 eb 81 01  	add.w	r1, r9, r1, lsl #2
    1598: 03 f0 03 0c  	and	r12, r3, #3
    159c: 03 2e        	cmp	r6, #3
    159e: 02 d2        	bhs	0x15a6 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x45c> @ imm = #4
    15a0: 4f f0 00 0e  	mov.w	lr, #0
    15a4: 35 e0        	b	0x1612 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x4c8> @ imm = #106
    15a6: 4f f6 fc 72  	movw	r2, #65532
    15aa: 4f f0 00 0e  	mov.w	lr, #0
    15ae: c1 f6 ff 72  	movt	r2, #8191
    15b2: 02 f1 c0 46  	add.w	r6, r2, #1610612736
    15b6: 1e 40        	ands	r6, r3
    15b8: d1 e9 00 54  	ldrd	r5, r4, [r1]
    15bc: 04 3e        	subs	r6, #4
    15be: d1 e9 02 28  	ldrd	r2, r8, [r1, #8]
    15c2: 01 f1 10 01  	add.w	r1, r1, #16
    15c6: 6f ea 05 03  	mvn.w	r3, r5
    15ca: 4f ea d3 13  	lsr.w	r3, r3, #7
    15ce: 43 ea 95 13  	orr.w	r3, r3, r5, lsr #6
    15d2: 6f ea 04 05  	mvn.w	r5, r4
    15d6: 4f ea d5 15  	lsr.w	r5, r5, #7
    15da: 23 f0 fe 33  	bic	r3, r3, #4278124286
    15de: 45 ea 94 15  	orr.w	r5, r5, r4, lsr #6
    15e2: 73 44        	add	r3, lr
    15e4: 25 f0 fe 35  	bic	r5, r5, #4278124286
    15e8: 2b 44        	add	r3, r5
    15ea: 6f ea 02 05  	mvn.w	r5, r2
    15ee: 4f ea d5 15  	lsr.w	r5, r5, #7
    15f2: 45 ea 92 12  	orr.w	r2, r5, r2, lsr #6
    15f6: 22 f0 fe 32  	bic	r2, r2, #4278124286
    15fa: 1a 44        	add	r2, r3
    15fc: 6f ea 08 03  	mvn.w	r3, r8
    1600: 4f ea d3 13  	lsr.w	r3, r3, #7
    1604: 43 ea 98 13  	orr.w	r3, r3, r8, lsr #6
    1608: 23 f0 fe 33  	bic	r3, r3, #4278124286
    160c: 03 eb 02 0e  	add.w	lr, r3, r2
    1610: d2 d1        	bne	0x15b8 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x46e> @ imm = #-92
    1612: bc f1 00 0f  	cmp.w	r12, #0
    1616: 21 d0        	beq	0x165c <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x512> @ imm = #66
    1618: 0e 68        	ldr	r6, [r1]
    161a: bc f1 01 0f  	cmp.w	r12, #1
    161e: 6f ea 06 05  	mvn.w	r5, r6
    1622: 4f ea d5 15  	lsr.w	r5, r5, #7
    1626: 45 ea 96 16  	orr.w	r6, r5, r6, lsr #6
    162a: 26 f0 fe 36  	bic	r6, r6, #4278124286
    162e: b6 44        	add	lr, r6
    1630: 14 d0        	beq	0x165c <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x512> @ imm = #40
    1632: 4e 68        	ldr	r6, [r1, #4]
    1634: bc f1 02 0f  	cmp.w	r12, #2
    1638: 6f ea 06 05  	mvn.w	r5, r6
    163c: 4f ea d5 15  	lsr.w	r5, r5, #7
    1640: 45 ea 96 16  	orr.w	r6, r5, r6, lsr #6
    1644: 26 f0 fe 36  	bic	r6, r6, #4278124286
    1648: b6 44        	add	lr, r6
    164a: 07 d0        	beq	0x165c <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x512> @ imm = #14
    164c: 89 68        	ldr	r1, [r1, #8]
    164e: ca 43        	mvns	r2, r1
    1650: d2 09        	lsrs	r2, r2, #7
    1652: 42 ea 91 11  	orr.w	r1, r2, r1, lsr #6
    1656: 21 f0 fe 31  	bic	r1, r1, #4278124286
    165a: 8e 44        	add	lr, r1
    165c: 4f f0 ff 11  	mov.w	r1, #16711935
    1660: 2e f0 ff 22  	bic	r2, lr, #4278255360
    1664: 01 ea 1e 21  	and.w	r1, r1, lr, lsr #8
    1668: 11 44        	add	r1, r2
    166a: 01 eb 01 41  	add.w	r1, r1, r1, lsl #16
    166e: 00 eb 11 40  	add.w	r0, r0, r1, lsr #16
    1672: 01 b0        	add	sp, #4
    1674: bd e8 00 0f  	pop.w	{r8, r9, r10, r11}
    1678: f0 bd        	pop	{r4, r5, r6, r7, pc}

0000167a <<&T as core::fmt::Debug>::fmt::hdfe1d2c07b9aed64>:
    167a: d0 e9 00 20  	ldrd	r2, r0, [r0]
    167e: c3 68        	ldr	r3, [r0, #12]
    1680: 10 46        	mov	r0, r2
    1682: 18 47        	bx	r3

00001684 <<&T as core::fmt::Display>::fmt::hf6983f2c52cb1b63>:
    1684: 0b 46        	mov	r3, r1
    1686: d0 e9 00 12  	ldrd	r1, r2, [r0]
    168a: 18 46        	mov	r0, r3
    168c: ff f7 2e bc  	b.w	0xeec <core::fmt::Formatter::pad::hc6b04d945a84cf61> @ imm = #-1956

00001690 <rust_begin_unwind>:
    1690: 80 b5        	push	{r7, lr}
    1692: 6f 46        	mov	r7, sp
    1694: 82 b0        	sub	sp, #8
    1696: 01 90        	str	r0, [sp, #4]
    1698: ff e7        	b	0x169a <rust_begin_unwind+0xa> @ imm = #-2
    169a: 04 20        	movs	r0, #4
    169c: 07 f8 05 0c  	strb	r0, [r7, #-5]
    16a0: 17 f8 05 0c  	ldrb	r0, [r7, #-5]
    16a4: 00 f0 02 f8  	bl	0x16ac <core::sync::atomic::compiler_fence::ha154792cd852f72b> @ imm = #4
    16a8: f7 e7        	b	0x169a <rust_begin_unwind+0xa> @ imm = #-18
    16aa: d4 d4        	bmi	0x1656 <core::str::count::do_count_chars::hb27a9e6e5078edb3+0x50c> @ imm = #-88

000016ac <core::sync::atomic::compiler_fence::ha154792cd852f72b>:
    16ac: 80 b5        	push	{r7, lr}
    16ae: 6f 46        	mov	r7, sp
    16b0: 8a b0        	sub	sp, #40
    16b2: 07 f8 19 0c  	strb	r0, [r7, #-25]
    16b6: 17 f8 19 0c  	ldrb	r0, [r7, #-25]
    16ba: 02 90        	str	r0, [sp, #8]
    16bc: 02 99        	ldr	r1, [sp, #8]
    16be: df e8 01 f0  	tbb	[pc, r1]

000016c2 <$d.1>:
    16c2:	04 14 15 16	.word	0x16151404
    16c6:	17 00		.short	0x0017

000016c8 <$t.2>:
    16c8: fe de        	trap
    16ca: 69 46        	mov	r1, sp
    16cc: 00 20        	movs	r0, #0
    16ce: 08 60        	str	r0, [r1]
    16d0: 41 f6 44 41  	movw	r1, #7236
    16d4: c0 f2 00 01  	movt	r1, #0
    16d8: 41 f6 4c 43  	movw	r3, #7244
    16dc: c0 f2 00 03  	movt	r3, #0
    16e0: 04 a8        	add	r0, sp, #16
    16e2: 01 22        	movs	r2, #1
    16e4: 00 f0 0f f8  	bl	0x1706 <core::fmt::Arguments::new_v1::h7dc0c9534532dd14> @ imm = #30
    16e8: 05 e0        	b	0x16f6 <$t.2+0x2e>      @ imm = #10
    16ea: 02 e0        	b	0x16f2 <$t.2+0x2a>      @ imm = #4
    16ec: 01 e0        	b	0x16f2 <$t.2+0x2a>      @ imm = #2
    16ee: 00 e0        	b	0x16f2 <$t.2+0x2a>      @ imm = #0
    16f0: ff e7        	b	0x16f2 <$t.2+0x2a>      @ imm = #-2
    16f2: 0a b0        	add	sp, #40
    16f4: 80 bd        	pop	{r7, pc}
    16f6: 41 f6 9c 41  	movw	r1, #7324
    16fa: c0 f2 00 01  	movt	r1, #0
    16fe: 04 a8        	add	r0, sp, #16
    1700: ff f7 b9 fb  	bl	0xe76 <core::panicking::panic_fmt::h50c5062ff886a90c> @ imm = #-2190
    1704: fe de        	trap

00001706 <core::fmt::Arguments::new_v1::h7dc0c9534532dd14>:
    1706: 80 b5        	push	{r7, lr}
    1708: 6f 46        	mov	r7, sp
    170a: 94 b0        	sub	sp, #80
    170c: 02 93        	str	r3, [sp, #8]
    170e: 03 92        	str	r2, [sp, #12]
    1710: 04 91        	str	r1, [sp, #16]
    1712: 05 90        	str	r0, [sp, #20]
    1714: b8 68        	ldr	r0, [r7, #8]
    1716: 06 90        	str	r0, [sp, #24]
    1718: 10 91        	str	r1, [sp, #64]
    171a: 11 92        	str	r2, [sp, #68]
    171c: 12 93        	str	r3, [sp, #72]
    171e: 13 90        	str	r0, [sp, #76]
    1720: 82 42        	cmp	r2, r0
    1722: 0a d3        	blo	0x173a <core::fmt::Arguments::new_v1::h7dc0c9534532dd14+0x34> @ imm = #20
    1724: ff e7        	b	0x1726 <core::fmt::Arguments::new_v1::h7dc0c9534532dd14+0x20> @ imm = #-2
    1726: 03 99        	ldr	r1, [sp, #12]
    1728: 06 98        	ldr	r0, [sp, #24]
    172a: 42 1c        	adds	r2, r0, #1
    172c: 00 20        	movs	r0, #0
    172e: 91 42        	cmp	r1, r2
    1730: 88 bf        	it	hi
    1732: 01 20        	movhi	r0, #1
    1734: 07 f8 31 0c  	strb	r0, [r7, #-49]
    1738: 03 e0        	b	0x1742 <core::fmt::Arguments::new_v1::h7dc0c9534532dd14+0x3c> @ imm = #6
    173a: 01 20        	movs	r0, #1
    173c: 07 f8 31 0c  	strb	r0, [r7, #-49]
    1740: ff e7        	b	0x1742 <core::fmt::Arguments::new_v1::h7dc0c9534532dd14+0x3c> @ imm = #-2
    1742: 17 f8 31 0c  	ldrb	r0, [r7, #-49]
    1746: c0 07        	lsls	r0, r0, #31
    1748: d8 b9        	cbnz	r0, 0x1782 <core::fmt::Arguments::new_v1::h7dc0c9534532dd14+0x7c> @ imm = #54
    174a: ff e7        	b	0x174c <core::fmt::Arguments::new_v1::h7dc0c9534532dd14+0x46> @ imm = #-2
    174c: 06 98        	ldr	r0, [sp, #24]
    174e: 05 99        	ldr	r1, [sp, #20]
    1750: 02 9a        	ldr	r2, [sp, #8]
    1752: 03 9b        	ldr	r3, [sp, #12]
    1754: dd f8 10 c0  	ldr.w	r12, [sp, #16]
    1758: 4f f0 00 0e  	mov.w	lr, #0
    175c: cd f8 3c e0  	str.w	lr, [sp, #60]
    1760: cd f8 38 e0  	str.w	lr, [sp, #56]
    1764: cd f8 38 e0  	str.w	lr, [sp, #56]
    1768: c1 f8 00 c0  	str.w	r12, [r1]
    176c: 4b 60        	str	r3, [r1, #4]
    176e: dd f8 38 c0  	ldr.w	r12, [sp, #56]
    1772: 0f 9b        	ldr	r3, [sp, #60]
    1774: c1 f8 08 c0  	str.w	r12, [r1, #8]
    1778: cb 60        	str	r3, [r1, #12]
    177a: 0a 61        	str	r2, [r1, #16]
    177c: 48 61        	str	r0, [r1, #20]
    177e: 14 b0        	add	sp, #80
    1780: 80 bd        	pop	{r7, pc}
    1782: 69 46        	mov	r1, sp
    1784: 00 20        	movs	r0, #0
    1786: 08 60        	str	r0, [r1]
    1788: 41 f6 b8 41  	movw	r1, #7352
    178c: c0 f2 00 01  	movt	r1, #0
    1790: 41 f6 c0 43  	movw	r3, #7360
    1794: c0 f2 00 03  	movt	r3, #0
    1798: 08 a8        	add	r0, sp, #32
    179a: 01 22        	movs	r2, #1
    179c: ff f7 b3 ff  	bl	0x1706 <core::fmt::Arguments::new_v1::h7dc0c9534532dd14> @ imm = #-154
    17a0: ff e7        	b	0x17a2 <core::fmt::Arguments::new_v1::h7dc0c9534532dd14+0x9c> @ imm = #-2
    17a2: 41 f6 0c 51  	movw	r1, #7436
    17a6: c0 f2 00 01  	movt	r1, #0
    17aa: 08 a8        	add	r0, sp, #32
    17ac: ff f7 63 fb  	bl	0xe76 <core::panicking::panic_fmt::h50c5062ff886a90c> @ imm = #-2362
    17b0: fe de        	trap

000017b2 <compiler_builtins::arm::__aeabi_memset::h97dd7ff4fcbdab78>:
    17b2: 0b 46        	mov	r3, r1
    17b4: 11 46        	mov	r1, r2
    17b6: 1a 46        	mov	r2, r3
    17b8: 00 f0 46 b8  	b.w	0x1848 <compiler_builtins::mem::memset::hcaff16a87bfdb538> @ imm = #140

000017bc <compiler_builtins::arm::__aeabi_memset4::h4fa6db716820ea07>:
    17bc: d0 b5        	push	{r4, r6, r7, lr}
    17be: 02 af        	add	r7, sp, #8
    17c0: 13 46        	mov	r3, r2
    17c2: d2 b2        	uxtb	r2, r2
    17c4: 04 29        	cmp	r1, #4
    17c6: 39 d3        	blo	0x183c <compiler_builtins::arm::__aeabi_memset4::h4fa6db716820ea07+0x80> @ imm = #114
    17c8: 14 04        	lsls	r4, r2, #16
    17ca: a1 f1 04 0e  	sub.w	lr, r1, #4
    17ce: 44 ea 03 63  	orr.w	r3, r4, r3, lsl #24
    17d2: 01 24        	movs	r4, #1
    17d4: 43 ea 02 23  	orr.w	r3, r3, r2, lsl #8
    17d8: 04 eb 9e 04  	add.w	r4, r4, lr, lsr #2
    17dc: 13 44        	add	r3, r2
    17de: 14 f0 03 04  	ands	r4, r4, #3
    17e2: 0a d0        	beq	0x17fa <compiler_builtins::arm::__aeabi_memset4::h4fa6db716820ea07+0x3e> @ imm = #20
    17e4: 84 46        	mov	r12, r0
    17e6: 01 2c        	cmp	r4, #1
    17e8: 4c f8 04 3b  	str	r3, [r12], #4
    17ec: 0d d1        	bne	0x180a <compiler_builtins::arm::__aeabi_memset4::h4fa6db716820ea07+0x4e> @ imm = #26
    17ee: 60 46        	mov	r0, r12
    17f0: 71 46        	mov	r1, lr
    17f2: be f1 0c 0f  	cmp.w	lr, #12
    17f6: 19 d2        	bhs	0x182c <compiler_builtins::arm::__aeabi_memset4::h4fa6db716820ea07+0x70> @ imm = #50
    17f8: 02 e0        	b	0x1800 <compiler_builtins::arm::__aeabi_memset4::h4fa6db716820ea07+0x44> @ imm = #4
    17fa: be f1 0c 0f  	cmp.w	lr, #12
    17fe: 15 d2        	bhs	0x182c <compiler_builtins::arm::__aeabi_memset4::h4fa6db716820ea07+0x70> @ imm = #42
    1800: 60 46        	mov	r0, r12
    1802: bd e8 d0 40  	pop.w	{r4, r6, r7, lr}
    1806: ff f7 d4 bf  	b.w	0x17b2 <compiler_builtins::arm::__aeabi_memset::h97dd7ff4fcbdab78> @ imm = #-88
    180a: 02 2c        	cmp	r4, #2
    180c: 43 60        	str	r3, [r0, #4]
    180e: 06 d1        	bne	0x181e <compiler_builtins::arm::__aeabi_memset4::h4fa6db716820ea07+0x62> @ imm = #12
    1810: 08 39        	subs	r1, #8
    1812: 08 30        	adds	r0, #8
    1814: 84 46        	mov	r12, r0
    1816: be f1 0c 0f  	cmp.w	lr, #12
    181a: 07 d2        	bhs	0x182c <compiler_builtins::arm::__aeabi_memset4::h4fa6db716820ea07+0x70> @ imm = #14
    181c: f0 e7        	b	0x1800 <compiler_builtins::arm::__aeabi_memset4::h4fa6db716820ea07+0x44> @ imm = #-32
    181e: 83 60        	str	r3, [r0, #8]
    1820: 0c 39        	subs	r1, #12
    1822: 0c 30        	adds	r0, #12
    1824: 84 46        	mov	r12, r0
    1826: be f1 0c 0f  	cmp.w	lr, #12
    182a: e9 d3        	blo	0x1800 <compiler_builtins::arm::__aeabi_memset4::h4fa6db716820ea07+0x44> @ imm = #-46
    182c: 10 39        	subs	r1, #16
    182e: c0 e9 00 33  	strd	r3, r3, [r0]
    1832: c0 e9 02 33  	strd	r3, r3, [r0, #8]
    1836: 10 30        	adds	r0, #16
    1838: 03 29        	cmp	r1, #3
    183a: f7 d8        	bhi	0x182c <compiler_builtins::arm::__aeabi_memset4::h4fa6db716820ea07+0x70> @ imm = #-18
    183c: 84 46        	mov	r12, r0
    183e: 60 46        	mov	r0, r12
    1840: bd e8 d0 40  	pop.w	{r4, r6, r7, lr}
    1844: ff f7 b5 bf  	b.w	0x17b2 <compiler_builtins::arm::__aeabi_memset::h97dd7ff4fcbdab78> @ imm = #-150

00001848 <compiler_builtins::mem::memset::hcaff16a87bfdb538>:
    1848: d0 b5        	push	{r4, r6, r7, lr}
    184a: 02 af        	add	r7, sp, #8
    184c: 0f 2a        	cmp	r2, #15
    184e: 36 d9        	bls	0x18be <compiler_builtins::mem::memset::hcaff16a87bfdb538+0x76> @ imm = #108
    1850: 43 42        	rsbs	r3, r0, #0
    1852: 13 f0 03 0e  	ands	lr, r3, #3
    1856: 00 eb 0e 0c  	add.w	r12, r0, lr
    185a: 10 d0        	beq	0x187e <compiler_builtins::mem::memset::hcaff16a87bfdb538+0x36> @ imm = #32
    185c: 03 46        	mov	r3, r0
    185e: 03 f8 01 1b  	strb	r1, [r3], #1
    1862: 63 45        	cmp	r3, r12
    1864: 0b d2        	bhs	0x187e <compiler_builtins::mem::memset::hcaff16a87bfdb538+0x36> @ imm = #22
    1866: 03 f8 01 1b  	strb	r1, [r3], #1
    186a: 63 45        	cmp	r3, r12
    186c: 3c bf        	itt	lo
    186e: 03 f8 01 1b  	strblo	r1, [r3], #1
    1872: 63 45        	cmplo	r3, r12
    1874: 03 d2        	bhs	0x187e <compiler_builtins::mem::memset::hcaff16a87bfdb538+0x36> @ imm = #6
    1876: 03 f8 01 1b  	strb	r1, [r3], #1
    187a: 63 45        	cmp	r3, r12
    187c: ef d3        	blo	0x185e <compiler_builtins::mem::memset::hcaff16a87bfdb538+0x16> @ imm = #-34
    187e: a2 eb 0e 0e  	sub.w	lr, r2, lr
    1882: 2e f0 03 02  	bic	r2, lr, #3
    1886: 0c eb 02 03  	add.w	r3, r12, r2
    188a: 01 2a        	cmp	r2, #1
    188c: 13 db        	blt	0x18b6 <compiler_builtins::mem::memset::hcaff16a87bfdb538+0x6e> @ imm = #38
    188e: ca b2        	uxtb	r2, r1
    1890: 4f f0 01 34  	mov.w	r4, #16843009
    1894: 62 43        	muls	r2, r4, r2
    1896: 4c f8 04 2b  	str	r2, [r12], #4
    189a: 9c 45        	cmp	r12, r3
    189c: 0b d2        	bhs	0x18b6 <compiler_builtins::mem::memset::hcaff16a87bfdb538+0x6e> @ imm = #22
    189e: 4c f8 04 2b  	str	r2, [r12], #4
    18a2: 9c 45        	cmp	r12, r3
    18a4: 3c bf        	itt	lo
    18a6: 4c f8 04 2b  	strlo	r2, [r12], #4
    18aa: 9c 45        	cmplo	r12, r3
    18ac: 03 d2        	bhs	0x18b6 <compiler_builtins::mem::memset::hcaff16a87bfdb538+0x6e> @ imm = #6
    18ae: 4c f8 04 2b  	str	r2, [r12], #4
    18b2: 9c 45        	cmp	r12, r3
    18b4: ef d3        	blo	0x1896 <compiler_builtins::mem::memset::hcaff16a87bfdb538+0x4e> @ imm = #-34
    18b6: 0e f0 03 02  	and	r2, lr, #3
    18ba: 12 b9        	cbnz	r2, 0x18c2 <compiler_builtins::mem::memset::hcaff16a87bfdb538+0x7a> @ imm = #4
    18bc: 12 e0        	b	0x18e4 <compiler_builtins::mem::memset::hcaff16a87bfdb538+0x9c> @ imm = #36
    18be: 03 46        	mov	r3, r0
    18c0: 82 b1        	cbz	r2, 0x18e4 <compiler_builtins::mem::memset::hcaff16a87bfdb538+0x9c> @ imm = #32
    18c2: 1a 44        	add	r2, r3
    18c4: 03 f8 01 1b  	strb	r1, [r3], #1
    18c8: 93 42        	cmp	r3, r2
    18ca: 0b d2        	bhs	0x18e4 <compiler_builtins::mem::memset::hcaff16a87bfdb538+0x9c> @ imm = #22
    18cc: 03 f8 01 1b  	strb	r1, [r3], #1
    18d0: 93 42        	cmp	r3, r2
    18d2: 3c bf        	itt	lo
    18d4: 03 f8 01 1b  	strblo	r1, [r3], #1
    18d8: 93 42        	cmplo	r3, r2
    18da: 03 d2        	bhs	0x18e4 <compiler_builtins::mem::memset::hcaff16a87bfdb538+0x9c> @ imm = #6
    18dc: 03 f8 01 1b  	strb	r1, [r3], #1
    18e0: 93 42        	cmp	r3, r2
    18e2: ef d3        	blo	0x18c4 <compiler_builtins::mem::memset::hcaff16a87bfdb538+0x7c> @ imm = #-34
    18e4: d0 bd        	pop	{r4, r6, r7, pc}

000018e6 <__aeabi_memset4>:
    18e6: ff f7 69 bf  	b.w	0x17bc <compiler_builtins::arm::__aeabi_memset4::h4fa6db716820ea07> @ imm = #-302

000018ea <HardFaultTrampoline>:
    18ea: 70 46        	mov	r0, lr
    18ec: 04 21        	movs	r1, #4
    18ee: 08 42        	tst	r0, r1
    18f0: 02 d1        	bne	0x18f8 <HardFaultTrampoline+0xe> @ imm = #4
    18f2: ef f3 08 80  	mrs	r0, msp
    18f6: 02 e0        	b	0x18fe <HardFault_>     @ imm = #4
    18f8: ef f3 09 80  	mrs	r0, psp
    18fc: ff e7        	b	0x18fe <HardFault_>     @ imm = #-2

000018fe <HardFault_>:
    18fe: 80 b5        	push	{r7, lr}
    1900: 6f 46        	mov	r7, sp
    1902: 82 b0        	sub	sp, #8
    1904: 01 90        	str	r0, [sp, #4]
    1906: ff e7        	b	0x1908 <HardFault_+0xa> @ imm = #-2
    1908: 04 20        	movs	r0, #4
    190a: 07 f8 05 0c  	strb	r0, [r7, #-5]
    190e: 17 f8 05 0c  	ldrb	r0, [r7, #-5]
    1912: ff f7 65 f9  	bl	0xbe0 <core::sync::atomic::compiler_fence::h8fb87df87ced713e> @ imm = #-3382
    1916: f7 e7        	b	0x1908 <HardFault_+0xa> @ imm = #-18
