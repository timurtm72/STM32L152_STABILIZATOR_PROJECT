#include "hider.h"

//==============================================================================
void main()
{
 Init_flags();
 Init_ADC_chanell();
 Init_LCD();
 Init_pin();
 EnableInterrupts();
 StartMainTimer_10ms();
 WDT_Init();
 EnableInterrupts();

//==============================================================================
while(TRUE)
 {
    globalProcess();
 }
}