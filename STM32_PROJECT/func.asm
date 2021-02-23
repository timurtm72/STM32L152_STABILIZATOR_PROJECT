_displayData:
;func.c,4 :: 		void displayData()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;func.c,10 :: 		if(flag_t.change_button_status==SET)
MOVW	R0, #lo_addr(_flag_t+19)
MOVT	R0, #hi_addr(_flag_t+19)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_displayData0
;func.c,12 :: 		if(in_reset==RESET)
MOVW	R0, #lo_addr(displayData_in_reset_L0+0)
MOVT	R0, #hi_addr(displayData_in_reset_L0+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_displayData1
;func.c,14 :: 		in_reset=SET;
MOVS	R1, #1
MOVW	R0, #lo_addr(displayData_in_reset_L0+0)
MOVT	R0, #hi_addr(displayData_in_reset_L0+0)
STRB	R1, [R0, #0]
;func.c,16 :: 		state^=1;
MOVW	R1, #lo_addr(displayData_state_L0+0)
MOVT	R1, #hi_addr(displayData_state_L0+0)
LDRB	R0, [R1, #0]
EOR	R0, R0, #1
STRB	R0, [R1, #0]
;func.c,18 :: 		}
L_displayData1:
;func.c,19 :: 		}
L_displayData0:
;func.c,20 :: 		if(flag_t.change_button_status==RESET)
MOVW	R0, #lo_addr(_flag_t+19)
MOVT	R0, #hi_addr(_flag_t+19)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_displayData2
;func.c,22 :: 		in_reset = RESET;
MOVS	R1, #0
MOVW	R0, #lo_addr(displayData_in_reset_L0+0)
MOVT	R0, #hi_addr(displayData_in_reset_L0+0)
STRB	R1, [R0, #0]
;func.c,23 :: 		}
L_displayData2:
;func.c,24 :: 		if((count_data++)>=100)
MOVW	R2, #lo_addr(displayData_count_data_L0+0)
MOVT	R2, #hi_addr(displayData_count_data_L0+0)
LDRH	R1, [R2, #0]
MOV	R0, R2
LDRH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R2, #0]
CMP	R1, #100
IT	CC
BCC	L_displayData3
;func.c,26 :: 		count_data = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(displayData_count_data_L0+0)
MOVT	R0, #hi_addr(displayData_count_data_L0+0)
STRH	R1, [R0, #0]
;func.c,27 :: 		LCD_bar_status();
BL	_LCD_bar_status+0
;func.c,28 :: 		switch(state)
IT	AL
BAL	L_displayData4
;func.c,30 :: 		case 0: Out_data_to_LCD('H','B',InVoltageValue);
L_displayData6:
MOVW	R0, #lo_addr(_InVoltageValue+0)
MOVT	R0, #hi_addr(_InVoltageValue+0)
LDR	R0, [R0, #0]
MOV	R2, R0
MOVS	R1, #66
MOVS	R0, #72
BL	_Out_data_to_LCD+0
;func.c,31 :: 		break;
IT	AL
BAL	L_displayData5
;func.c,32 :: 		case 1: Out_data_to_LCD('T','A',CurrentValue);
L_displayData7:
MOVW	R0, #lo_addr(_CurrentValue+0)
MOVT	R0, #hi_addr(_CurrentValue+0)
LDR	R0, [R0, #0]
MOV	R2, R0
MOVS	R1, #65
MOVS	R0, #84
BL	_Out_data_to_LCD+0
;func.c,33 :: 		break;
IT	AL
BAL	L_displayData5
;func.c,34 :: 		}
L_displayData4:
MOVW	R0, #lo_addr(displayData_state_L0+0)
MOVT	R0, #hi_addr(displayData_state_L0+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_displayData6
MOVW	R0, #lo_addr(displayData_state_L0+0)
MOVT	R0, #hi_addr(displayData_state_L0+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_displayData7
L_displayData5:
;func.c,35 :: 		}
L_displayData3:
;func.c,36 :: 		}
L_end_displayData:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _displayData
_ControlDigitalFlags:
;func.c,39 :: 		void ControlDigitalFlags()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;func.c,46 :: 		&start_button_status_count1, &start_button_status_count2);
MOVW	R4, #lo_addr(ControlDigitalFlags_start_button_status_count2_L0+0)
MOVT	R4, #hi_addr(ControlDigitalFlags_start_button_status_count2_L0+0)
MOVW	R3, #lo_addr(ControlDigitalFlags_start_button_status_count1_L0+0)
MOVT	R3, #hi_addr(ControlDigitalFlags_start_button_status_count1_L0+0)
;func.c,45 :: 		MS_IN_CYCLE, &flag_t.start_button_status,
MOVW	R2, #lo_addr(_flag_t+1)
MOVT	R2, #hi_addr(_flag_t+1)
;func.c,44 :: 		ControlDigit(START_BUTTON, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,
MOVW	R1, #lo_addr(START_BUTTON+0)
MOVT	R1, #hi_addr(START_BUTTON+0)
_LX	[R1, ByteOffset(START_BUTTON+0)]
;func.c,46 :: 		&start_button_status_count1, &start_button_status_count2);
PUSH	(R4)
PUSH	(R3)
;func.c,45 :: 		MS_IN_CYCLE, &flag_t.start_button_status,
PUSH	(R2)
MOVS	R3, #10
;func.c,44 :: 		ControlDigit(START_BUTTON, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,
MOVS	R2, #2
MOVS	R1, #2
;func.c,46 :: 		&start_button_status_count1, &start_button_status_count2);
;func.c,45 :: 		MS_IN_CYCLE, &flag_t.start_button_status,
;func.c,46 :: 		&start_button_status_count1, &start_button_status_count2);
BL	_ControlDigit+0
ADD	SP, SP, #12
;func.c,49 :: 		&change_button_status_count, &change_button_status_count1);
MOVW	R4, #lo_addr(ControlDigitalFlags_change_button_status_count1_L0+0)
MOVT	R4, #hi_addr(ControlDigitalFlags_change_button_status_count1_L0+0)
MOVW	R3, #lo_addr(ControlDigitalFlags_change_button_status_count_L0+0)
MOVT	R3, #hi_addr(ControlDigitalFlags_change_button_status_count_L0+0)
;func.c,48 :: 		MS_IN_CYCLE, &flag_t.change_button_status,
MOVW	R2, #lo_addr(_flag_t+19)
MOVT	R2, #hi_addr(_flag_t+19)
;func.c,47 :: 		ControlDigit(CHANGE_BUTTON, 1,1,
MOVW	R1, #lo_addr(CHANGE_BUTTON+0)
MOVT	R1, #hi_addr(CHANGE_BUTTON+0)
_LX	[R1, ByteOffset(CHANGE_BUTTON+0)]
;func.c,49 :: 		&change_button_status_count, &change_button_status_count1);
PUSH	(R4)
PUSH	(R3)
;func.c,48 :: 		MS_IN_CYCLE, &flag_t.change_button_status,
PUSH	(R2)
MOVS	R3, #10
;func.c,47 :: 		ControlDigit(CHANGE_BUTTON, 1,1,
MOVS	R2, #1
MOVS	R1, #1
;func.c,49 :: 		&change_button_status_count, &change_button_status_count1);
;func.c,48 :: 		MS_IN_CYCLE, &flag_t.change_button_status,
;func.c,49 :: 		&change_button_status_count, &change_button_status_count1);
BL	_ControlDigit+0
ADD	SP, SP, #12
;func.c,51 :: 		}
L_end_ControlDigitalFlags:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ControlDigitalFlags
_globalProcess:
;func.c,53 :: 		void globalProcess()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;func.c,55 :: 		if (flag_t.ovf_flag == SET)
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_globalProcess8
;func.c,57 :: 		flag_t.ovf_flag = RESET;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+0)
MOVT	R0, #hi_addr(_flag_t+0)
STRB	R1, [R0, #0]
;func.c,58 :: 		clear_WDT();
BL	_clear_WDT+0
;func.c,60 :: 		StatusLed();
BL	_StatusLed+0
;func.c,61 :: 		ControlDigitalFlags();
BL	_ControlDigitalFlags+0
;func.c,62 :: 		ControlAnalogFlags();
BL	_ControlAnalogFlags+0
;func.c,63 :: 		ReadAnalogInput();
BL	_ReadAnalogInput+0
;func.c,64 :: 		ControlOut();
BL	_ControlOut+0
;func.c,65 :: 		displayData();
BL	_displayData+0
;func.c,66 :: 		}
L_globalProcess8:
;func.c,67 :: 		}
L_end_globalProcess:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _globalProcess
_ControlOut:
;func.c,71 :: 		void ControlOut()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;func.c,78 :: 		if(flag_t.first_start==RESET)
MOVW	R0, #lo_addr(_flag_t+11)
MOVT	R0, #hi_addr(_flag_t+11)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_ControlOut9
;func.c,81 :: 		&c,&c1);
MOVW	R3, #lo_addr(ControlOut_c1_L0+0)
MOVT	R3, #hi_addr(ControlOut_c1_L0+0)
MOVW	R2, #lo_addr(ControlOut_c_L0+0)
MOVT	R2, #hi_addr(ControlOut_c_L0+0)
;func.c,80 :: 		ControlDigit(flag_t.input_voltage_status_first_step, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.status_first_step,
MOVW	R1, #lo_addr(_flag_t+14)
MOVT	R1, #hi_addr(_flag_t+14)
MOVW	R0, #lo_addr(_flag_t+2)
MOVT	R0, #hi_addr(_flag_t+2)
LDRB	R0, [R0, #0]
;func.c,81 :: 		&c,&c1);
PUSH	(R3)
PUSH	(R2)
;func.c,80 :: 		ControlDigit(flag_t.input_voltage_status_first_step, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.status_first_step,
PUSH	(R1)
MOVS	R3, #10
MOVS	R2, #2
MOVS	R1, #2
;func.c,81 :: 		&c,&c1);
;func.c,80 :: 		ControlDigit(flag_t.input_voltage_status_first_step, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.status_first_step,
;func.c,81 :: 		&c,&c1);
BL	_ControlDigit+0
ADD	SP, SP, #12
;func.c,84 :: 		&c2,&c3);
MOVW	R3, #lo_addr(ControlOut_c3_L0+0)
MOVT	R3, #hi_addr(ControlOut_c3_L0+0)
MOVW	R2, #lo_addr(ControlOut_c2_L0+0)
MOVT	R2, #hi_addr(ControlOut_c2_L0+0)
;func.c,83 :: 		ControlDigit(flag_t.input_voltage_status_second_step, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.status_second_step,
MOVW	R1, #lo_addr(_flag_t+15)
MOVT	R1, #hi_addr(_flag_t+15)
MOVW	R0, #lo_addr(_flag_t+3)
MOVT	R0, #hi_addr(_flag_t+3)
LDRB	R0, [R0, #0]
;func.c,84 :: 		&c2,&c3);
PUSH	(R3)
PUSH	(R2)
;func.c,83 :: 		ControlDigit(flag_t.input_voltage_status_second_step, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.status_second_step,
PUSH	(R1)
MOVS	R3, #10
MOVS	R2, #2
MOVS	R1, #2
;func.c,84 :: 		&c2,&c3);
;func.c,83 :: 		ControlDigit(flag_t.input_voltage_status_second_step, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.status_second_step,
;func.c,84 :: 		&c2,&c3);
BL	_ControlDigit+0
ADD	SP, SP, #12
;func.c,87 :: 		&c4,&c5);
MOVW	R3, #lo_addr(ControlOut_c5_L0+0)
MOVT	R3, #hi_addr(ControlOut_c5_L0+0)
MOVW	R2, #lo_addr(ControlOut_c4_L0+0)
MOVT	R2, #hi_addr(ControlOut_c4_L0+0)
;func.c,86 :: 		ControlDigit(flag_t.input_voltage_status_bypass, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.status_bypass,
MOVW	R1, #lo_addr(_flag_t+13)
MOVT	R1, #hi_addr(_flag_t+13)
MOVW	R0, #lo_addr(_flag_t+5)
MOVT	R0, #hi_addr(_flag_t+5)
LDRB	R0, [R0, #0]
;func.c,87 :: 		&c4,&c5);
PUSH	(R3)
PUSH	(R2)
;func.c,86 :: 		ControlDigit(flag_t.input_voltage_status_bypass, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.status_bypass,
PUSH	(R1)
MOVS	R3, #10
MOVS	R2, #2
MOVS	R1, #2
;func.c,87 :: 		&c4,&c5);
;func.c,86 :: 		ControlDigit(flag_t.input_voltage_status_bypass, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.status_bypass,
;func.c,87 :: 		&c4,&c5);
BL	_ControlDigit+0
ADD	SP, SP, #12
;func.c,90 :: 		&c6,&c7);
MOVW	R3, #lo_addr(ControlOut_c7_L0+0)
MOVT	R3, #hi_addr(ControlOut_c7_L0+0)
MOVW	R2, #lo_addr(ControlOut_c6_L0+0)
MOVT	R2, #hi_addr(ControlOut_c6_L0+0)
;func.c,89 :: 		ControlDigit(flag_t.output_voltage_status_temp, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.output_voltage_status,
MOVW	R1, #lo_addr(_flag_t+8)
MOVT	R1, #hi_addr(_flag_t+8)
MOVW	R0, #lo_addr(_flag_t+16)
MOVT	R0, #hi_addr(_flag_t+16)
LDRB	R0, [R0, #0]
;func.c,90 :: 		&c6,&c7);
PUSH	(R3)
PUSH	(R2)
;func.c,89 :: 		ControlDigit(flag_t.output_voltage_status_temp, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.output_voltage_status,
PUSH	(R1)
MOVS	R3, #10
MOVS	R2, #2
MOVS	R1, #2
;func.c,90 :: 		&c6,&c7);
;func.c,89 :: 		ControlDigit(flag_t.output_voltage_status_temp, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.output_voltage_status,
;func.c,90 :: 		&c6,&c7);
BL	_ControlDigit+0
ADD	SP, SP, #12
;func.c,93 :: 		&c8,&c9);
MOVW	R3, #lo_addr(ControlOut_c9_L0+0)
MOVT	R3, #hi_addr(ControlOut_c9_L0+0)
MOVW	R2, #lo_addr(ControlOut_c8_L0+0)
MOVT	R2, #hi_addr(ControlOut_c8_L0+0)
;func.c,92 :: 		ControlDigit(flag_t.short_current_status_temp, CURRENT_SHORT_DELAY_ON,CURRENT_SHORT_DELAY_OFF,MS_IN_CYCLE,&flag_t.short_current_status,
MOVW	R1, #lo_addr(_flag_t+10)
MOVT	R1, #hi_addr(_flag_t+10)
MOVW	R0, #lo_addr(_flag_t+18)
MOVT	R0, #hi_addr(_flag_t+18)
LDRB	R0, [R0, #0]
;func.c,93 :: 		&c8,&c9);
PUSH	(R3)
PUSH	(R2)
;func.c,92 :: 		ControlDigit(flag_t.short_current_status_temp, CURRENT_SHORT_DELAY_ON,CURRENT_SHORT_DELAY_OFF,MS_IN_CYCLE,&flag_t.short_current_status,
PUSH	(R1)
MOVS	R3, #10
MOVS	R2, #3
MOVS	R1, #3
;func.c,93 :: 		&c8,&c9);
;func.c,92 :: 		ControlDigit(flag_t.short_current_status_temp, CURRENT_SHORT_DELAY_ON,CURRENT_SHORT_DELAY_OFF,MS_IN_CYCLE,&flag_t.short_current_status,
;func.c,93 :: 		&c8,&c9);
BL	_ControlDigit+0
ADD	SP, SP, #12
;func.c,96 :: 		&c10,&c11);
MOVW	R3, #lo_addr(ControlOut_c11_L0+0)
MOVT	R3, #hi_addr(ControlOut_c11_L0+0)
MOVW	R2, #lo_addr(ControlOut_c10_L0+0)
MOVT	R2, #hi_addr(ControlOut_c10_L0+0)
;func.c,95 :: 		ControlDigit(flag_t.current_status_temp, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.current_status,
MOVW	R1, #lo_addr(_flag_t+9)
MOVT	R1, #hi_addr(_flag_t+9)
MOVW	R0, #lo_addr(_flag_t+17)
MOVT	R0, #hi_addr(_flag_t+17)
LDRB	R0, [R0, #0]
;func.c,96 :: 		&c10,&c11);
PUSH	(R3)
PUSH	(R2)
;func.c,95 :: 		ControlDigit(flag_t.current_status_temp, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.current_status,
PUSH	(R1)
MOVS	R3, #10
MOVS	R2, #2
MOVS	R1, #2
;func.c,96 :: 		&c10,&c11);
;func.c,95 :: 		ControlDigit(flag_t.current_status_temp, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.current_status,
;func.c,96 :: 		&c10,&c11);
BL	_ControlDigit+0
ADD	SP, SP, #12
;func.c,99 :: 		}
L_ControlOut9:
;func.c,100 :: 		if(flag_t.first_start==SET)
MOVW	R0, #lo_addr(_flag_t+11)
MOVT	R0, #hi_addr(_flag_t+11)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_ControlOut10
;func.c,103 :: 		MS_IN_CYCLE,&flag_t.status_first_step,&c,&c1);
MOVW	R3, #lo_addr(ControlOut_c1_L0+0)
MOVT	R3, #hi_addr(ControlOut_c1_L0+0)
MOVW	R2, #lo_addr(ControlOut_c_L0+0)
MOVT	R2, #hi_addr(ControlOut_c_L0+0)
MOVW	R1, #lo_addr(_flag_t+14)
MOVT	R1, #hi_addr(_flag_t+14)
;func.c,102 :: 		ControlDigit(flag_t.input_voltage_status_first_step, SET_DELAY,RESET_DELAY,
MOVW	R0, #lo_addr(_flag_t+2)
MOVT	R0, #hi_addr(_flag_t+2)
LDRB	R0, [R0, #0]
;func.c,103 :: 		MS_IN_CYCLE,&flag_t.status_first_step,&c,&c1);
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #10
;func.c,102 :: 		ControlDigit(flag_t.input_voltage_status_first_step, SET_DELAY,RESET_DELAY,
MOVS	R2, #30
MOVS	R1, #10
;func.c,103 :: 		MS_IN_CYCLE,&flag_t.status_first_step,&c,&c1);
BL	_ControlDigit+0
ADD	SP, SP, #12
;func.c,106 :: 		MS_IN_CYCLE,&flag_t.status_second_step,&c2,&c3);
MOVW	R3, #lo_addr(ControlOut_c3_L0+0)
MOVT	R3, #hi_addr(ControlOut_c3_L0+0)
MOVW	R2, #lo_addr(ControlOut_c2_L0+0)
MOVT	R2, #hi_addr(ControlOut_c2_L0+0)
MOVW	R1, #lo_addr(_flag_t+15)
MOVT	R1, #hi_addr(_flag_t+15)
;func.c,105 :: 		ControlDigit(flag_t.input_voltage_status_second_step, SET_DELAY,RESET_DELAY,
MOVW	R0, #lo_addr(_flag_t+3)
MOVT	R0, #hi_addr(_flag_t+3)
LDRB	R0, [R0, #0]
;func.c,106 :: 		MS_IN_CYCLE,&flag_t.status_second_step,&c2,&c3);
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #10
;func.c,105 :: 		ControlDigit(flag_t.input_voltage_status_second_step, SET_DELAY,RESET_DELAY,
MOVS	R2, #30
MOVS	R1, #10
;func.c,106 :: 		MS_IN_CYCLE,&flag_t.status_second_step,&c2,&c3);
BL	_ControlDigit+0
ADD	SP, SP, #12
;func.c,109 :: 		MS_IN_CYCLE,&flag_t.status_bypass,&c4,&c5);
MOVW	R3, #lo_addr(ControlOut_c5_L0+0)
MOVT	R3, #hi_addr(ControlOut_c5_L0+0)
MOVW	R2, #lo_addr(ControlOut_c4_L0+0)
MOVT	R2, #hi_addr(ControlOut_c4_L0+0)
MOVW	R1, #lo_addr(_flag_t+13)
MOVT	R1, #hi_addr(_flag_t+13)
;func.c,108 :: 		ControlDigit(flag_t.input_voltage_status_bypass, SET_DELAY,RESET_DELAY,
MOVW	R0, #lo_addr(_flag_t+5)
MOVT	R0, #hi_addr(_flag_t+5)
LDRB	R0, [R0, #0]
;func.c,109 :: 		MS_IN_CYCLE,&flag_t.status_bypass,&c4,&c5);
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #10
;func.c,108 :: 		ControlDigit(flag_t.input_voltage_status_bypass, SET_DELAY,RESET_DELAY,
MOVS	R2, #30
MOVS	R1, #10
;func.c,109 :: 		MS_IN_CYCLE,&flag_t.status_bypass,&c4,&c5);
BL	_ControlDigit+0
ADD	SP, SP, #12
;func.c,112 :: 		MS_IN_CYCLE,&flag_t.output_voltage_status,&c6,&c7);
MOVW	R3, #lo_addr(ControlOut_c7_L0+0)
MOVT	R3, #hi_addr(ControlOut_c7_L0+0)
MOVW	R2, #lo_addr(ControlOut_c6_L0+0)
MOVT	R2, #hi_addr(ControlOut_c6_L0+0)
MOVW	R1, #lo_addr(_flag_t+8)
MOVT	R1, #hi_addr(_flag_t+8)
;func.c,111 :: 		ControlDigit(flag_t.output_voltage_status_temp, (TIME_KOEF),(DIGITAL_DELAY_OFF*TIME_KOEF),
MOVW	R0, #lo_addr(_flag_t+16)
MOVT	R0, #hi_addr(_flag_t+16)
LDRB	R0, [R0, #0]
;func.c,112 :: 		MS_IN_CYCLE,&flag_t.output_voltage_status,&c6,&c7);
PUSH	(R3)
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #10
;func.c,111 :: 		ControlDigit(flag_t.output_voltage_status_temp, (TIME_KOEF),(DIGITAL_DELAY_OFF*TIME_KOEF),
MOVS	R2, #40
MOVS	R1, #20
;func.c,112 :: 		MS_IN_CYCLE,&flag_t.output_voltage_status,&c6,&c7);
BL	_ControlDigit+0
ADD	SP, SP, #12
;func.c,116 :: 		&c8,&c9);
MOVW	R3, #lo_addr(ControlOut_c9_L0+0)
MOVT	R3, #hi_addr(ControlOut_c9_L0+0)
MOVW	R2, #lo_addr(ControlOut_c8_L0+0)
MOVT	R2, #hi_addr(ControlOut_c8_L0+0)
;func.c,115 :: 		&flag_t.short_current_status,
MOVW	R1, #lo_addr(_flag_t+10)
MOVT	R1, #hi_addr(_flag_t+10)
;func.c,114 :: 		ControlDigit(flag_t.short_current_status_temp, CURRENT_SHORT_DELAY_ON,CURRENT_SHORT_DELAY_OFF,MS_IN_CYCLE,
MOVW	R0, #lo_addr(_flag_t+18)
MOVT	R0, #hi_addr(_flag_t+18)
LDRB	R0, [R0, #0]
;func.c,116 :: 		&c8,&c9);
PUSH	(R3)
PUSH	(R2)
;func.c,115 :: 		&flag_t.short_current_status,
PUSH	(R1)
;func.c,114 :: 		ControlDigit(flag_t.short_current_status_temp, CURRENT_SHORT_DELAY_ON,CURRENT_SHORT_DELAY_OFF,MS_IN_CYCLE,
MOVS	R3, #10
MOVS	R2, #3
MOVS	R1, #3
;func.c,116 :: 		&c8,&c9);
;func.c,115 :: 		&flag_t.short_current_status,
;func.c,116 :: 		&c8,&c9);
BL	_ControlDigit+0
ADD	SP, SP, #12
;func.c,120 :: 		&c10,&c11);
MOVW	R3, #lo_addr(ControlOut_c11_L0+0)
MOVT	R3, #hi_addr(ControlOut_c11_L0+0)
MOVW	R2, #lo_addr(ControlOut_c10_L0+0)
MOVT	R2, #hi_addr(ControlOut_c10_L0+0)
;func.c,119 :: 		MS_IN_CYCLE,&flag_t.current_status,
MOVW	R1, #lo_addr(_flag_t+9)
MOVT	R1, #hi_addr(_flag_t+9)
;func.c,118 :: 		ControlDigit(flag_t.current_status_temp, (TIME_KOEF),(CURRENT_SHORT_DELAY_OFF*TIME_KOEF),
MOVW	R0, #lo_addr(_flag_t+17)
MOVT	R0, #hi_addr(_flag_t+17)
LDRB	R0, [R0, #0]
;func.c,120 :: 		&c10,&c11);
PUSH	(R3)
PUSH	(R2)
;func.c,119 :: 		MS_IN_CYCLE,&flag_t.current_status,
PUSH	(R1)
MOVS	R3, #10
;func.c,118 :: 		ControlDigit(flag_t.current_status_temp, (TIME_KOEF),(CURRENT_SHORT_DELAY_OFF*TIME_KOEF),
MOVS	R2, #60
MOVS	R1, #20
;func.c,120 :: 		&c10,&c11);
;func.c,119 :: 		MS_IN_CYCLE,&flag_t.current_status,
;func.c,120 :: 		&c10,&c11);
BL	_ControlDigit+0
ADD	SP, SP, #12
;func.c,122 :: 		}
L_ControlOut10:
;func.c,125 :: 		bitWrite(status, 0,flag_t.status_first_step);
MOVW	R0, #lo_addr(_flag_t+14)
MOVT	R0, #hi_addr(_flag_t+14)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_ControlOut11
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
LDRB	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
STRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
; ?FLOC___ControlOut?T113 start address is: 0 (R0)
LDRB	R0, [R0, #0]
; ?FLOC___ControlOut?T113 end address is: 0 (R0)
IT	AL
BAL	L_ControlOut12
L_ControlOut11:
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
LDRB	R1, [R0, #0]
MVN	R0, #1
ANDS	R1, R0
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
STRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
; ?FLOC___ControlOut?T113 start address is: 0 (R0)
LDRB	R0, [R0, #0]
; ?FLOC___ControlOut?T113 end address is: 0 (R0)
L_ControlOut12:
;func.c,126 :: 		bitWrite(status, 1,flag_t.status_second_step);
MOVW	R0, #lo_addr(_flag_t+15)
MOVT	R0, #hi_addr(_flag_t+15)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_ControlOut13
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
LDRB	R0, [R0, #0]
ORR	R1, R0, #2
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
STRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
; ?FLOC___ControlOut?T117 start address is: 0 (R0)
LDRB	R0, [R0, #0]
; ?FLOC___ControlOut?T117 end address is: 0 (R0)
IT	AL
BAL	L_ControlOut14
L_ControlOut13:
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
LDRB	R1, [R0, #0]
MVN	R0, #2
ANDS	R1, R0
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
STRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
; ?FLOC___ControlOut?T117 start address is: 0 (R0)
LDRB	R0, [R0, #0]
; ?FLOC___ControlOut?T117 end address is: 0 (R0)
L_ControlOut14:
;func.c,127 :: 		bitWrite(status, 2,flag_t.status_bypass);
MOVW	R0, #lo_addr(_flag_t+13)
MOVT	R0, #hi_addr(_flag_t+13)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_ControlOut15
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
LDRB	R0, [R0, #0]
ORR	R1, R0, #4
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
STRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
; ?FLOC___ControlOut?T121 start address is: 0 (R0)
LDRB	R0, [R0, #0]
; ?FLOC___ControlOut?T121 end address is: 0 (R0)
IT	AL
BAL	L_ControlOut16
L_ControlOut15:
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
LDRB	R1, [R0, #0]
MVN	R0, #4
ANDS	R1, R0
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
STRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
; ?FLOC___ControlOut?T121 start address is: 0 (R0)
LDRB	R0, [R0, #0]
; ?FLOC___ControlOut?T121 end address is: 0 (R0)
L_ControlOut16:
;func.c,129 :: 		if(flag_t.start_button_status==RESET)
MOVW	R0, #lo_addr(_flag_t+1)
MOVT	R0, #hi_addr(_flag_t+1)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_ControlOut17
;func.c,131 :: 		flag_t.first_start = RESET;
MOVS	R1, #0
MOVW	R0, #lo_addr(_flag_t+11)
MOVT	R0, #hi_addr(_flag_t+11)
STRB	R1, [R0, #0]
;func.c,132 :: 		}
L_ControlOut17:
;func.c,134 :: 		if(flag_t.first_start==RESET)
MOVW	R0, #lo_addr(_flag_t+11)
MOVT	R0, #hi_addr(_flag_t+11)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_ControlOut18
;func.c,136 :: 		flag_t.current_global_status = SET;
MOVS	R1, #1
MOVW	R0, #lo_addr(_flag_t+12)
MOVT	R0, #hi_addr(_flag_t+12)
STRB	R1, [R0, #0]
;func.c,137 :: 		}
L_ControlOut18:
;func.c,139 :: 		if(flag_t.start_button_status==SET&&flag_t.current_status==SET&&flag_t.short_current_status==SET&&
MOVW	R0, #lo_addr(_flag_t+1)
MOVT	R0, #hi_addr(_flag_t+1)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__ControlOut63
MOVW	R0, #lo_addr(_flag_t+9)
MOVT	R0, #hi_addr(_flag_t+9)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__ControlOut62
MOVW	R0, #lo_addr(_flag_t+10)
MOVT	R0, #hi_addr(_flag_t+10)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__ControlOut61
;func.c,140 :: 		flag_t.current_global_status==SET)
MOVW	R0, #lo_addr(_flag_t+12)
MOVT	R0, #hi_addr(_flag_t+12)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__ControlOut60
L__ControlOut59:
;func.c,145 :: 		if(flag_t.output_voltage_status==SET)
MOVW	R0, #lo_addr(_flag_t+8)
MOVT	R0, #hi_addr(_flag_t+8)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_ControlOut22
;func.c,147 :: 		if((main_count++)>=MAIN_RELE_DELAY)
MOVW	R2, #lo_addr(ControlOut_main_count_L0+0)
MOVT	R2, #hi_addr(ControlOut_main_count_L0+0)
LDRH	R1, [R2, #0]
MOV	R0, R2
LDRH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R2, #0]
CMP	R1, #1400
IT	CC
BCC	L_ControlOut23
;func.c,149 :: 		main_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(ControlOut_main_count_L0+0)
MOVT	R0, #hi_addr(ControlOut_main_count_L0+0)
STRH	R1, [R0, #0]
;func.c,150 :: 		main_count1 = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(ControlOut_main_count1_L0+0)
MOVT	R0, #hi_addr(ControlOut_main_count1_L0+0)
STRH	R1, [R0, #0]
;func.c,151 :: 		RELE_OUT_MAIN = ON;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RELE_OUT_MAIN+0)
MOVT	R0, #hi_addr(RELE_OUT_MAIN+0)
_SX	[R0, ByteOffset(RELE_OUT_MAIN+0)]
;func.c,152 :: 		}
L_ControlOut23:
;func.c,154 :: 		}
L_ControlOut22:
;func.c,155 :: 		if(flag_t.output_voltage_status==RESET)
MOVW	R0, #lo_addr(_flag_t+8)
MOVT	R0, #hi_addr(_flag_t+8)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_ControlOut24
;func.c,157 :: 		if((main_count1++)>=(MAIN_RELE_DELAY/2))
MOVW	R2, #lo_addr(ControlOut_main_count1_L0+0)
MOVT	R2, #hi_addr(ControlOut_main_count1_L0+0)
LDRH	R1, [R2, #0]
MOV	R0, R2
LDRH	R0, [R0, #0]
ADDS	R0, R0, #1
STRH	R0, [R2, #0]
CMP	R1, #700
IT	CC
BCC	L_ControlOut25
;func.c,159 :: 		main_count= 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(ControlOut_main_count_L0+0)
MOVT	R0, #hi_addr(ControlOut_main_count_L0+0)
STRH	R1, [R0, #0]
;func.c,160 :: 		main_count1 = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(ControlOut_main_count1_L0+0)
MOVT	R0, #hi_addr(ControlOut_main_count1_L0+0)
STRH	R1, [R0, #0]
;func.c,161 :: 		RELE_OUT_MAIN = OFF;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(RELE_OUT_MAIN+0)
MOVT	R0, #hi_addr(RELE_OUT_MAIN+0)
_SX	[R0, ByteOffset(RELE_OUT_MAIN+0)]
;func.c,162 :: 		OutVoltage = 0;
MOV	R1, #0
MOVW	R0, #lo_addr(_OutVoltage+0)
MOVT	R0, #hi_addr(_OutVoltage+0)
STR	R1, [R0, #0]
;func.c,163 :: 		}
L_ControlOut25:
;func.c,165 :: 		}
L_ControlOut24:
;func.c,168 :: 		switch (status)
IT	AL
BAL	L_ControlOut26
;func.c,170 :: 		case 0b00000111:
L_ControlOut28:
;func.c,172 :: 		if(flag_t.output_voltage_status==SET)
MOVW	R0, #lo_addr(_flag_t+8)
MOVT	R0, #hi_addr(_flag_t+8)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_ControlOut29
;func.c,174 :: 		RELE_2 = OFF;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(RELE_2+0)
MOVT	R0, #hi_addr(RELE_2+0)
_SX	[R0, ByteOffset(RELE_2+0)]
;func.c,175 :: 		RELE_BYPASS = OFF;
MOVW	R0, #lo_addr(RELE_BYPASS+0)
MOVT	R0, #hi_addr(RELE_BYPASS+0)
_SX	[R0, ByteOffset(RELE_BYPASS+0)]
;func.c,176 :: 		if((rele_1_count++)>=DELAY_SWITCH)
MOVW	R2, #lo_addr(ControlOut_rele_1_count_L0+0)
MOVT	R2, #hi_addr(ControlOut_rele_1_count_L0+0)
LDRB	R1, [R2, #0]
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
STRB	R0, [R2, #0]
CMP	R1, #7
IT	CC
BCC	L_ControlOut30
;func.c,178 :: 		rele_1_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(ControlOut_rele_1_count_L0+0)
MOVT	R0, #hi_addr(ControlOut_rele_1_count_L0+0)
STRB	R1, [R0, #0]
;func.c,179 :: 		RELE_1 = ON;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RELE_1+0)
MOVT	R0, #hi_addr(RELE_1+0)
_SX	[R0, ByteOffset(RELE_1+0)]
;func.c,180 :: 		OutVoltage = ((InVoltageValue/KOEF_TRANSF)*2)+InVoltageValue;
MOVW	R0, #lo_addr(_InVoltageValue+0)
MOVT	R0, #hi_addr(_InVoltageValue+0)
LDR	R0, [R0, #0]
MOVW	R2, #0
MOVT	R2, #16560
BL	__Div_FP+0
MOV	R2, #1073741824
BL	__Mul_FP+0
MOVW	R1, #lo_addr(_InVoltageValue+0)
MOVT	R1, #hi_addr(_InVoltageValue+0)
LDR	R2, [R1, #0]
BL	__Add_FP+0
MOVW	R1, #lo_addr(_OutVoltage+0)
MOVT	R1, #hi_addr(_OutVoltage+0)
STR	R0, [R1, #0]
;func.c,181 :: 		}
L_ControlOut30:
;func.c,183 :: 		}
L_ControlOut29:
;func.c,185 :: 		break;
IT	AL
BAL	L_ControlOut27
;func.c,186 :: 		case 0b00000110:
L_ControlOut31:
;func.c,187 :: 		case 0b00000100:
L_ControlOut32:
;func.c,188 :: 		RELE_1 = OFF;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(RELE_1+0)
MOVT	R0, #hi_addr(RELE_1+0)
_SX	[R0, ByteOffset(RELE_1+0)]
;func.c,189 :: 		RELE_BYPASS = OFF;
MOVW	R0, #lo_addr(RELE_BYPASS+0)
MOVT	R0, #hi_addr(RELE_BYPASS+0)
_SX	[R0, ByteOffset(RELE_BYPASS+0)]
;func.c,190 :: 		if(flag_t.output_voltage_status==SET)
MOVW	R0, #lo_addr(_flag_t+8)
MOVT	R0, #hi_addr(_flag_t+8)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_ControlOut33
;func.c,192 :: 		if((rele_2_count++)>=DELAY_SWITCH)
MOVW	R2, #lo_addr(ControlOut_rele_2_count_L0+0)
MOVT	R2, #hi_addr(ControlOut_rele_2_count_L0+0)
LDRB	R1, [R2, #0]
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
STRB	R0, [R2, #0]
CMP	R1, #7
IT	CC
BCC	L_ControlOut34
;func.c,194 :: 		rele_2_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(ControlOut_rele_2_count_L0+0)
MOVT	R0, #hi_addr(ControlOut_rele_2_count_L0+0)
STRB	R1, [R0, #0]
;func.c,195 :: 		RELE_2 = ON;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RELE_2+0)
MOVT	R0, #hi_addr(RELE_2+0)
_SX	[R0, ByteOffset(RELE_2+0)]
;func.c,196 :: 		OutVoltage = ((InVoltageValue/KOEF_TRANSF)*1)+InVoltageValue;
MOVW	R0, #lo_addr(_InVoltageValue+0)
MOVT	R0, #hi_addr(_InVoltageValue+0)
LDR	R0, [R0, #0]
MOVW	R2, #0
MOVT	R2, #16560
BL	__Div_FP+0
MOVW	R1, #lo_addr(_InVoltageValue+0)
MOVT	R1, #hi_addr(_InVoltageValue+0)
LDR	R2, [R1, #0]
BL	__Add_FP+0
MOVW	R1, #lo_addr(_OutVoltage+0)
MOVT	R1, #hi_addr(_OutVoltage+0)
STR	R0, [R1, #0]
;func.c,197 :: 		}
L_ControlOut34:
;func.c,198 :: 		}
L_ControlOut33:
;func.c,200 :: 		break;
IT	AL
BAL	L_ControlOut27
;func.c,202 :: 		case 0b00000000:
L_ControlOut35:
;func.c,203 :: 		RELE_1 = OFF;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(RELE_1+0)
MOVT	R0, #hi_addr(RELE_1+0)
_SX	[R0, ByteOffset(RELE_1+0)]
;func.c,204 :: 		RELE_2 = OFF;
MOVW	R0, #lo_addr(RELE_2+0)
MOVT	R0, #hi_addr(RELE_2+0)
_SX	[R0, ByteOffset(RELE_2+0)]
;func.c,205 :: 		if(flag_t.output_voltage_status==SET)
MOVW	R0, #lo_addr(_flag_t+8)
MOVT	R0, #hi_addr(_flag_t+8)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_ControlOut36
;func.c,207 :: 		if((rele_bypass_count++)>=DELAY_SWITCH)
MOVW	R2, #lo_addr(ControlOut_rele_bypass_count_L0+0)
MOVT	R2, #hi_addr(ControlOut_rele_bypass_count_L0+0)
LDRB	R1, [R2, #0]
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
STRB	R0, [R2, #0]
CMP	R1, #7
IT	CC
BCC	L_ControlOut37
;func.c,209 :: 		rele_bypass_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(ControlOut_rele_bypass_count_L0+0)
MOVT	R0, #hi_addr(ControlOut_rele_bypass_count_L0+0)
STRB	R1, [R0, #0]
;func.c,210 :: 		RELE_BYPASS = ON;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RELE_BYPASS+0)
MOVT	R0, #hi_addr(RELE_BYPASS+0)
_SX	[R0, ByteOffset(RELE_BYPASS+0)]
;func.c,211 :: 		OutVoltage = InVoltageValue;
MOVW	R0, #lo_addr(_InVoltageValue+0)
MOVT	R0, #hi_addr(_InVoltageValue+0)
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(_OutVoltage+0)
MOVT	R0, #hi_addr(_OutVoltage+0)
STR	R1, [R0, #0]
;func.c,212 :: 		}
L_ControlOut37:
;func.c,214 :: 		}
L_ControlOut36:
;func.c,217 :: 		break;
IT	AL
BAL	L_ControlOut27
;func.c,218 :: 		}
L_ControlOut26:
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
LDRB	R0, [R0, #0]
CMP	R0, #7
IT	EQ
BEQ	L_ControlOut28
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	EQ
BEQ	L_ControlOut31
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	EQ
BEQ	L_ControlOut32
MOVW	R0, #lo_addr(_status+0)
MOVT	R0, #hi_addr(_status+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_ControlOut35
L_ControlOut27:
;func.c,219 :: 		}
IT	AL
BAL	L_ControlOut38
;func.c,139 :: 		if(flag_t.start_button_status==SET&&flag_t.current_status==SET&&flag_t.short_current_status==SET&&
L__ControlOut63:
L__ControlOut62:
L__ControlOut61:
;func.c,140 :: 		flag_t.current_global_status==SET)
L__ControlOut60:
;func.c,222 :: 		main_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(ControlOut_main_count_L0+0)
MOVT	R0, #hi_addr(ControlOut_main_count_L0+0)
STRH	R1, [R0, #0]
;func.c,223 :: 		main_count1 = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(ControlOut_main_count1_L0+0)
MOVT	R0, #hi_addr(ControlOut_main_count1_L0+0)
STRH	R1, [R0, #0]
;func.c,224 :: 		rele_1_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(ControlOut_rele_1_count_L0+0)
MOVT	R0, #hi_addr(ControlOut_rele_1_count_L0+0)
STRB	R1, [R0, #0]
;func.c,225 :: 		rele_2_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(ControlOut_rele_2_count_L0+0)
MOVT	R0, #hi_addr(ControlOut_rele_2_count_L0+0)
STRB	R1, [R0, #0]
;func.c,226 :: 		rele_bypass_count = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(ControlOut_rele_bypass_count_L0+0)
MOVT	R0, #hi_addr(ControlOut_rele_bypass_count_L0+0)
STRB	R1, [R0, #0]
;func.c,227 :: 		RELE_1 = OFF;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(RELE_1+0)
MOVT	R0, #hi_addr(RELE_1+0)
_SX	[R0, ByteOffset(RELE_1+0)]
;func.c,228 :: 		RELE_2 = OFF;
MOVW	R0, #lo_addr(RELE_2+0)
MOVT	R0, #hi_addr(RELE_2+0)
_SX	[R0, ByteOffset(RELE_2+0)]
;func.c,229 :: 		RELE_BYPASS = OFF;
MOVW	R0, #lo_addr(RELE_BYPASS+0)
MOVT	R0, #hi_addr(RELE_BYPASS+0)
_SX	[R0, ByteOffset(RELE_BYPASS+0)]
;func.c,230 :: 		RELE_OUT_MAIN = OFF;
MOVW	R0, #lo_addr(RELE_OUT_MAIN+0)
MOVT	R0, #hi_addr(RELE_OUT_MAIN+0)
_SX	[R0, ByteOffset(RELE_OUT_MAIN+0)]
;func.c,231 :: 		OutVoltage = 0;
MOV	R1, #0
MOVW	R0, #lo_addr(_OutVoltage+0)
MOVT	R0, #hi_addr(_OutVoltage+0)
STR	R1, [R0, #0]
;func.c,232 :: 		}
L_ControlOut38:
;func.c,234 :: 		}
L_end_ControlOut:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ControlOut
_StatusLed:
;func.c,237 :: 		void StatusLed()
;func.c,240 :: 		if(flag_t.first_start==SET)
MOVW	R0, #lo_addr(_flag_t+11)
MOVT	R0, #hi_addr(_flag_t+11)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L_StatusLed39
;func.c,242 :: 		if(flag_t.start_button_status==SET&&flag_t.current_status==SET&&flag_t.short_current_status==SET&&flag_t.current_global_status==SET)
MOVW	R0, #lo_addr(_flag_t+1)
MOVT	R0, #hi_addr(_flag_t+1)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__StatusLed58
MOVW	R0, #lo_addr(_flag_t+9)
MOVT	R0, #hi_addr(_flag_t+9)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__StatusLed57
MOVW	R0, #lo_addr(_flag_t+10)
MOVT	R0, #hi_addr(_flag_t+10)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__StatusLed56
MOVW	R0, #lo_addr(_flag_t+12)
MOVT	R0, #hi_addr(_flag_t+12)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__StatusLed55
L__StatusLed54:
;func.c,244 :: 		if ((++count_st_led1) >= 100)
MOVW	R1, #lo_addr(StatusLed_count_st_led1_L0+0)
MOVT	R1, #hi_addr(StatusLed_count_st_led1_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #100
IT	CC
BCC	L_StatusLed43
;func.c,246 :: 		count_st_led1 = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(StatusLed_count_st_led1_L0+0)
MOVT	R0, #hi_addr(StatusLed_count_st_led1_L0+0)
STRB	R1, [R0, #0]
;func.c,247 :: 		LED_GREEN^= 1;
MOVW	R1, #lo_addr(LED_GREEN+0)
MOVT	R1, #hi_addr(LED_GREEN+0)
_LX	[R1, ByteOffset(LED_GREEN+0)]
EOR	R0, R0, #1
_SX	[R1, ByteOffset(LED_GREEN+0)]
;func.c,248 :: 		}
L_StatusLed43:
;func.c,250 :: 		}
IT	AL
BAL	L_StatusLed44
;func.c,242 :: 		if(flag_t.start_button_status==SET&&flag_t.current_status==SET&&flag_t.short_current_status==SET&&flag_t.current_global_status==SET)
L__StatusLed58:
L__StatusLed57:
L__StatusLed56:
L__StatusLed55:
;func.c,253 :: 		if ((++count_st_led2) >= 50)
MOVW	R1, #lo_addr(StatusLed_count_st_led2_L0+0)
MOVT	R1, #hi_addr(StatusLed_count_st_led2_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #50
IT	CC
BCC	L_StatusLed45
;func.c,255 :: 		count_st_led2 = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(StatusLed_count_st_led2_L0+0)
MOVT	R0, #hi_addr(StatusLed_count_st_led2_L0+0)
STRB	R1, [R0, #0]
;func.c,256 :: 		LED_GREEN^= 1;
MOVW	R1, #lo_addr(LED_GREEN+0)
MOVT	R1, #hi_addr(LED_GREEN+0)
_LX	[R1, ByteOffset(LED_GREEN+0)]
EOR	R0, R0, #1
_SX	[R1, ByteOffset(LED_GREEN+0)]
;func.c,257 :: 		}
L_StatusLed45:
;func.c,259 :: 		}
L_StatusLed44:
;func.c,262 :: 		}
IT	AL
BAL	L_StatusLed46
L_StatusLed39:
;func.c,265 :: 		if ((++count_st_led) >= 10)
MOVW	R1, #lo_addr(StatusLed_count_st_led_L0+0)
MOVT	R1, #hi_addr(StatusLed_count_st_led_L0+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
CMP	R0, #10
IT	CC
BCC	L_StatusLed47
;func.c,267 :: 		count_st_led = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(StatusLed_count_st_led_L0+0)
MOVT	R0, #hi_addr(StatusLed_count_st_led_L0+0)
STRB	R1, [R0, #0]
;func.c,268 :: 		LED_GREEN^= 1;
MOVW	R1, #lo_addr(LED_GREEN+0)
MOVT	R1, #hi_addr(LED_GREEN+0)
_LX	[R1, ByteOffset(LED_GREEN+0)]
EOR	R0, R0, #1
_SX	[R1, ByteOffset(LED_GREEN+0)]
;func.c,269 :: 		}
L_StatusLed47:
;func.c,271 :: 		}
L_StatusLed46:
;func.c,273 :: 		}
L_end_StatusLed:
BX	LR
; end of _StatusLed
_ControlDigit:
;func.c,277 :: 		unsigned int *count_ci, unsigned int* count_ci1)
; ms_in_one_cycle start address is: 12 (R3)
; delay_reset start address is: 8 (R2)
; delay_set start address is: 4 (R1)
; in_value start address is: 0 (R0)
; ms_in_one_cycle end address is: 12 (R3)
; delay_reset end address is: 8 (R2)
; delay_set end address is: 4 (R1)
; in_value end address is: 0 (R0)
; in_value start address is: 0 (R0)
; delay_set start address is: 4 (R1)
; delay_reset start address is: 8 (R2)
; ms_in_one_cycle start address is: 12 (R3)
; status start address is: 24 (R6)
LDR	R6, [SP, #0]
; count_ci start address is: 28 (R7)
LDR	R7, [SP, #4]
; count_ci1 start address is: 32 (R8)
LDR	R8, [SP, #8]
;func.c,279 :: 		if (in_value == SET)
CMP	R0, #1
IT	NE
BNE	L_ControlDigit48
;func.c,282 :: 		if ((++*count_ci) == ((unsigned int)delay_set*(1000 / ms_in_one_cycle)))
LDRH	R4, [R7, #0]
ADDS	R4, R4, #1
STRH	R4, [R7, #0]
LDRH	R5, [R7, #0]
MOVW	R4, #1000
UDIV	R4, R4, R3
UXTH	R4, R4
MULS	R4, R1, R4
UXTH	R4, R4
; delay_set end address is: 4 (R1)
CMP	R5, R4
IT	NE
BNE	L_ControlDigit49
;func.c,284 :: 		*count_ci = 0;
MOVS	R4, #0
STRH	R4, [R7, #0]
;func.c,285 :: 		*count_ci1 = 0;
MOVS	R4, #0
STRH	R4, [R8, #0]
;func.c,286 :: 		if (in_value == SET)
CMP	R0, #1
IT	NE
BNE	L_ControlDigit50
;func.c,288 :: 		*status = 1;
MOVS	R4, #1
STRB	R4, [R6, #0]
;func.c,289 :: 		}
L_ControlDigit50:
;func.c,290 :: 		}
L_ControlDigit49:
;func.c,292 :: 		}
L_ControlDigit48:
;func.c,294 :: 		if (in_value == RESET)
CMP	R0, #0
IT	NE
BNE	L_ControlDigit51
;func.c,297 :: 		if ((++*count_ci1) == ((unsigned int)delay_reset*(1000 / ms_in_one_cycle)))
LDRH	R4, [R8, #0]
ADDS	R4, R4, #1
STRH	R4, [R8, #0]
LDRH	R5, [R8, #0]
MOVW	R4, #1000
UDIV	R4, R4, R3
UXTH	R4, R4
; ms_in_one_cycle end address is: 12 (R3)
MULS	R4, R2, R4
UXTH	R4, R4
; delay_reset end address is: 8 (R2)
CMP	R5, R4
IT	NE
BNE	L_ControlDigit52
;func.c,299 :: 		*count_ci = 0;
MOVS	R4, #0
STRH	R4, [R7, #0]
; count_ci end address is: 28 (R7)
;func.c,300 :: 		*count_ci1 = 0;
MOVS	R4, #0
STRH	R4, [R8, #0]
; count_ci1 end address is: 32 (R8)
;func.c,301 :: 		if (in_value == RESET)
CMP	R0, #0
IT	NE
BNE	L_ControlDigit53
; in_value end address is: 0 (R0)
;func.c,303 :: 		*status = 0;
MOVS	R4, #0
STRB	R4, [R6, #0]
; status end address is: 24 (R6)
;func.c,304 :: 		}
L_ControlDigit53:
;func.c,305 :: 		}
L_ControlDigit52:
;func.c,307 :: 		}
L_ControlDigit51:
;func.c,308 :: 		}
L_end_ControlDigit:
BX	LR
; end of _ControlDigit
