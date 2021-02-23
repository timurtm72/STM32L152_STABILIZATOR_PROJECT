#line 1 "G:/MY PROJECTS/Stabilizator/STM32_PROJECT/func.c"
#line 1 "g:/my projects/stabilizator/stm32_project/hider.h"
#line 53 "g:/my projects/stabilizator/stm32_project/hider.h"
extern sfr sbit RELE_1;
extern sfr sbit RELE_2;
extern sfr sbit RELE_BYPASS;
extern sfr sbit RELE_OUT_MAIN;

extern sfr sbit LED_BLUE;
extern sfr sbit LED_GREEN;

extern sfr sbit START_BUTTON;
extern sfr sbit CHANGE_BUTTON;

struct flag {

 char ovf_flag;
 char start_button_status;
 char input_voltage_status_first_step;
 char input_voltage_status_second_step;
 char status_main_contactor;
 char input_voltage_status_bypass;
 char input_voltage_status_hight;
 char input_voltage_status_lo;
 char output_voltage_status;
 char current_status;
 char short_current_status;
 char first_start;
 char current_global_status;
 char status_bypass;
 char status_first_step;
 char status_second_step;
 char output_voltage_status_temp;
 char current_status_temp;
 char short_current_status_temp;
 char change_button_status;

};
extern struct flag flag_t;

struct process_values {
 float mesurment_pressure ;

};

extern volatile float InVoltageValue,OutVoltageValue,CurrentValue;

void Init_flags();
void Init_pin();
void StartMainTimer_10ms();
void Init_ADC_chanell();
void ReadAnalogInput();
float Read_ADC_chanell(char chanell,unsigned char samples,float koef);
void ControlAnalogFlags();
void one_level_comparator(float reference,float value, float gisteresis,
 unsigned int delay_on_sec,unsigned int delay_off_sec,unsigned char ms_in_one_cycle,char* status,
 unsigned int* count_olc,unsigned int* count_olc1);
void two_level_comparator(float high_reference,float low_reference,float value,
 float gisteresis, unsigned int delay_on_sec_tlc,unsigned int delay_off_sec_tlc,
 unsigned char ms_in_one_cycle_tlc,char* status_tlc,unsigned int* count_tlc,
 unsigned int* count_tlc1);
void ControlDigitalFlags();
void ControlOut();
void ControlDigit(unsigned char in_value, unsigned int delay_set,
 unsigned int delay_reset, unsigned int ms_in_one_cycle, char *status,
 unsigned int *count_ci, unsigned int* count_ci1);
void globalProcess();
void StatusLed();
void WDT_Init();
void clear_WDT();
void setPreloadValue(unsigned long value);
void Write_data_to_LCD(char str_start,char str_end,float value);
void Out_data_to_LCD(char str_start,char str_end,float process_value);
void displayData();
void Init_LCD();
void LCD_bar_status();
void clear_LCD();
#line 4 "G:/MY PROJECTS/Stabilizator/STM32_PROJECT/func.c"
void displayData()
{
 static char in_reset = 0;
 static char state = 0;
 static unsigned int count_data = 0;

 if(flag_t.change_button_status== 1 )
 {
 if(in_reset== 0 )
 {
 in_reset= 1 ;

 state^=1;

 }
 }
 if(flag_t.change_button_status== 0 )
 {
 in_reset =  0 ;
 }
 if((count_data++)>=100)
 {
 count_data = 0;
 LCD_bar_status();
 switch(state)
 {
 case 0: Out_data_to_LCD('H','B',InVoltageValue);
 break;
 case 1: Out_data_to_LCD('T','A',CurrentValue);
 break;
 }
 }
}


void ControlDigitalFlags()
{
static unsigned int start_button_status_count1 = 0, start_button_status_count2 = 0
 ,change_button_status_count = 0,change_button_status_count1 = 0;

ControlDigit(START_BUTTON,  2.0 , 2.0 ,
  10 , &flag_t.start_button_status,
 &start_button_status_count1, &start_button_status_count2);
ControlDigit(CHANGE_BUTTON, 1,1,
  10 , &flag_t.change_button_status,
 &change_button_status_count, &change_button_status_count1);

}

void globalProcess()
{
if (flag_t.ovf_flag ==  1 )
 {
 flag_t.ovf_flag =  0 ;
 clear_WDT();

 StatusLed();
 ControlDigitalFlags();
 ControlAnalogFlags();
 ReadAnalogInput();
 ControlOut();
 displayData();
 }
}

volatile float OutVoltage;
volatile unsigned char status = 0;
void ControlOut()
{
 static unsigned int main_count = 0,main_count1 = 0;
 static char rele_1_count = 0,rele_2_count = 0,rele_bypass_count = 0;

 static unsigned int c = 0,c1 = 0,c2 = 0,c3 = 0,c4 = 0,c5 = 0,c6 = 0,c7 = 0,c8 = 0,c9 = 0,c10 = 0,c11 = 0;

 if(flag_t.first_start== 0 )
 {
 ControlDigit(flag_t.input_voltage_status_first_step,  2.0 , 2.0 , 10 ,&flag_t.status_first_step,
 &c,&c1);

 ControlDigit(flag_t.input_voltage_status_second_step,  2.0 , 2.0 , 10 ,&flag_t.status_second_step,
 &c2,&c3);

 ControlDigit(flag_t.input_voltage_status_bypass,  2.0 , 2.0 , 10 ,&flag_t.status_bypass,
 &c4,&c5);

 ControlDigit(flag_t.output_voltage_status_temp,  2.0 , 2.0 , 10 ,&flag_t.output_voltage_status,
 &c6,&c7);

 ControlDigit(flag_t.short_current_status_temp,  3.0 , 3.0 , 10 ,&flag_t.short_current_status,
 &c8,&c9);

 ControlDigit(flag_t.current_status_temp,  2.0 , 2.0 , 10 ,&flag_t.current_status,
 &c10,&c11);


 }
 if(flag_t.first_start== 1 )
 {
 ControlDigit(flag_t.input_voltage_status_first_step,  10 , 30 ,
  10 ,&flag_t.status_first_step,&c,&c1);

 ControlDigit(flag_t.input_voltage_status_second_step,  10 , 30 ,
  10 ,&flag_t.status_second_step,&c2,&c3);

 ControlDigit(flag_t.input_voltage_status_bypass,  10 , 30 ,
  10 ,&flag_t.status_bypass,&c4,&c5);

 ControlDigit(flag_t.output_voltage_status_temp, ( 20 ),( 2.0 * 20 ),
  10 ,&flag_t.output_voltage_status,&c6,&c7);

 ControlDigit(flag_t.short_current_status_temp,  3.0 , 3.0 , 10 ,
 &flag_t.short_current_status,
 &c8,&c9);

 ControlDigit(flag_t.current_status_temp, ( 20 ),( 3.0 * 20 ),
  10 ,&flag_t.current_status,
 &c10,&c11);

 }


  (flag_t.status_first_step ? ((status) |= (1UL << (0)))  : ((status) &= ~(1UL << (0))) ) ;
  (flag_t.status_second_step ? ((status) |= (1UL << (1)))  : ((status) &= ~(1UL << (1))) ) ;
  (flag_t.status_bypass ? ((status) |= (1UL << (2)))  : ((status) &= ~(1UL << (2))) ) ;

 if(flag_t.start_button_status== 0 )
 {
 flag_t.first_start =  0 ;
 }

 if(flag_t.first_start== 0 )
 {
 flag_t.current_global_status =  1 ;
 }

 if(flag_t.start_button_status== 1 &&flag_t.current_status== 1 &&flag_t.short_current_status== 1 &&
 flag_t.current_global_status== 1 )
 {



 if(flag_t.output_voltage_status== 1 )
 {
 if((main_count++)>= 1400 )
 {
 main_count = 0;
 main_count1 = 0;
 RELE_OUT_MAIN =  1 ;
 }

 }
 if(flag_t.output_voltage_status== 0 )
 {
 if((main_count1++)>=( 1400 /2))
 {
 main_count= 0;
 main_count1 = 0;
 RELE_OUT_MAIN =  0 ;
 OutVoltage = 0;
 }

 }


 switch (status)
 {
 case 0b00000111:

 if(flag_t.output_voltage_status== 1 )
 {
 RELE_2 =  0 ;
 RELE_BYPASS =  0 ;
 if((rele_1_count++)>= 7 )
 {
 rele_1_count = 0;
 RELE_1 =  1 ;
 OutVoltage = ((InVoltageValue/ 5.5 )*2)+InVoltageValue;
 }

 }

 break;
 case 0b00000110:
 case 0b00000100:
 RELE_1 =  0 ;
 RELE_BYPASS =  0 ;
 if(flag_t.output_voltage_status== 1 )
 {
 if((rele_2_count++)>= 7 )
 {
 rele_2_count = 0;
 RELE_2 =  1 ;
 OutVoltage = ((InVoltageValue/ 5.5 )*1)+InVoltageValue;
 }
 }

 break;

 case 0b00000000:
 RELE_1 =  0 ;
 RELE_2 =  0 ;
 if(flag_t.output_voltage_status== 1 )
 {
 if((rele_bypass_count++)>= 7 )
 {
 rele_bypass_count = 0;
 RELE_BYPASS =  1 ;
 OutVoltage = InVoltageValue;
 }

 }


 break;
 }
 }
 else
 {
 main_count = 0;
 main_count1 = 0;
 rele_1_count = 0;
 rele_2_count = 0;
 rele_bypass_count = 0;
 RELE_1 =  0 ;
 RELE_2 =  0 ;
 RELE_BYPASS =  0 ;
 RELE_OUT_MAIN =  0 ;
 OutVoltage = 0;
 }

}


void StatusLed()
{
 static unsigned char count_st_led = 0,count_st_led1 = 0,count_st_led2 = 0;
 if(flag_t.first_start== 1 )
 {
 if(flag_t.start_button_status== 1 &&flag_t.current_status== 1 &&flag_t.short_current_status== 1 &&flag_t.current_global_status== 1 )
 {
 if ((++count_st_led1) >= 100)
 {
 count_st_led1 = 0;
 LED_GREEN^= 1;
 }

 }
 else
 {
 if ((++count_st_led2) >= 50)
 {
 count_st_led2 = 0;
 LED_GREEN^= 1;
 }

 }


 }
 else
 {
 if ((++count_st_led) >= 10)
 {
 count_st_led = 0;
 LED_GREEN^= 1;
 }

 }

}

void ControlDigit(unsigned char in_value, unsigned int delay_set,
 unsigned int delay_reset, unsigned int ms_in_one_cycle, char *status,
 unsigned int *count_ci, unsigned int* count_ci1)
{
 if (in_value ==  1 )
 {

 if ((++*count_ci) == ((unsigned int)delay_set*(1000 / ms_in_one_cycle)))
 {
 *count_ci = 0;
 *count_ci1 = 0;
 if (in_value ==  1 )
 {
 *status = 1;
 }
 }

 }

 if (in_value ==  0 )
 {

 if ((++*count_ci1) == ((unsigned int)delay_reset*(1000 / ms_in_one_cycle)))
 {
 *count_ci = 0;
 *count_ci1 = 0;
 if (in_value ==  0 )
 {
 *status = 0;
 }
 }

 }
}
