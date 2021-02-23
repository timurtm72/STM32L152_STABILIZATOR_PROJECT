_Init_ADC_chanell:
;adc_func.c,4 :: 		void Init_ADC_chanell()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;adc_func.c,6 :: 		ADC_CCRbits.ADCPRE = 0x02;              //предделитель АЦП
MOVS	R2, #2
MOVW	R1, #lo_addr(ADC_CCRbits+0)
MOVT	R1, #hi_addr(ADC_CCRbits+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #16, #2
STR	R0, [R1, #0]
;adc_func.c,7 :: 		ADC1_Init();
BL	_ADC1_Init+0
;adc_func.c,8 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_4|_ADC_CHANNEL_5);
MOV	R0, #48
BL	_ADC_Set_Input_Channel+0
;adc_func.c,14 :: 		}
L_end_Init_ADC_chanell:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _Init_ADC_chanell
_ReadAnalogInput:
;adc_func.c,20 :: 		void ReadAnalogInput()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;adc_func.c,23 :: 		if((rai_count++)>=50)
MOVW	R2, #lo_addr(ReadAnalogInput_rai_count_L0+0)
MOVT	R2, #hi_addr(ReadAnalogInput_rai_count_L0+0)
LDRB	R1, [R2, #0]
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
STRB	R0, [R2, #0]
CMP	R1, #50
IT	CC
BCC	L_ReadAnalogInput0
;adc_func.c,25 :: 		rai_count=0;
MOVS	R1, #0
MOVW	R0, #lo_addr(ReadAnalogInput_rai_count_L0+0)
MOVT	R0, #hi_addr(ReadAnalogInput_rai_count_L0+0)
STRB	R1, [R0, #0]
;adc_func.c,26 :: 		InVoltageValue  = Read_ADC_chanell(IN_VOLTAGE,10,VOLTAGE_KOEF);
MOV	R2, #1073741824
MOVS	R1, #10
MOVS	R0, #4
BL	_Read_ADC_chanell+0
MOVW	R1, #lo_addr(_InVoltageValue+0)
MOVT	R1, #hi_addr(_InVoltageValue+0)
STR	R0, [R1, #0]
;adc_func.c,27 :: 		CurrentValue    = Read_ADC_chanell(IN_CURRENT,10,CURRENT_KOEF);
MOVW	R2, #0
MOVT	R2, #16608
MOVS	R1, #10
MOVS	R0, #5
BL	_Read_ADC_chanell+0
MOVW	R1, #lo_addr(_CurrentValue+0)
MOVT	R1, #hi_addr(_CurrentValue+0)
STR	R0, [R1, #0]
;adc_func.c,28 :: 		}
L_ReadAnalogInput0:
;adc_func.c,30 :: 		}
L_end_ReadAnalogInput:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ReadAnalogInput
_Read_ADC_chanell:
;adc_func.c,33 :: 		float Read_ADC_chanell(char chanell,unsigned char samples,float koef)
; koef start address is: 8 (R2)
; samples start address is: 4 (R1)
; chanell start address is: 0 (R0)
SUB	SP, SP, #12
STR	LR, [SP, #0]
; koef end address is: 8 (R2)
; samples end address is: 4 (R1)
; chanell end address is: 0 (R0)
; chanell start address is: 0 (R0)
; samples start address is: 4 (R1)
; koef start address is: 8 (R2)
;adc_func.c,35 :: 		float  temp = 0,temp1 = 0;
; temp1 start address is: 32 (R8)
MOV	R8, #0
;adc_func.c,36 :: 		unsigned char i = 0;
;adc_func.c,37 :: 		for(i=0;i<samples;i++)
; i start address is: 48 (R12)
MOVW	R12, #0
; chanell end address is: 0 (R0)
; samples end address is: 4 (R1)
; koef end address is: 8 (R2)
; temp1 end address is: 32 (R8)
; i end address is: 48 (R12)
UXTB	R11, R0
UXTB	R10, R1
MOV	R9, R2
L_Read_ADC_chanell1:
; i start address is: 48 (R12)
; chanell start address is: 44 (R11)
; temp1 start address is: 32 (R8)
; koef start address is: 36 (R9)
; samples start address is: 40 (R10)
; chanell start address is: 44 (R11)
; chanell end address is: 44 (R11)
CMP	R12, R10
IT	CS
BCS	L_Read_ADC_chanell2
; chanell end address is: 44 (R11)
;adc_func.c,39 :: 		temp = (ADC1_Get_Sample(chanell)>>2);
; chanell start address is: 44 (R11)
UXTB	R0, R11
BL	_ADC1_Get_Sample+0
LSRS	R3, R0, #2
UXTH	R3, R3
UXTH	R0, R3
BL	__UnsignedIntegralToFloat+0
;adc_func.c,40 :: 		temp1+=temp;
MOV	R2, R8
BL	__Add_FP+0
MOV	R8, R0
;adc_func.c,41 :: 		Delay_us(150);
MOVW	R7, #1199
MOVT	R7, #0
NOP
NOP
L_Read_ADC_chanell4:
SUBS	R7, R7, #1
BNE	L_Read_ADC_chanell4
NOP
NOP
NOP
;adc_func.c,37 :: 		for(i=0;i<samples;i++)
ADD	R12, R12, #1
UXTB	R12, R12
;adc_func.c,42 :: 		}
; chanell end address is: 44 (R11)
; i end address is: 48 (R12)
IT	AL
BAL	L_Read_ADC_chanell1
L_Read_ADC_chanell2:
;adc_func.c,44 :: 		return ((float)((temp1/samples)/koef));
UXTB	R0, R10
BL	__UnsignedIntegralToFloat+0
; samples end address is: 40 (R10)
STR	R0, [SP, #8]
STR	R1, [SP, #4]
LDR	R1, [SP, #8]
MOV	R2, R1
MOV	R0, R8
BL	__Div_FP+0
; temp1 end address is: 32 (R8)
LDR	R1, [SP, #4]
MOV	R2, R9
BL	__Div_FP+0
; koef end address is: 36 (R9)
;adc_func.c,48 :: 		}
L_end_Read_ADC_chanell:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _Read_ADC_chanell
_ControlAnalogFlags:
;adc_func.c,50 :: 		void ControlAnalogFlags()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;adc_func.c,59 :: 		if((flag_t.short_current_status==RESET||flag_t.current_status==RESET)&&flag_t.first_start==SET)
MOVW	R0, #lo_addr(_flag_t+10)
MOVT	R0, #hi_addr(_flag_t+10)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__ControlAnalogFlags34
MOVW	R0, #lo_addr(_flag_t+9)
MOVT	R0, #hi_addr(_flag_t+9)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__ControlAnalogFlags33
IT	AL
BAL	L_ControlAnalogFlags10
L__ControlAnalogFlags34:
L__ControlAnalogFlags33:
MOVW	R0, #lo_addr(_flag_t+11)
MOVT	R0, #hi_addr(_flag_t+11)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__ControlAnalogFlags35
L__ControlAnalogFlags31:
;adc_func.c,61 :: 		flag_t.current_global_status = RESET;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+12)
MOVT	R0, #hi_addr(_flag_t+12)
STRB	R1, [R0, #0]
;adc_func.c,62 :: 		}
L_ControlAnalogFlags10:
;adc_func.c,59 :: 		if((flag_t.short_current_status==RESET||flag_t.current_status==RESET)&&flag_t.first_start==SET)
L__ControlAnalogFlags35:
;adc_func.c,67 :: 		&input_voltage_status_first_step_count1);
MOVW	R5, #lo_addr(ControlAnalogFlags_input_voltage_status_first_step_count1_L0+0)
MOVT	R5, #hi_addr(ControlAnalogFlags_input_voltage_status_first_step_count1_L0+0)
;adc_func.c,66 :: 		&flag_t.input_voltage_status_first_step,&input_voltage_status_first_step_count,
MOVW	R4, #lo_addr(ControlAnalogFlags_input_voltage_status_first_step_count_L0+0)
MOVT	R4, #hi_addr(ControlAnalogFlags_input_voltage_status_first_step_count_L0+0)
MOVW	R3, #lo_addr(_flag_t+2)
MOVT	R3, #hi_addr(_flag_t+2)
;adc_func.c,65 :: 		one_level_comparator(VALUE_FIRST_STEP,InVoltageValue,VOLTAGE_GISTERESIS,ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,
MOVS	R2, #10
MOVS	R1, #2
MOVW	R0, #lo_addr(_InVoltageValue+0)
MOVT	R0, #hi_addr(_InVoltageValue+0)
LDR	R0, [R0, #0]
;adc_func.c,67 :: 		&input_voltage_status_first_step_count1);
PUSH	(R5)
;adc_func.c,66 :: 		&flag_t.input_voltage_status_first_step,&input_voltage_status_first_step_count,
PUSH	(R4)
PUSH	(R3)
;adc_func.c,65 :: 		one_level_comparator(VALUE_FIRST_STEP,InVoltageValue,VOLTAGE_GISTERESIS,ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #2
MOVW	R2, #0
MOVT	R2, #16544
MOV	R1, R0
MOVW	R0, #0
MOVT	R0, #17194
;adc_func.c,67 :: 		&input_voltage_status_first_step_count1);
;adc_func.c,66 :: 		&flag_t.input_voltage_status_first_step,&input_voltage_status_first_step_count,
;adc_func.c,65 :: 		one_level_comparator(VALUE_FIRST_STEP,InVoltageValue,VOLTAGE_GISTERESIS,ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,
;adc_func.c,67 :: 		&input_voltage_status_first_step_count1);
BL	_one_level_comparator+0
ADD	SP, SP, #20
;adc_func.c,71 :: 		&input_voltage_status_second_step_count1);
MOVW	R5, #lo_addr(ControlAnalogFlags_input_voltage_status_second_step_count1_L0+0)
MOVT	R5, #hi_addr(ControlAnalogFlags_input_voltage_status_second_step_count1_L0+0)
;adc_func.c,70 :: 		&flag_t.input_voltage_status_second_step,&input_voltage_status_second_step_count,
MOVW	R4, #lo_addr(ControlAnalogFlags_input_voltage_status_second_step_count_L0+0)
MOVT	R4, #hi_addr(ControlAnalogFlags_input_voltage_status_second_step_count_L0+0)
MOVW	R3, #lo_addr(_flag_t+3)
MOVT	R3, #hi_addr(_flag_t+3)
;adc_func.c,69 :: 		one_level_comparator(VALUE_SECOND_STEP,InVoltageValue,VOLTAGE_GISTERESIS,ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,
MOVS	R2, #10
MOVS	R1, #2
MOVW	R0, #lo_addr(_InVoltageValue+0)
MOVT	R0, #hi_addr(_InVoltageValue+0)
LDR	R0, [R0, #0]
;adc_func.c,71 :: 		&input_voltage_status_second_step_count1);
PUSH	(R5)
;adc_func.c,70 :: 		&flag_t.input_voltage_status_second_step,&input_voltage_status_second_step_count,
PUSH	(R4)
PUSH	(R3)
;adc_func.c,69 :: 		one_level_comparator(VALUE_SECOND_STEP,InVoltageValue,VOLTAGE_GISTERESIS,ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #2
MOVW	R2, #0
MOVT	R2, #16544
MOV	R1, R0
MOVW	R0, #0
MOVT	R0, #17234
;adc_func.c,71 :: 		&input_voltage_status_second_step_count1);
;adc_func.c,70 :: 		&flag_t.input_voltage_status_second_step,&input_voltage_status_second_step_count,
;adc_func.c,69 :: 		one_level_comparator(VALUE_SECOND_STEP,InVoltageValue,VOLTAGE_GISTERESIS,ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,
;adc_func.c,71 :: 		&input_voltage_status_second_step_count1);
BL	_one_level_comparator+0
ADD	SP, SP, #20
;adc_func.c,75 :: 		&current_status_count1);
MOVW	R5, #lo_addr(ControlAnalogFlags_current_status_count1_L0+0)
MOVT	R5, #hi_addr(ControlAnalogFlags_current_status_count1_L0+0)
;adc_func.c,74 :: 		ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.current_status_temp,&current_status_count,
MOVW	R4, #lo_addr(ControlAnalogFlags_current_status_count_L0+0)
MOVT	R4, #hi_addr(ControlAnalogFlags_current_status_count_L0+0)
MOVW	R3, #lo_addr(_flag_t+17)
MOVT	R3, #hi_addr(_flag_t+17)
MOVS	R2, #10
MOVS	R1, #2
;adc_func.c,73 :: 		one_level_comparator(VALUE_CURRENT,CurrentValue,CURRENT_GISTERESIS,ANALOG_DELAY_ON,
MOVW	R0, #lo_addr(_CurrentValue+0)
MOVT	R0, #hi_addr(_CurrentValue+0)
LDR	R0, [R0, #0]
;adc_func.c,75 :: 		&current_status_count1);
PUSH	(R5)
;adc_func.c,74 :: 		ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.current_status_temp,&current_status_count,
PUSH	(R4)
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
;adc_func.c,73 :: 		one_level_comparator(VALUE_CURRENT,CurrentValue,CURRENT_GISTERESIS,ANALOG_DELAY_ON,
MOVS	R3, #2
MOVW	R2, #0
MOVT	R2, #16544
MOV	R1, R0
MOVW	R0, #0
MOVT	R0, #17096
;adc_func.c,75 :: 		&current_status_count1);
;adc_func.c,74 :: 		ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.current_status_temp,&current_status_count,
;adc_func.c,75 :: 		&current_status_count1);
BL	_one_level_comparator+0
ADD	SP, SP, #20
;adc_func.c,79 :: 		&short_current_status_count1);
MOVW	R5, #lo_addr(ControlAnalogFlags_short_current_status_count1_L0+0)
MOVT	R5, #hi_addr(ControlAnalogFlags_short_current_status_count1_L0+0)
;adc_func.c,78 :: 		&flag_t.short_current_status_temp,&short_current_status_count,
MOVW	R4, #lo_addr(ControlAnalogFlags_short_current_status_count_L0+0)
MOVT	R4, #hi_addr(ControlAnalogFlags_short_current_status_count_L0+0)
MOVW	R3, #lo_addr(_flag_t+18)
MOVT	R3, #hi_addr(_flag_t+18)
;adc_func.c,77 :: 		one_level_comparator(VALUE_CURRENT_SHORT,CurrentValue,CURRENT_GISTERESIS,CURRENT_SHORT_DELAY_ON,CURRENT_SHORT_DELAY_OFF,MS_IN_CYCLE,
MOVS	R2, #10
MOVS	R1, #3
MOVW	R0, #lo_addr(_CurrentValue+0)
MOVT	R0, #hi_addr(_CurrentValue+0)
LDR	R0, [R0, #0]
;adc_func.c,79 :: 		&short_current_status_count1);
PUSH	(R5)
;adc_func.c,78 :: 		&flag_t.short_current_status_temp,&short_current_status_count,
PUSH	(R4)
PUSH	(R3)
;adc_func.c,77 :: 		one_level_comparator(VALUE_CURRENT_SHORT,CurrentValue,CURRENT_GISTERESIS,CURRENT_SHORT_DELAY_ON,CURRENT_SHORT_DELAY_OFF,MS_IN_CYCLE,
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #3
MOVW	R2, #0
MOVT	R2, #16544
MOV	R1, R0
MOVW	R0, #0
MOVT	R0, #17136
;adc_func.c,79 :: 		&short_current_status_count1);
;adc_func.c,78 :: 		&flag_t.short_current_status_temp,&short_current_status_count,
;adc_func.c,77 :: 		one_level_comparator(VALUE_CURRENT_SHORT,CurrentValue,CURRENT_GISTERESIS,CURRENT_SHORT_DELAY_ON,CURRENT_SHORT_DELAY_OFF,MS_IN_CYCLE,
;adc_func.c,79 :: 		&short_current_status_count1);
BL	_one_level_comparator+0
ADD	SP, SP, #20
;adc_func.c,83 :: 		&input_voltage_status_bypass_count1);
MOVW	R5, #lo_addr(ControlAnalogFlags_input_voltage_status_bypass_count1_L0+0)
MOVT	R5, #hi_addr(ControlAnalogFlags_input_voltage_status_bypass_count1_L0+0)
;adc_func.c,82 :: 		&flag_t.input_voltage_status_bypass,&input_voltage_status_bypass_count,
MOVW	R4, #lo_addr(ControlAnalogFlags_input_voltage_status_bypass_count_L0+0)
MOVT	R4, #hi_addr(ControlAnalogFlags_input_voltage_status_bypass_count_L0+0)
MOVW	R3, #lo_addr(_flag_t+5)
MOVT	R3, #hi_addr(_flag_t+5)
;adc_func.c,81 :: 		one_level_comparator(VALUE_BYPASS,InVoltageValue,VOLTAGE_GISTERESIS,ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,
MOVS	R2, #10
MOVS	R1, #2
MOVW	R0, #lo_addr(_InVoltageValue+0)
MOVT	R0, #hi_addr(_InVoltageValue+0)
LDR	R0, [R0, #0]
;adc_func.c,83 :: 		&input_voltage_status_bypass_count1);
PUSH	(R5)
;adc_func.c,82 :: 		&flag_t.input_voltage_status_bypass,&input_voltage_status_bypass_count,
PUSH	(R4)
PUSH	(R3)
;adc_func.c,81 :: 		one_level_comparator(VALUE_BYPASS,InVoltageValue,VOLTAGE_GISTERESIS,ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #2
MOVW	R2, #0
MOVT	R2, #16544
MOV	R1, R0
MOVW	R0, #0
MOVT	R0, #17254
;adc_func.c,83 :: 		&input_voltage_status_bypass_count1);
;adc_func.c,82 :: 		&flag_t.input_voltage_status_bypass,&input_voltage_status_bypass_count,
;adc_func.c,81 :: 		one_level_comparator(VALUE_BYPASS,InVoltageValue,VOLTAGE_GISTERESIS,ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,
;adc_func.c,83 :: 		&input_voltage_status_bypass_count1);
BL	_one_level_comparator+0
ADD	SP, SP, #20
;adc_func.c,91 :: 		&output_voltage_status_count1);
MOVW	R5, #lo_addr(ControlAnalogFlags_output_voltage_status_count1_L0+0)
MOVT	R5, #hi_addr(ControlAnalogFlags_output_voltage_status_count1_L0+0)
;adc_func.c,90 :: 		&flag_t.output_voltage_status_temp,&output_voltage_status_count,
MOVW	R4, #lo_addr(ControlAnalogFlags_output_voltage_status_count_L0+0)
MOVT	R4, #hi_addr(ControlAnalogFlags_output_voltage_status_count_L0+0)
MOVW	R3, #lo_addr(_flag_t+16)
MOVT	R3, #hi_addr(_flag_t+16)
;adc_func.c,89 :: 		one_level_comparator(VALUE_VOLT_HI,OutVoltageValue,VOLTAGE_GISTERESIS,ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,
MOVS	R2, #10
MOVS	R1, #2
MOVW	R0, #lo_addr(_OutVoltageValue+0)
MOVT	R0, #hi_addr(_OutVoltageValue+0)
LDR	R0, [R0, #0]
;adc_func.c,91 :: 		&output_voltage_status_count1);
PUSH	(R5)
;adc_func.c,90 :: 		&flag_t.output_voltage_status_temp,&output_voltage_status_count,
PUSH	(R4)
PUSH	(R3)
;adc_func.c,89 :: 		one_level_comparator(VALUE_VOLT_HI,OutVoltageValue,VOLTAGE_GISTERESIS,ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #2
MOVW	R2, #0
MOVT	R2, #16544
MOV	R1, R0
MOVW	R0, #0
MOVT	R0, #17287
;adc_func.c,91 :: 		&output_voltage_status_count1);
;adc_func.c,90 :: 		&flag_t.output_voltage_status_temp,&output_voltage_status_count,
;adc_func.c,89 :: 		one_level_comparator(VALUE_VOLT_HI,OutVoltageValue,VOLTAGE_GISTERESIS,ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,
;adc_func.c,91 :: 		&output_voltage_status_count1);
BL	_one_level_comparator+0
ADD	SP, SP, #20
;adc_func.c,92 :: 		}
L_end_ControlAnalogFlags:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ControlAnalogFlags
_one_level_comparator:
;adc_func.c,96 :: 		unsigned int* count_olc,unsigned int* count_olc1)
; delay_on_sec start address is: 12 (R3)
; gisteresis start address is: 8 (R2)
; value start address is: 4 (R1)
; reference start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R9, R0
MOV	R10, R1
MOV	R11, R2
UXTH	R12, R3
; delay_on_sec end address is: 12 (R3)
; gisteresis end address is: 8 (R2)
; value end address is: 4 (R1)
; reference end address is: 0 (R0)
; reference start address is: 36 (R9)
; value start address is: 40 (R10)
; gisteresis start address is: 44 (R11)
; delay_on_sec start address is: 48 (R12)
LDRH	R4, [SP, #4]
STRH	R4, [SP, #4]
LDRB	R4, [SP, #8]
STRB	R4, [SP, #8]
LDR	R4, [SP, #12]
STR	R4, [SP, #12]
LDR	R4, [SP, #16]
STR	R4, [SP, #16]
LDR	R4, [SP, #20]
STR	R4, [SP, #20]
;adc_func.c,98 :: 		if(value>=(reference+gisteresis))
MOV	R0, R9
MOV	R2, R11
BL	__Add_FP+0
MOV	R2, R10
BL	__Compare_FP+0
MOVW	R0, #0
BGT	L__one_level_comparator53
MOVS	R0, #1
L__one_level_comparator53:
CMP	R0, #0
IT	EQ
BEQ	L_one_level_comparator11
;adc_func.c,100 :: 		if(++(*count_olc)>=((unsigned int)delay_off_sec*(1000/ms_in_one_cycle)))
LDR	R4, [SP, #16]
LDRH	R4, [R4, #0]
ADDS	R5, R4, #1
LDR	R4, [SP, #16]
STRH	R5, [R4, #0]
LDR	R4, [SP, #16]
LDRH	R6, [R4, #0]
LDRB	R5, [SP, #8]
MOVW	R4, #1000
SXTH	R4, R4
SDIV	R5, R4, R5
SXTH	R5, R5
LDRH	R4, [SP, #4]
MULS	R4, R5, R4
UXTH	R4, R4
CMP	R6, R4
IT	CC
BCC	L_one_level_comparator12
;adc_func.c,102 :: 		*count_olc = 0;
MOVS	R5, #0
LDR	R4, [SP, #16]
STRH	R5, [R4, #0]
;adc_func.c,103 :: 		*count_olc1=0;
MOVS	R5, #0
LDR	R4, [SP, #20]
STRH	R5, [R4, #0]
;adc_func.c,105 :: 		if(value>=(reference+gisteresis))
MOV	R0, R9
MOV	R2, R11
BL	__Add_FP+0
MOV	R2, R10
BL	__Compare_FP+0
MOVW	R0, #0
BGT	L__one_level_comparator54
MOVS	R0, #1
L__one_level_comparator54:
CMP	R0, #0
IT	EQ
BEQ	L_one_level_comparator13
;adc_func.c,107 :: 		*status = 0;
MOVS	R5, #0
LDR	R4, [SP, #12]
STRB	R5, [R4, #0]
;adc_func.c,108 :: 		}
L_one_level_comparator13:
;adc_func.c,109 :: 		}
L_one_level_comparator12:
;adc_func.c,110 :: 		}
L_one_level_comparator11:
;adc_func.c,114 :: 		if(value<=(reference-gisteresis))
MOV	R2, R11
MOV	R0, R9
BL	__Sub_FP+0
MOV	R2, R10
BL	__Compare_FP+0
MOVW	R0, #0
BLT	L__one_level_comparator55
MOVS	R0, #1
L__one_level_comparator55:
CMP	R0, #0
IT	EQ
BEQ	L_one_level_comparator14
;adc_func.c,116 :: 		if(++(*count_olc1)>=((unsigned int)delay_on_sec*(1000/ms_in_one_cycle)))
LDR	R4, [SP, #20]
LDRH	R4, [R4, #0]
ADDS	R5, R4, #1
LDR	R4, [SP, #20]
STRH	R5, [R4, #0]
LDR	R4, [SP, #20]
LDRH	R6, [R4, #0]
LDRB	R5, [SP, #8]
MOVW	R4, #1000
SXTH	R4, R4
SDIV	R4, R4, R5
SXTH	R4, R4
MUL	R4, R12, R4
UXTH	R4, R4
; delay_on_sec end address is: 48 (R12)
CMP	R6, R4
IT	CC
BCC	L_one_level_comparator15
;adc_func.c,118 :: 		*count_olc = 0;
MOVS	R5, #0
LDR	R4, [SP, #16]
STRH	R5, [R4, #0]
;adc_func.c,119 :: 		*count_olc1=0;
MOVS	R5, #0
LDR	R4, [SP, #20]
STRH	R5, [R4, #0]
;adc_func.c,121 :: 		if(value<=(reference-gisteresis))
MOV	R2, R11
MOV	R0, R9
BL	__Sub_FP+0
; reference end address is: 36 (R9)
; gisteresis end address is: 44 (R11)
MOV	R2, R10
BL	__Compare_FP+0
MOVW	R0, #0
BLT	L__one_level_comparator56
MOVS	R0, #1
L__one_level_comparator56:
; value end address is: 40 (R10)
CMP	R0, #0
IT	EQ
BEQ	L_one_level_comparator16
;adc_func.c,123 :: 		*status = 1;
MOVS	R5, #1
LDR	R4, [SP, #12]
STRB	R5, [R4, #0]
;adc_func.c,124 :: 		}
L_one_level_comparator16:
;adc_func.c,125 :: 		}
L_one_level_comparator15:
;adc_func.c,126 :: 		}
L_one_level_comparator14:
;adc_func.c,127 :: 		}
L_end_one_level_comparator:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _one_level_comparator
_two_level_comparator:
;adc_func.c,132 :: 		unsigned int* count_tlc1)
; gisteresis start address is: 12 (R3)
; value start address is: 8 (R2)
; low_reference start address is: 4 (R1)
; high_reference start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
MOV	R9, R0
MOV	R10, R1
MOV	R11, R2
MOV	R12, R3
; gisteresis end address is: 12 (R3)
; value end address is: 8 (R2)
; low_reference end address is: 4 (R1)
; high_reference end address is: 0 (R0)
; high_reference start address is: 36 (R9)
; low_reference start address is: 40 (R10)
; value start address is: 44 (R11)
; gisteresis start address is: 48 (R12)
LDRH	R4, [SP, #4]
STRH	R4, [SP, #4]
LDRH	R4, [SP, #8]
STRH	R4, [SP, #8]
LDRB	R4, [SP, #12]
STRB	R4, [SP, #12]
LDR	R4, [SP, #16]
STR	R4, [SP, #16]
LDR	R4, [SP, #20]
STR	R4, [SP, #20]
LDR	R4, [SP, #24]
STR	R4, [SP, #24]
;adc_func.c,134 :: 		if( (value>=(high_reference+gisteresis))||(value<=(low_reference-gisteresis)))
MOV	R0, R9
MOV	R2, R12
BL	__Add_FP+0
MOV	R2, R11
BL	__Compare_FP+0
MOVW	R0, #0
BGT	L__two_level_comparator58
MOVS	R0, #1
L__two_level_comparator58:
CMP	R0, #0
IT	NE
BNE	L__two_level_comparator41
MOV	R2, R12
MOV	R0, R10
BL	__Sub_FP+0
MOV	R2, R11
BL	__Compare_FP+0
MOVW	R0, #0
BLT	L__two_level_comparator59
MOVS	R0, #1
L__two_level_comparator59:
CMP	R0, #0
IT	NE
BNE	L__two_level_comparator40
IT	AL
BAL	L_two_level_comparator19
L__two_level_comparator41:
L__two_level_comparator40:
;adc_func.c,137 :: 		if(++(*count_tlc)>=((unsigned int)delay_off_sec_tlc*(1000/ms_in_one_cycle_tlc)))
LDR	R4, [SP, #20]
LDRH	R4, [R4, #0]
ADDS	R5, R4, #1
LDR	R4, [SP, #20]
STRH	R5, [R4, #0]
LDR	R4, [SP, #20]
LDRH	R6, [R4, #0]
LDRB	R5, [SP, #12]
MOVW	R4, #1000
SXTH	R4, R4
SDIV	R5, R4, R5
SXTH	R5, R5
LDRH	R4, [SP, #8]
MULS	R4, R5, R4
UXTH	R4, R4
CMP	R6, R4
IT	CC
BCC	L_two_level_comparator20
;adc_func.c,139 :: 		*count_tlc  = 0;
MOVS	R5, #0
LDR	R4, [SP, #20]
STRH	R5, [R4, #0]
;adc_func.c,140 :: 		*count_tlc1 = 0;
MOVS	R5, #0
LDR	R4, [SP, #24]
STRH	R5, [R4, #0]
;adc_func.c,141 :: 		if((value>=(high_reference+gisteresis))||(value<=(low_reference-gisteresis)))
MOV	R0, R9
MOV	R2, R12
BL	__Add_FP+0
MOV	R2, R11
BL	__Compare_FP+0
MOVW	R0, #0
BGT	L__two_level_comparator60
MOVS	R0, #1
L__two_level_comparator60:
CMP	R0, #0
IT	NE
BNE	L__two_level_comparator43
MOV	R2, R12
MOV	R0, R10
BL	__Sub_FP+0
MOV	R2, R11
BL	__Compare_FP+0
MOVW	R0, #0
BLT	L__two_level_comparator61
MOVS	R0, #1
L__two_level_comparator61:
CMP	R0, #0
IT	NE
BNE	L__two_level_comparator42
IT	AL
BAL	L_two_level_comparator23
L__two_level_comparator43:
L__two_level_comparator42:
;adc_func.c,143 :: 		*status_tlc = 0;
MOVS	R5, #0
LDR	R4, [SP, #16]
STRB	R5, [R4, #0]
;adc_func.c,144 :: 		}
L_two_level_comparator23:
;adc_func.c,146 :: 		}
L_two_level_comparator20:
;adc_func.c,148 :: 		}
L_two_level_comparator19:
;adc_func.c,150 :: 		if((value<=(high_reference-gisteresis))&&(value>=(low_reference+gisteresis)))
MOV	R2, R12
MOV	R0, R9
BL	__Sub_FP+0
MOV	R2, R11
BL	__Compare_FP+0
MOVW	R0, #0
BLT	L__two_level_comparator62
MOVS	R0, #1
L__two_level_comparator62:
CMP	R0, #0
IT	EQ
BEQ	L__two_level_comparator47
MOV	R0, R10
MOV	R2, R12
BL	__Add_FP+0
MOV	R2, R11
BL	__Compare_FP+0
MOVW	R0, #0
BGT	L__two_level_comparator63
MOVS	R0, #1
L__two_level_comparator63:
CMP	R0, #0
IT	EQ
BEQ	L__two_level_comparator46
L__two_level_comparator37:
;adc_func.c,153 :: 		if(++(*count_tlc1)>=((unsigned int)delay_on_sec_tlc*(1000/ms_in_one_cycle_tlc)))
LDR	R4, [SP, #24]
LDRH	R4, [R4, #0]
ADDS	R5, R4, #1
LDR	R4, [SP, #24]
STRH	R5, [R4, #0]
LDR	R4, [SP, #24]
LDRH	R6, [R4, #0]
LDRB	R5, [SP, #12]
MOVW	R4, #1000
SXTH	R4, R4
SDIV	R5, R4, R5
SXTH	R5, R5
LDRH	R4, [SP, #4]
MULS	R4, R5, R4
UXTH	R4, R4
CMP	R6, R4
IT	CC
BCC	L_two_level_comparator27
;adc_func.c,155 :: 		*count_tlc = 0;
MOVS	R5, #0
LDR	R4, [SP, #20]
STRH	R5, [R4, #0]
;adc_func.c,156 :: 		*count_tlc1=0;
MOVS	R5, #0
LDR	R4, [SP, #24]
STRH	R5, [R4, #0]
;adc_func.c,157 :: 		if((value<=(high_reference-gisteresis))&&(value>=(low_reference+gisteresis)))
MOV	R2, R12
MOV	R0, R9
BL	__Sub_FP+0
; high_reference end address is: 36 (R9)
MOV	R2, R11
BL	__Compare_FP+0
MOVW	R0, #0
BLT	L__two_level_comparator64
MOVS	R0, #1
L__two_level_comparator64:
CMP	R0, #0
IT	EQ
BEQ	L__two_level_comparator45
MOV	R0, R10
MOV	R2, R12
BL	__Add_FP+0
; low_reference end address is: 40 (R10)
; gisteresis end address is: 48 (R12)
MOV	R2, R11
BL	__Compare_FP+0
MOVW	R0, #0
BGT	L__two_level_comparator65
MOVS	R0, #1
L__two_level_comparator65:
; value end address is: 44 (R11)
CMP	R0, #0
IT	EQ
BEQ	L__two_level_comparator44
L__two_level_comparator36:
;adc_func.c,159 :: 		*status_tlc = 1;
MOVS	R5, #1
LDR	R4, [SP, #16]
STRB	R5, [R4, #0]
;adc_func.c,157 :: 		if((value<=(high_reference-gisteresis))&&(value>=(low_reference+gisteresis)))
L__two_level_comparator45:
L__two_level_comparator44:
;adc_func.c,162 :: 		}
L_two_level_comparator27:
;adc_func.c,150 :: 		if((value<=(high_reference-gisteresis))&&(value>=(low_reference+gisteresis)))
L__two_level_comparator47:
L__two_level_comparator46:
;adc_func.c,164 :: 		}
L_end_two_level_comparator:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _two_level_comparator
