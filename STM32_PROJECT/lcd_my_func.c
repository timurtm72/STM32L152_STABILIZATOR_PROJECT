#include "hider.h"
#include "Glass_LCD.c"

//==============================================================================
unsigned int strDisp[6];
void Out_data_to_LCD(char str_start,char str_end,float process_value)
{
  float p1=0,p2=0;
  unsigned int convert_char = 0,temp = 0,temp1 = 0;
                
                p1 = modf(process_value, &p2);// p1 = 0.25, p2 = 6.00
                convert_char = (unsigned int)p2;

                strDisp[0] = str_start;
                LCD_GLASS_WriteChar(&strDisp[0],false,false,1);
                //--------------------------------------------------------------
                strDisp[1]= ' ';
                LCD_GLASS_WriteChar(&strDisp[1],false,false,2);
                //--------------------------------------------------------------
                temp =  (convert_char/100);
                strDisp[2]= temp +48;
                if(strDisp[2]=='0')
                  {
                     strDisp[2]=' ';
                  }
                LCD_GLASS_WriteChar(&strDisp[2],false,false,3);
                //--------------------------------------------------------------
                temp1 = (convert_char-(temp*100));
                strDisp[3]= ((temp1/10) + 48);
                if((strDisp[2]=='0')&&(strDisp[3]=='0'))
                  {
                     strDisp[3]=' ';
                  }
                LCD_GLASS_WriteChar(&strDisp[3],false,false,4);
                //--------------------------------------------------------------
                strDisp[4]= ((temp1 - ((temp1/10)*10))+48);
                LCD_GLASS_WriteChar(&strDisp[4],false,false,5);

               strDisp[5]= str_end;
               LCD_GLASS_WriteChar(&strDisp[5],false,false,6);
}
//==============================================================================
void Init_LCD()
{
    LCD_GLASS_Init();
}
//==============================================================================
void Write_data_to_LCD(char str_start,char str_end,float value)
{
  Out_data_to_LCD(str_start,str_end,value);
}
//==============================================================================
void clear_LCD()
{
   LCD_GLASS_Clear();
   BAR0_OFF;
   BAR1_OFF;
   BAR2_OFF;
   BAR3_OFF;
   LCD_bar();
}
//==============================================================================
void Write_to_LCD_text(char *ptr)
{
   LCD_GLASS_DisplayString(ptr);
}
//==============================================================================
void Scroll_LCD(unsigned char *ptr,unsigned int nScroll,unsigned int ScrollSpeed)
{
  LCD_GLASS_ScrollSentence(ptr,nScroll, ScrollSpeed);
}
//==============================================================================
void LCD_bar_status()
{
    if(RELE_1)BAR0_ON;
    if(!RELE_1)BAR0_OFF;

    if(RELE_2)BAR1_ON;
    if(!RELE_2)BAR1_OFF;

    if(RELE_BYPASS)BAR2_ON;
    if(!RELE_BYPASS)BAR2_OFF;

    if(RELE_OUT_MAIN)BAR3_ON;
    if(!RELE_OUT_MAIN)BAR3_OFF;
    LCD_bar();
}
//==============================================================================