#include "hider.h"
//struct flag flag_t;
//==============================================================================
void displayData()
{
 static char in_reset = 0;
 static char state = 0;
 static unsigned int count_data = 0;
 
   if(flag_t.change_button_status==SET)
    {
      if(in_reset==RESET)
       {
         in_reset=SET;
         //LED_BLUE^=1;
         state^=1;

       }
    }
   if(flag_t.change_button_status==RESET)
      {
         in_reset = RESET;
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

//==============================================================================
void ControlDigitalFlags()
{
static unsigned int start_button_status_count1 = 0, start_button_status_count2 = 0
                    ,change_button_status_count = 0,change_button_status_count1 = 0;

ControlDigit(START_BUTTON, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,
            MS_IN_CYCLE, &flag_t.start_button_status,
            &start_button_status_count1, &start_button_status_count2);
ControlDigit(CHANGE_BUTTON, 1,1,
            MS_IN_CYCLE, &flag_t.change_button_status,
            &change_button_status_count, &change_button_status_count1);

}
//==============================================================================
void globalProcess()
{
if (flag_t.ovf_flag == SET)
  {
    flag_t.ovf_flag = RESET;
    clear_WDT();
    //==========================================================================
    StatusLed();
    ControlDigitalFlags();
    ControlAnalogFlags();
    ReadAnalogInput();
    ControlOut();
    displayData();
  }
}
//==============================================================================
volatile float OutVoltage;
volatile unsigned char status = 0;
void ControlOut()
{
  static unsigned int  main_count = 0,main_count1 = 0;
  static char rele_1_count = 0,rele_2_count = 0,rele_bypass_count = 0;

  static unsigned int c = 0,c1 = 0,c2 = 0,c3 = 0,c4 = 0,c5 = 0,c6 = 0,c7 = 0,c8 = 0,c9 = 0,c10 = 0,c11 = 0;

        if(flag_t.first_start==RESET)
        {
                ControlDigit(flag_t.input_voltage_status_first_step, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.status_first_step,
                &c,&c1);

                ControlDigit(flag_t.input_voltage_status_second_step, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.status_second_step,
                &c2,&c3);

                ControlDigit(flag_t.input_voltage_status_bypass, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.status_bypass,
                &c4,&c5);

                ControlDigit(flag_t.output_voltage_status_temp, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.output_voltage_status,
                &c6,&c7);

                ControlDigit(flag_t.short_current_status_temp, CURRENT_SHORT_DELAY_ON,CURRENT_SHORT_DELAY_OFF,MS_IN_CYCLE,&flag_t.short_current_status,
                &c8,&c9);

                ControlDigit(flag_t.current_status_temp, DIGITAL_DELAY_ON,DIGITAL_DELAY_OFF,MS_IN_CYCLE,&flag_t.current_status,
                &c10,&c11);


        }
        if(flag_t.first_start==SET)
        {
          ControlDigit(flag_t.input_voltage_status_first_step, SET_DELAY,RESET_DELAY,
          MS_IN_CYCLE,&flag_t.status_first_step,&c,&c1);

          ControlDigit(flag_t.input_voltage_status_second_step, SET_DELAY,RESET_DELAY,
          MS_IN_CYCLE,&flag_t.status_second_step,&c2,&c3);

          ControlDigit(flag_t.input_voltage_status_bypass, SET_DELAY,RESET_DELAY,
          MS_IN_CYCLE,&flag_t.status_bypass,&c4,&c5);

          ControlDigit(flag_t.output_voltage_status_temp, (TIME_KOEF),(DIGITAL_DELAY_OFF*TIME_KOEF),
          MS_IN_CYCLE,&flag_t.output_voltage_status,&c6,&c7);

          ControlDigit(flag_t.short_current_status_temp, CURRENT_SHORT_DELAY_ON,CURRENT_SHORT_DELAY_OFF,MS_IN_CYCLE,
          &flag_t.short_current_status,
          &c8,&c9);

          ControlDigit(flag_t.current_status_temp, (TIME_KOEF),(CURRENT_SHORT_DELAY_OFF*TIME_KOEF),
          MS_IN_CYCLE,&flag_t.current_status,
          &c10,&c11);

        }


        bitWrite(status, 0,flag_t.status_first_step);
        bitWrite(status, 1,flag_t.status_second_step);
        bitWrite(status, 2,flag_t.status_bypass);

        if(flag_t.start_button_status==RESET)
        {
                flag_t.first_start = RESET;
        }

        if(flag_t.first_start==RESET)
        {
                flag_t.current_global_status = SET;
        }

        if(flag_t.start_button_status==SET&&flag_t.current_status==SET&&flag_t.short_current_status==SET&&
                flag_t.current_global_status==SET)
        {



                if(flag_t.output_voltage_status==SET)
                {
                        if((main_count++)>=MAIN_RELE_DELAY)
                        {
                                main_count = 0;
                                main_count1 = 0;
                                RELE_OUT_MAIN = ON;
                        }

                }
                if(flag_t.output_voltage_status==RESET)
                {
                        if((main_count1++)>=(MAIN_RELE_DELAY/2))
                        {
                                main_count= 0;
                                main_count1 = 0;
                                RELE_OUT_MAIN = OFF;
                                OutVoltage = 0;
                        }

                }


                switch (status)
                {
                        case 0b00000111:

                                        if(flag_t.output_voltage_status==SET)
                                        {
                                        RELE_2 = OFF;
                                        RELE_BYPASS = OFF;
                                        if((rele_1_count++)>=DELAY_SWITCH)
                                        {
                                                rele_1_count = 0;
                                                RELE_1 = ON;
                                                OutVoltage = ((InVoltageValue/KOEF_TRANSF)*2)+InVoltageValue;
                                        }

                                        }

                                        break;
                        case 0b00000110:
                        case 0b00000100:
                                        RELE_1 = OFF;
                                        RELE_BYPASS = OFF;
                                        if(flag_t.output_voltage_status==SET)
                                        {
                                                if((rele_2_count++)>=DELAY_SWITCH)
                                                {
                                                        rele_2_count = 0;
                                                        RELE_2 = ON;
                                                        OutVoltage = ((InVoltageValue/KOEF_TRANSF)*1)+InVoltageValue;
                                                }
                                         }

                                        break;

                        case 0b00000000:
                                        RELE_1 = OFF;
                                        RELE_2 = OFF;
                                        if(flag_t.output_voltage_status==SET)
                                        {
                                                if((rele_bypass_count++)>=DELAY_SWITCH)
                                                {
                                                        rele_bypass_count = 0;
                                                        RELE_BYPASS = ON;
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
                RELE_1 = OFF;
                RELE_2 = OFF;
                RELE_BYPASS = OFF;
                RELE_OUT_MAIN = OFF;
                OutVoltage = 0;
        }

}

//==============================================================================================================
void StatusLed()
{
        static unsigned char count_st_led = 0,count_st_led1 = 0,count_st_led2 = 0;
        if(flag_t.first_start==SET)
        {
                  if(flag_t.start_button_status==SET&&flag_t.current_status==SET&&flag_t.short_current_status==SET&&flag_t.current_global_status==SET)
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
//==============================================================================================================
void ControlDigit(unsigned char in_value, unsigned int delay_set,
        unsigned int delay_reset, unsigned int ms_in_one_cycle, char *status,
        unsigned int *count_ci, unsigned int* count_ci1)
{
        if (in_value == SET)
        {

                if ((++*count_ci) == ((unsigned int)delay_set*(1000 / ms_in_one_cycle)))
                {
                        *count_ci = 0;
                        *count_ci1 = 0;
                        if (in_value == SET)
                        {
                                *status = 1;
                        }
                }

        }
        //------------------------------------------------------------------------------
        if (in_value == RESET)
        {

                if ((++*count_ci1) == ((unsigned int)delay_reset*(1000 / ms_in_one_cycle)))
                {
                        *count_ci = 0;
                        *count_ci1 = 0;
                        if (in_value == RESET)
                        {
                                *status = 0;
                        }
                }

        }
}
//==============================================================================================================