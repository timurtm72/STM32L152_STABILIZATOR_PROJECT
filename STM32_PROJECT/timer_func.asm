_main_timer_func:
;timer_func.c,3 :: 		void main_timer_func() iv IVT_INT_TIM2 ics ICS_AUTO
;timer_func.c,7 :: 		TIM2_SRbits.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_SRbits+0)
MOVT	R0, #hi_addr(TIM2_SRbits+0)
_SX	[R0, ByteOffset(TIM2_SRbits+0)]
;timer_func.c,8 :: 		flag_t.ovf_flag = SET;
MOVS	R0, #1
MOVW	R1, #lo_addr(_flag_t+0)
MOVT	R1, #hi_addr(_flag_t+0)
STRB	R0, [R1, #0]
;timer_func.c,11 :: 		flag_t.ovf_flag = SET;
MOVS	R0, #1
STRB	R0, [R1, #0]
;timer_func.c,13 :: 		if(flag_t.first_start==RESET)
MOVW	R0, #lo_addr(_flag_t+11)
MOVT	R0, #hi_addr(_flag_t+11)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main_timer_func0
;timer_func.c,15 :: 		if((first_start_count++)>=((unsigned int)DELAY_FIRST_START*(1000/MS_IN_CYCLE)))
MOVW	R2, #lo_addr(main_timer_func_first_start_count_L0+0)
MOVT	R2, #hi_addr(main_timer_func_first_start_count_L0+0)
LDRH	R1, [R2, #0]
MOV	R0, R2
LDRH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R2, #0]
CMP	R1, #2000
IT	CC
BCC	L_main_timer_func1
;timer_func.c,17 :: 		first_start_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(main_timer_func_first_start_count_L0+0)
MOVT	R0, #hi_addr(main_timer_func_first_start_count_L0+0)
STRH	R1, [R0, #0]
;timer_func.c,18 :: 		flag_t.first_start = SET;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_t+11)
MOVT	R0, #hi_addr(_flag_t+11)
STRB	R1, [R0, #0]
;timer_func.c,19 :: 		}
L_main_timer_func1:
;timer_func.c,21 :: 		}
L_main_timer_func0:
;timer_func.c,23 :: 		if(flag_t.current_global_status==RESET)
MOVW	R0, #lo_addr(_flag_t+12)
MOVT	R0, #hi_addr(_flag_t+12)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main_timer_func2
;timer_func.c,25 :: 		if((current_global_status_count++)>=((unsigned int)DELAY_AFTER_CURRENT*(1000/MS_IN_CYCLE)))
MOVW	R2, #lo_addr(main_timer_func_current_global_status_count_L0+0)
MOVT	R2, #hi_addr(main_timer_func_current_global_status_count_L0+0)
LDRH	R1, [R2, #0]
MOV	R0, R2
LDRH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R2, #0]
MOVW	R0, #5000
CMP	R1, R0
IT	CC
BCC	L_main_timer_func3
;timer_func.c,27 :: 		current_global_status_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(main_timer_func_current_global_status_count_L0+0)
MOVT	R0, #hi_addr(main_timer_func_current_global_status_count_L0+0)
STRH	R1, [R0, #0]
;timer_func.c,28 :: 		flag_t.current_global_status = SET;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_t+12)
MOVT	R0, #hi_addr(_flag_t+12)
STRB	R1, [R0, #0]
;timer_func.c,29 :: 		}
L_main_timer_func3:
;timer_func.c,30 :: 		}
L_main_timer_func2:
;timer_func.c,34 :: 		}
L_end_main_timer_func:
BX	LR
; end of _main_timer_func
_key_timer_interrupt:
;timer_func.c,36 :: 		void key_timer_interrupt() iv IVT_INT_TIM3 ics ICS_AUTO
;timer_func.c,38 :: 		TIM3_SRbits.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_SRbits+0)
MOVT	R0, #hi_addr(TIM3_SRbits+0)
_SX	[R0, ByteOffset(TIM3_SRbits+0)]
;timer_func.c,39 :: 		}
L_end_key_timer_interrupt:
BX	LR
; end of _key_timer_interrupt
_StartMainTimer_10ms:
;timer_func.c,42 :: 		void StartMainTimer_10ms()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;timer_func.c,44 :: 		RCC_APB1ENRbits.TIM2EN=1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENRbits+0)
MOVT	R0, #hi_addr(RCC_APB1ENRbits+0)
_SX	[R0, ByteOffset(RCC_APB1ENRbits+0)]
;timer_func.c,45 :: 		TIM2_CR1bits.CEN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_CR1bits+0)
MOVT	R0, #hi_addr(TIM2_CR1bits+0)
_SX	[R0, ByteOffset(TIM2_CR1bits+0)]
;timer_func.c,46 :: 		TIM2_PSC = 4;
MOVS	R1, #4
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;timer_func.c,47 :: 		TIM2_ARR = 63999;
MOVW	R1, #63999
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;timer_func.c,48 :: 		NVIC_IntEnable(IVT_INT_TIM2);
MOVW	R0, #44
BL	_NVIC_IntEnable+0
;timer_func.c,49 :: 		TIM2_DIERbits.UIE = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_DIERbits+0)
MOVT	R0, #hi_addr(TIM2_DIERbits+0)
_SX	[R0, ByteOffset(TIM2_DIERbits+0)]
;timer_func.c,50 :: 		TIM2_CR1bits.CEN = 1;
MOVW	R0, #lo_addr(TIM2_CR1bits+0)
MOVT	R0, #hi_addr(TIM2_CR1bits+0)
_SX	[R0, ByteOffset(TIM2_CR1bits+0)]
;timer_func.c,51 :: 		}
L_end_StartMainTimer_10ms:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _StartMainTimer_10ms
_StopMainTimer_10ms:
;timer_func.c,53 :: 		void StopMainTimer_10ms()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;timer_func.c,55 :: 		RCC_APB1ENRbits.TIM2EN=0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENRbits+0)
MOVT	R0, #hi_addr(RCC_APB1ENRbits+0)
_SX	[R0, ByteOffset(RCC_APB1ENRbits+0)]
;timer_func.c,56 :: 		TIM2_CR1bits.CEN = 0;
MOVW	R0, #lo_addr(TIM2_CR1bits+0)
MOVT	R0, #hi_addr(TIM2_CR1bits+0)
_SX	[R0, ByteOffset(TIM2_CR1bits+0)]
;timer_func.c,57 :: 		TIM2_PSC = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;timer_func.c,58 :: 		TIM2_ARR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;timer_func.c,59 :: 		NVIC_IntDisable(IVT_INT_TIM2);
MOVW	R0, #44
BL	_NVIC_IntDisable+0
;timer_func.c,60 :: 		TIM2_DIERbits.UIE = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_DIERbits+0)
MOVT	R0, #hi_addr(TIM2_DIERbits+0)
_SX	[R0, ByteOffset(TIM2_DIERbits+0)]
;timer_func.c,61 :: 		TIM2_CR1bits.CEN = 0;
MOVW	R0, #lo_addr(TIM2_CR1bits+0)
MOVT	R0, #hi_addr(TIM2_CR1bits+0)
_SX	[R0, ByteOffset(TIM2_CR1bits+0)]
;timer_func.c,62 :: 		}
L_end_StopMainTimer_10ms:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _StopMainTimer_10ms
_Read_key:
;timer_func.c,64 :: 		void Read_key()
;timer_func.c,67 :: 		}
L_end_Read_key:
BX	LR
; end of _Read_key
_Scan_pin:
;timer_func.c,69 :: 		void Scan_pin(unsigned char *k_b)
;timer_func.c,72 :: 		}
L_end_Scan_pin:
BX	LR
; end of _Scan_pin
_Start_key_timer:
;timer_func.c,77 :: 		void Start_key_timer(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;timer_func.c,78 :: 		RCC_APB1ENRbits.TIM3EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENRbits+0)
MOVT	R0, #hi_addr(RCC_APB1ENRbits+0)
_SX	[R0, ByteOffset(RCC_APB1ENRbits+0)]
;timer_func.c,79 :: 		TIM3_CR1bits.CEN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_CR1bits+0)
MOVT	R0, #hi_addr(TIM3_CR1bits+0)
_SX	[R0, ByteOffset(TIM3_CR1bits+0)]
;timer_func.c,80 :: 		TIM3_PSC = 99;
MOVS	R1, #99
MOVW	R0, #lo_addr(TIM3_PSC+0)
MOVT	R0, #hi_addr(TIM3_PSC+0)
STR	R1, [R0, #0]
;timer_func.c,81 :: 		TIM3_ARR = 63999;
MOVW	R1, #63999
MOVW	R0, #lo_addr(TIM3_ARR+0)
MOVT	R0, #hi_addr(TIM3_ARR+0)
STR	R1, [R0, #0]
;timer_func.c,82 :: 		NVIC_IntEnable(IVT_INT_TIM3);
MOVW	R0, #45
BL	_NVIC_IntEnable+0
;timer_func.c,83 :: 		TIM3_DIERbits.UIE = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_DIERbits+0)
MOVT	R0, #hi_addr(TIM3_DIERbits+0)
_SX	[R0, ByteOffset(TIM3_DIERbits+0)]
;timer_func.c,84 :: 		TIM3_CR1bits.CEN = 1;
MOVW	R0, #lo_addr(TIM3_CR1bits+0)
MOVT	R0, #hi_addr(TIM3_CR1bits+0)
_SX	[R0, ByteOffset(TIM3_CR1bits+0)]
;timer_func.c,85 :: 		}
L_end_Start_key_timer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Start_key_timer
_Stop_key_timer:
;timer_func.c,87 :: 		void Stop_key_timer(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;timer_func.c,88 :: 		RCC_APB1ENRbits.TIM3EN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENRbits+0)
MOVT	R0, #hi_addr(RCC_APB1ENRbits+0)
_SX	[R0, ByteOffset(RCC_APB1ENRbits+0)]
;timer_func.c,89 :: 		TIM3_CR1bits.CEN = 0;
MOVW	R0, #lo_addr(TIM3_CR1bits+0)
MOVT	R0, #hi_addr(TIM3_CR1bits+0)
_SX	[R0, ByteOffset(TIM3_CR1bits+0)]
;timer_func.c,90 :: 		TIM3_PSC = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM3_PSC+0)
MOVT	R0, #hi_addr(TIM3_PSC+0)
STR	R1, [R0, #0]
;timer_func.c,91 :: 		TIM3_ARR = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM3_ARR+0)
MOVT	R0, #hi_addr(TIM3_ARR+0)
STR	R1, [R0, #0]
;timer_func.c,92 :: 		NVIC_IntDisable(IVT_INT_TIM3);
MOVW	R0, #45
BL	_NVIC_IntDisable+0
;timer_func.c,93 :: 		TIM3_DIERbits.UIE = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM3_DIERbits+0)
MOVT	R0, #hi_addr(TIM3_DIERbits+0)
_SX	[R0, ByteOffset(TIM3_DIERbits+0)]
;timer_func.c,94 :: 		TIM3_CR1bits.CEN = 0;
MOVW	R0, #lo_addr(TIM3_CR1bits+0)
MOVT	R0, #hi_addr(TIM3_CR1bits+0)
_SX	[R0, ByteOffset(TIM3_CR1bits+0)]
;timer_func.c,95 :: 		}
L_end_Stop_key_timer:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Stop_key_timer
_WDT_Init:
;timer_func.c,97 :: 		void WDT_Init()
;timer_func.c,99 :: 		RCC_CSRbits.LSION = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_CSRbits+0)
MOVT	R0, #hi_addr(RCC_CSRbits+0)
_SX	[R0, ByteOffset(RCC_CSRbits+0)]
;timer_func.c,100 :: 		while(!RCC_CSRbits.LSIRDY);
L_WDT_Init4:
MOVW	R0, #lo_addr(RCC_CSRbits+0)
MOVT	R0, #hi_addr(RCC_CSRbits+0)
_LX	[R0, ByteOffset(RCC_CSRbits+0)]
CMP	R0, #0
IT	NE
BNE	L_WDT_Init5
IT	AL
BAL	L_WDT_Init4
L_WDT_Init5:
;timer_func.c,101 :: 		IWDG_KR = 0x5555;      //write with protect
MOVW	R1, #21845
MOVW	R0, #lo_addr(IWDG_KR+0)
MOVT	R0, #hi_addr(IWDG_KR+0)
STR	R1, [R0, #0]
;timer_func.c,102 :: 		IWDG_PRbits.PR = 0x00;  //prescaler
MOVS	R2, #0
MOVW	R1, #lo_addr(IWDG_PRbits+0)
MOVT	R1, #hi_addr(IWDG_PRbits+0)
LDRB	R0, [R1, #0]
BFI	R0, R2, #0, #3
STRB	R0, [R1, #0]
;timer_func.c,103 :: 		IWDG_KR = 0xCCCC;      //start watchdog
MOVW	R1, #52428
MOVW	R0, #lo_addr(IWDG_KR+0)
MOVT	R0, #hi_addr(IWDG_KR+0)
STR	R1, [R0, #0]
;timer_func.c,104 :: 		IWDG_KR = 0xAAAA;      //reset watchdog
MOVW	R1, #43690
MOVW	R0, #lo_addr(IWDG_KR+0)
MOVT	R0, #hi_addr(IWDG_KR+0)
STR	R1, [R0, #0]
;timer_func.c,115 :: 		}
L_end_WDT_Init:
BX	LR
; end of _WDT_Init
_clear_WDT:
;timer_func.c,117 :: 		void clear_WDT()
;timer_func.c,119 :: 		IWDG_KR = 0xAAAA;      //reset watchdog
MOVW	R1, #43690
MOVW	R0, #lo_addr(IWDG_KR+0)
MOVT	R0, #hi_addr(IWDG_KR+0)
STR	R1, [R0, #0]
;timer_func.c,120 :: 		}
L_end_clear_WDT:
BX	LR
; end of _clear_WDT
_setPreloadValue:
;timer_func.c,122 :: 		void setPreloadValue(unsigned long value)
; value start address is: 0 (R0)
; value end address is: 0 (R0)
; value start address is: 0 (R0)
; value end address is: 0 (R0)
;timer_func.c,124 :: 		while(IWDG_SRbits.PVU);
L_setPreloadValue6:
; value start address is: 0 (R0)
MOVW	R1, #lo_addr(IWDG_SRbits+0)
MOVT	R1, #hi_addr(IWDG_SRbits+0)
_LX	[R1, ByteOffset(IWDG_SRbits+0)]
CMP	R1, #0
IT	EQ
BEQ	L_setPreloadValue7
IT	AL
BAL	L_setPreloadValue6
L_setPreloadValue7:
;timer_func.c,125 :: 		IWDG_KR = 0x5555;
MOVW	R2, #21845
MOVW	R1, #lo_addr(IWDG_KR+0)
MOVT	R1, #hi_addr(IWDG_KR+0)
STR	R2, [R1, #0]
;timer_func.c,126 :: 		IWDG_PR = value;
MOVW	R1, #lo_addr(IWDG_PR+0)
MOVT	R1, #hi_addr(IWDG_PR+0)
STR	R0, [R1, #0]
; value end address is: 0 (R0)
;timer_func.c,128 :: 		}
L_end_setPreloadValue:
BX	LR
; end of _setPreloadValue
