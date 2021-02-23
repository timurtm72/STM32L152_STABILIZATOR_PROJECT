#include "hider.h"
//==============================================================================
void main_timer_func() iv IVT_INT_TIM2 ics ICS_AUTO 
{
static unsigned int first_start_count = 0;
static unsigned int current_global_status_count = 0;
  TIM2_SRbits.UIF = 0;
  flag_t.ovf_flag = SET;
//------------------------------------------------------------------------------

        flag_t.ovf_flag = SET;

        if(flag_t.first_start==RESET)
        {
            if((first_start_count++)>=((unsigned int)DELAY_FIRST_START*(1000/MS_IN_CYCLE)))
                {
                        first_start_count = 0;
                        flag_t.first_start = SET;
                }

        }

        if(flag_t.current_global_status==RESET)
        {
                if((current_global_status_count++)>=((unsigned int)DELAY_AFTER_CURRENT*(1000/MS_IN_CYCLE)))
                {
                        current_global_status_count = 0;
                        flag_t.current_global_status = SET;
                }
        }


//------------------------------------------------------------------------------
}
//==============================================================================
void key_timer_interrupt() iv IVT_INT_TIM3 ics ICS_AUTO
{
  TIM3_SRbits.UIF = 0;
}
//==============================================================================
//Timer2 Prescaler :4; Preload = 63999; Actual Interrupt Time = 10 ms
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
//==============================================================================
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
//==============================================================================
void Read_key()
{

}
//==============================================================================
void Scan_pin(unsigned char *k_b)
{

}
//==============================================================================
//Timer3 Prescaler :99; Preload = 63999; Actual Interrupt Time = 200 ms

//Place/Copy this part in declaration section
void Start_key_timer(){
  RCC_APB1ENRbits.TIM3EN = 1;
  TIM3_CR1bits.CEN = 0;
  TIM3_PSC = 99;
  TIM3_ARR = 63999;
  NVIC_IntEnable(IVT_INT_TIM3);
  TIM3_DIERbits.UIE = 1;
  TIM3_CR1bits.CEN = 1;
}
//==============================================================================
void Stop_key_timer(){
  RCC_APB1ENRbits.TIM3EN = 0;
  TIM3_CR1bits.CEN = 0;
  TIM3_PSC = 0;
  TIM3_ARR = 0;
  NVIC_IntDisable(IVT_INT_TIM3);
  TIM3_DIERbits.UIE = 0;
  TIM3_CR1bits.CEN = 0;
}
//==============================================================================
void WDT_Init()
{
   RCC_CSRbits.LSION = 1;
   while(!RCC_CSRbits.LSIRDY);
   IWDG_KR = 0x5555;      //write with protect
   IWDG_PRbits.PR = 0x00;  //prescaler
   IWDG_KR = 0xCCCC;      //start watchdog
   IWDG_KR = 0xAAAA;      //reset watchdog
                          //PCKL/4096/prescaler,LSI clock speed 37kHz
                          //000: divider /4
                          //001: divider /8
                          //010: divider /16
                          //011: divider /32
                          //100: divider /64
                          //101: divider /128
                          //110: divider /256
                          //111: divider /256

}
//==============================================================================
void clear_WDT()
{
   IWDG_KR = 0xAAAA;      //reset watchdog
}
//==============================================================================
void setPreloadValue(unsigned long value)
{
  while(IWDG_SRbits.PVU);
  IWDG_KR = 0x5555;
  IWDG_PR = value;

}