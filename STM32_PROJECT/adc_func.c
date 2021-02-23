#include "hider.h"

//==============================================================================
void Init_ADC_chanell()
{
  ADC_CCRbits.ADCPRE = 0x02;              //предделитель АЦП
  ADC1_Init();
  ADC_Set_Input_Channel(_ADC_CHANNEL_4|_ADC_CHANNEL_5);
 /*ADC_SMPR3bits.SMP0 = 0x07;              //время преобразования
  ADC_CR1bits.RES = 0x01;                 //разрядность преобразования
  ADC_CR2bits.ALIGN = 0;                  //выравнивание вправо
  ADC_CR2bits.DELS = 0x07;                //задержка между преобразованиями*/

}
//==============================================================================
struct flag flag_t;
//==============================================================================================================
volatile float InVoltageValue = 0,OutVoltageValue = 0,CurrentValue = 0;
//==============================================================================================================
void ReadAnalogInput()
{
 static unsigned char rai_count = 0;
  if((rai_count++)>=50)
  {
    rai_count=0;
    InVoltageValue  = Read_ADC_chanell(IN_VOLTAGE,10,VOLTAGE_KOEF);
    CurrentValue    = Read_ADC_chanell(IN_CURRENT,10,CURRENT_KOEF);
  }
   //IN_CURRENT
}

//==============================================================================================================
float Read_ADC_chanell(char chanell,unsigned char samples,float koef)
{
  float  temp = 0,temp1 = 0;
  unsigned char i = 0;
        for(i=0;i<samples;i++)
        {
                temp = (ADC1_Get_Sample(chanell)>>2);
                temp1+=temp;
                Delay_us(150);
        }

        return ((float)((temp1/samples)/koef));
        //200 volt 1270
        //5 volt 20 amper 0.450 mv adc 92
        //250v input 1585 mv adc 324
}
//==============================================================================================================
void ControlAnalogFlags()
{
  static unsigned int input_voltage_status_first_step_count = 0,input_voltage_status_first_step_count1 = 0;
  static unsigned int input_voltage_status_second_step_count = 0,input_voltage_status_second_step_count1 = 0;
  static unsigned int current_status_count = 0,current_status_count1 = 0;
  static unsigned int input_voltage_status_bypass_count = 0,input_voltage_status_bypass_count1 = 0;
  static unsigned int output_voltage_status_count = 0,output_voltage_status_count1 = 0;
  static unsigned int short_current_status_count = 0,short_current_status_count1 = 0;

        if((flag_t.short_current_status==RESET||flag_t.current_status==RESET)&&flag_t.first_start==SET)
        {
                flag_t.current_global_status = RESET;
        }


           one_level_comparator(VALUE_FIRST_STEP,InVoltageValue,VOLTAGE_GISTERESIS,ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,
                        &flag_t.input_voltage_status_first_step,&input_voltage_status_first_step_count,
                        &input_voltage_status_first_step_count1);

           one_level_comparator(VALUE_SECOND_STEP,InVoltageValue,VOLTAGE_GISTERESIS,ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,
                        &flag_t.input_voltage_status_second_step,&input_voltage_status_second_step_count,
                        &input_voltage_status_second_step_count1);

           one_level_comparator(VALUE_CURRENT,CurrentValue,CURRENT_GISTERESIS,ANALOG_DELAY_ON,
                        ANALOG_DELAY_OFF,MS_IN_CYCLE,&flag_t.current_status_temp,&current_status_count,
                        &current_status_count1);

           one_level_comparator(VALUE_CURRENT_SHORT,CurrentValue,CURRENT_GISTERESIS,CURRENT_SHORT_DELAY_ON,CURRENT_SHORT_DELAY_OFF,MS_IN_CYCLE,
                        &flag_t.short_current_status_temp,&short_current_status_count,
                        &short_current_status_count1);

           one_level_comparator(VALUE_BYPASS,InVoltageValue,VOLTAGE_GISTERESIS,ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,
                        &flag_t.input_voltage_status_bypass,&input_voltage_status_bypass_count,
                        &input_voltage_status_bypass_count1);

           /*two_level_comparator(VALUE_VOLT_HI,VALUE_VOLT_LO,InVoltageValue,
                        VOLTAGE_GISTERESIS, ANALOG_DELAY_ON,ANALOG_DELAY_OFF,
                        MS_IN_CYCLE,&flag_t.output_voltage_status_temp,&output_voltage_status_count,&output_voltage_status_count1);*/
           
           one_level_comparator(VALUE_VOLT_HI,OutVoltageValue,VOLTAGE_GISTERESIS,ANALOG_DELAY_ON,ANALOG_DELAY_OFF,MS_IN_CYCLE,
                        &flag_t.output_voltage_status_temp,&output_voltage_status_count,
                        &output_voltage_status_count1);
}
//===============================================================================================================
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

        //------------------------------------------------------------------------------

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
//==============================================================================================================
void two_level_comparator(float high_reference,float low_reference,float value,
 float gisteresis, unsigned int delay_on_sec_tlc,unsigned int delay_off_sec_tlc,
 unsigned char ms_in_one_cycle_tlc,char* status_tlc,unsigned int* count_tlc,
 unsigned int* count_tlc1)
{
   if( (value>=(high_reference+gisteresis))||(value<=(low_reference-gisteresis)))
     {

       if(++(*count_tlc)>=((unsigned int)delay_off_sec_tlc*(1000/ms_in_one_cycle_tlc)))
           {
             *count_tlc  = 0;
             *count_tlc1 = 0;
              if((value>=(high_reference+gisteresis))||(value<=(low_reference-gisteresis)))
                {
                   *status_tlc = 0;
                }

          }

    }
//------------------------------------------------------------------------------
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
//==============================================================================================================