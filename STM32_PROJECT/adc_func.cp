#line 1 "G:/MY PROJECTS/Stabilizator/STM32_PROJECT/adc_func.c"
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
#line 4 "G:/MY PROJECTS/Stabilizator/STM32_PROJECT/adc_func.c"
void Init_ADC_chanell()
{
 ADC_CCRbits.ADCPRE = 0x02;
 ADC1_Init();
 ADC_Set_Input_Channel(_ADC_CHANNEL_4|_ADC_CHANNEL_5);
#line 14 "G:/MY PROJECTS/Stabilizator/STM32_PROJECT/adc_func.c"
}

struct flag flag_t;

volatile float InVoltageValue = 0,OutVoltageValue = 0,CurrentValue = 0;

void ReadAnalogInput()
{
 static unsigned char rai_count = 0;
 if((rai_count++)>=50)
 {
 rai_count=0;
 InVoltageValue = Read_ADC_chanell( 4 ,10, 2.0 );
 CurrentValue = Read_ADC_chanell( 5 ,10, 7.0 );
 }

}


float Read_ADC_chanell(char chanell,unsigned char samples,float koef)
{
 float temp = 0,temp1 = 0;
 unsigned char i = 0;
 for(i=0;i<samples;i++)
 {
 temp = (ADC1_Get_Sample(chanell)>>2);
 temp1+=temp;
 Delay_us(150);
 }

 return ((float)((temp1/samples)/koef));



}

void ControlAnalogFlags()
{
 static unsigned int input_voltage_status_first_step_count = 0,input_voltage_status_first_step_count1 = 0;
 static unsigned int input_voltage_status_second_step_count = 0,input_voltage_status_second_step_count1 = 0;
 static unsigned int current_status_count = 0,current_status_count1 = 0;
 static unsigned int input_voltage_status_bypass_count = 0,input_voltage_status_bypass_count1 = 0;
 static unsigned int output_voltage_status_count = 0,output_voltage_status_count1 = 0;
 static unsigned int short_current_status_count = 0,short_current_status_count1 = 0;

 if((flag_t.short_current_status== 0 ||flag_t.current_status== 0 )&&flag_t.first_start== 1 )
 {
 flag_t.current_global_status =  0 ;
 }


 one_level_comparator( 170.0 ,InVoltageValue, 5.0 , 2.0 , 2.0 , 10 ,
 &flag_t.input_voltage_status_first_step,&input_voltage_status_first_step_count,
 &input_voltage_status_first_step_count1);

 one_level_comparator( 210.0 ,InVoltageValue, 5.0 , 2.0 , 2.0 , 10 ,
 &flag_t.input_voltage_status_second_step,&input_voltage_status_second_step_count,
 &input_voltage_status_second_step_count1);

 one_level_comparator( 100.0 ,CurrentValue, 5.0 , 2.0 ,
  2.0 , 10 ,&flag_t.current_status_temp,&current_status_count,
 &current_status_count1);

 one_level_comparator( 120.0 ,CurrentValue, 5.0 , 3.0 , 3.0 , 10 ,
 &flag_t.short_current_status_temp,&short_current_status_count,
 &short_current_status_count1);

 one_level_comparator( 230.0 ,InVoltageValue, 5.0 , 2.0 , 2.0 , 10 ,
 &flag_t.input_voltage_status_bypass,&input_voltage_status_bypass_count,
 &input_voltage_status_bypass_count1);
#line 89 "G:/MY PROJECTS/Stabilizator/STM32_PROJECT/adc_func.c"
 one_level_comparator( 270.0 ,OutVoltageValue, 5.0 , 2.0 , 2.0 , 10 ,
 &flag_t.output_voltage_status_temp,&output_voltage_status_count,
 &output_voltage_status_count1);
}

void one_level_comparator(float reference,float value, float gisteresis,
unsigned int delay_on_sec,unsigned int delay_off_sec,unsigned char ms_in_one_cycle,char* status,
unsigned int* count_olc,unsigned int* count_olc1)
{
 if(value>=(reference+gisteresis))
 {
 if(++(*count_olc)>=((unsigned int)delay_off_sec*(1000/ms_in_one_cycle)))
 {
 *count_olc = 0;
 *count_olc1=0;

 if(value>=(reference+gisteresis))
 {
 *status = 0;
 }
 }
 }



 if(value<=(reference-gisteresis))
 {
 if(++(*count_olc1)>=((unsigned int)delay_on_sec*(1000/ms_in_one_cycle)))
 {
 *count_olc = 0;
 *count_olc1=0;

 if(value<=(reference-gisteresis))
 {
 *status = 1;
 }
 }
 }
}

void two_level_comparator(float high_reference,float low_reference,float value,
 float gisteresis, unsigned int delay_on_sec_tlc,unsigned int delay_off_sec_tlc,
 unsigned char ms_in_one_cycle_tlc,char* status_tlc,unsigned int* count_tlc,
 unsigned int* count_tlc1)
{
 if( (value>=(high_reference+gisteresis))||(value<=(low_reference-gisteresis)))
 {

 if(++(*count_tlc)>=((unsigned int)delay_off_sec_tlc*(1000/ms_in_one_cycle_tlc)))
 {
 *count_tlc = 0;
 *count_tlc1 = 0;
 if((value>=(high_reference+gisteresis))||(value<=(low_reference-gisteresis)))
 {
 *status_tlc = 0;
 }

 }

 }

 if((value<=(high_reference-gisteresis))&&(value>=(low_reference+gisteresis)))
 {

 if(++(*count_tlc1)>=((unsigned int)delay_on_sec_tlc*(1000/ms_in_one_cycle_tlc)))
 {
 *count_tlc = 0;
 *count_tlc1=0;
 if((value<=(high_reference-gisteresis))&&(value>=(low_reference+gisteresis)))
 {
 *status_tlc = 1;
 }

 }
 }
}
