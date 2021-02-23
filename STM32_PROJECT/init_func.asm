_Init_pin:
;init_func.c,15 :: 		void Init_pin()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;init_func.c,20 :: 		GPIO_Config(&GPIOA_BASE, _GPIO_PINMASK_11 | _GPIO_PINMASK_12,_GPIO_CFG_DIGITAL_OUTPUT);
MOVW	R2, #20
MOVT	R2, #8
MOVW	R1, #6144
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Config+0
;init_func.c,21 :: 		GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_6,_GPIO_CFG_DIGITAL_OUTPUT);
MOVW	R2, #20
MOVT	R2, #8
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Config+0
;init_func.c,22 :: 		GPIO_Config(&GPIOC_BASE, _GPIO_PINMASK_12,_GPIO_CFG_DIGITAL_OUTPUT);
MOVW	R2, #20
MOVT	R2, #8
MOVW	R1, #4096
MOVW	R0, #lo_addr(GPIOC_BASE+0)
MOVT	R0, #hi_addr(GPIOC_BASE+0)
BL	_GPIO_Config+0
;init_func.c,23 :: 		GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_6,_GPIO_CFG_DIGITAL_OUTPUT);
MOVW	R2, #20
MOVT	R2, #8
MOVW	R1, #64
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Config+0
;init_func.c,25 :: 		GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_7,_GPIO_CFG_DIGITAL_OUTPUT);
MOVW	R2, #20
MOVT	R2, #8
MOVW	R1, #128
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Config+0
;init_func.c,27 :: 		GPIO_Config(&GPIOD_BASE, _GPIO_PINMASK_2,_GPIO_CFG_DIGITAL_INPUT);
MOV	R2, #66
MOVW	R1, #4
MOVW	R0, #lo_addr(GPIOD_BASE+0)
MOVT	R0, #hi_addr(GPIOD_BASE+0)
BL	_GPIO_Config+0
;init_func.c,28 :: 		GPIO_Config(&GPIOA_BASE, _GPIO_PINMASK_0,_GPIO_CFG_DIGITAL_INPUT);
MOV	R2, #66
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOA_BASE+0)
MOVT	R0, #hi_addr(GPIOA_BASE+0)
BL	_GPIO_Config+0
;init_func.c,29 :: 		}
L_end_Init_pin:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Init_pin
_Init_flags:
;init_func.c,31 :: 		void Init_flags()
;init_func.c,33 :: 		flag_t.ovf_flag                                       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STRB	R1, [R0, #0]
;init_func.c,34 :: 		flag_t.start_button_status                            = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+1)
MOVT	R0, #hi_addr(_flag_t+1)
STRB	R1, [R0, #0]
;init_func.c,35 :: 		flag_t.input_voltage_status_first_step                = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+2)
MOVT	R0, #hi_addr(_flag_t+2)
STRB	R1, [R0, #0]
;init_func.c,36 :: 		flag_t.input_voltage_status_second_step               = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+3)
MOVT	R0, #hi_addr(_flag_t+3)
STRB	R1, [R0, #0]
;init_func.c,37 :: 		flag_t.status_main_contactor                          = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+4)
MOVT	R0, #hi_addr(_flag_t+4)
STRB	R1, [R0, #0]
;init_func.c,38 :: 		flag_t.input_voltage_status_bypass                    = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+5)
MOVT	R0, #hi_addr(_flag_t+5)
STRB	R1, [R0, #0]
;init_func.c,39 :: 		flag_t.input_voltage_status_hight                     = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+6)
MOVT	R0, #hi_addr(_flag_t+6)
STRB	R1, [R0, #0]
;init_func.c,40 :: 		flag_t.input_voltage_status_lo                        = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+7)
MOVT	R0, #hi_addr(_flag_t+7)
STRB	R1, [R0, #0]
;init_func.c,41 :: 		flag_t.output_voltage_status                          = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+8)
MOVT	R0, #hi_addr(_flag_t+8)
STRB	R1, [R0, #0]
;init_func.c,42 :: 		flag_t.current_status                                 = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+9)
MOVT	R0, #hi_addr(_flag_t+9)
STRB	R1, [R0, #0]
;init_func.c,43 :: 		flag_t.short_current_status                           = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+10)
MOVT	R0, #hi_addr(_flag_t+10)
STRB	R1, [R0, #0]
;init_func.c,44 :: 		flag_t.first_start                                    = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+11)
MOVT	R0, #hi_addr(_flag_t+11)
STRB	R1, [R0, #0]
;init_func.c,45 :: 		flag_t.current_global_status                          = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+12)
MOVT	R0, #hi_addr(_flag_t+12)
STRB	R1, [R0, #0]
;init_func.c,46 :: 		flag_t.status_bypass                                  = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+13)
MOVT	R0, #hi_addr(_flag_t+13)
STRB	R1, [R0, #0]
;init_func.c,47 :: 		flag_t.status_first_step                              = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+14)
MOVT	R0, #hi_addr(_flag_t+14)
STRB	R1, [R0, #0]
;init_func.c,48 :: 		flag_t.status_second_step                             = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+15)
MOVT	R0, #hi_addr(_flag_t+15)
STRB	R1, [R0, #0]
;init_func.c,49 :: 		flag_t.output_voltage_status_temp                     = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+16)
MOVT	R0, #hi_addr(_flag_t+16)
STRB	R1, [R0, #0]
;init_func.c,50 :: 		flag_t.current_status_temp                            = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+17)
MOVT	R0, #hi_addr(_flag_t+17)
STRB	R1, [R0, #0]
;init_func.c,51 :: 		flag_t.short_current_status_temp                      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+18)
MOVT	R0, #hi_addr(_flag_t+18)
STRB	R1, [R0, #0]
;init_func.c,52 :: 		flag_t.change_button_status                           = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+19)
MOVT	R0, #hi_addr(_flag_t+19)
STRB	R1, [R0, #0]
;init_func.c,53 :: 		}
L_end_Init_flags:
BX	LR
; end of _Init_flags
