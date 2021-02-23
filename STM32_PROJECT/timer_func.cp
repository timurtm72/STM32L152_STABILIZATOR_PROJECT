#line 1 "G:/MY PROJECTS/Stabilizator/STM32_PROJECT/timer_func.c"
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
#line 3 "G:/MY PROJECTS/Stabilizator/STM32_PROJECT/timer_func.c"
void main_timer_func() iv IVT_INT_TIM2 ics ICS_AUTO
{
static unsigned int first_start_count = 0;
static unsigned int current_global_status_count = 0;
 TIM2_SRbits.UIF = 0;
 flag_t.ovf_flag =  1 ;


 flag_t.ovf_flag =  1 ;

 if(flag_t.first_start== 0 )
 {
 if((first_start_count++)>=((unsigned int) 20.0 *(1000/ 10 )))
 {
 first_start_count = 0;
 flag_t.first_start =  1 ;
 }

 }

 if(flag_t.current_global_status== 0 )
 {
 if((current_global_status_count++)>=((unsigned int) 50.0 *(1000/ 10 )))
 {
 current_global_status_count = 0;
 flag_t.current_global_status =  1 ;
 }
 }



}

void key_timer_interrupt() iv IVT_INT_TIM3 ics ICS_AUTO
{
 TIM3_SRbits.UIF = 0;
}


void StartMainTimer_10ms()
{
 RCC_APB1ENRbits.TIM2EN=1;
 TIM2_CR1bits.CEN = 0;
 TIM2_PSC = 4;
 TIM2_ARR = 63999;
 NVIC_IntEnable(IVT_INT_TIM2);
 TIM2_DIERbits.UIE = 1;
 TIM2_CR1bits.CEN = 1;
}

void StopMainTimer_10ms()
{
 RCC_APB1ENRbits.TIM2EN=0;
 TIM2_CR1bits.CEN = 0;
 TIM2_PSC = 0;
 TIM2_ARR = 0;
 NVIC_IntDisable(IVT_INT_TIM2);
 TIM2_DIERbits.UIE = 0;
 TIM2_CR1bits.CEN = 0;
}

void Read_key()
{

}

void Scan_pin(unsigned char *k_b)
{

}




void Start_key_timer(){
 RCC_APB1ENRbits.TIM3EN = 1;
 TIM3_CR1bits.CEN = 0;
 TIM3_PSC = 99;
 TIM3_ARR = 63999;
 NVIC_IntEnable(IVT_INT_TIM3);
 TIM3_DIERbits.UIE = 1;
 TIM3_CR1bits.CEN = 1;
}

void Stop_key_timer(){
 RCC_APB1ENRbits.TIM3EN = 0;
 TIM3_CR1bits.CEN = 0;
 TIM3_PSC = 0;
 TIM3_ARR = 0;
 NVIC_IntDisable(IVT_INT_TIM3);
 TIM3_DIERbits.UIE = 0;
 TIM3_CR1bits.CEN = 0;
}

void WDT_Init()
{
 RCC_CSRbits.LSION = 1;
 while(!RCC_CSRbits.LSIRDY);
 IWDG_KR = 0x5555;
 IWDG_PRbits.PR = 0x00;
 IWDG_KR = 0xCCCC;
 IWDG_KR = 0xAAAA;










}

void clear_WDT()
{
 IWDG_KR = 0xAAAA;
}

void setPreloadValue(unsigned long value)
{
 while(IWDG_SRbits.PVU);
 IWDG_KR = 0x5555;
 IWDG_PR = value;

}
