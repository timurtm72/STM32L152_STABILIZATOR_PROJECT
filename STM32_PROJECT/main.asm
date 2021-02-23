_main:
;main.c,4 :: 		void main()
;main.c,6 :: 		Init_flags();
BL	_Init_flags+0
;main.c,7 :: 		Init_ADC_chanell();
BL	_Init_ADC_chanell+0
;main.c,8 :: 		Init_LCD();
BL	_Init_LCD+0
;main.c,9 :: 		Init_pin();
BL	_Init_pin+0
;main.c,10 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;main.c,11 :: 		StartMainTimer_10ms();
BL	_StartMainTimer_10ms+0
;main.c,12 :: 		WDT_Init();
BL	_WDT_Init+0
;main.c,13 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;main.c,16 :: 		while(TRUE)
L_main0:
;main.c,18 :: 		globalProcess();
BL	_globalProcess+0
;main.c,19 :: 		}
IT	AL
BAL	L_main0
;main.c,20 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
