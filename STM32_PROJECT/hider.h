#define         SET                     1
#define         RESET                   0
#define         FALSE                   0
#define         TRUE                    1
#define         ON                      1
#define         OFF                     0
#define         MS_IN_CYCLE             10
#define bit_set(reg, bit_val)           reg |= (1 << bit_val)
#define bit_clr(reg, bit_val)           reg &= (~(1 << bit_val))
#define get_bits(reg, msk)              (reg & msk)
#define get_input(reg, bit_val)         (reg & (1 << bit_val))
#define bitRead(value, bit) (((value) >> (bit)) & 0x01)
#define bitSet(value, bit) ((value) |= (1UL << (bit)))
#define bitClear(value, bit) ((value) &= ~(1UL << (bit)))
#define bitWrite(value, bit, bitvalue) (bitvalue ? bitSet(value, bit) : bitClear(value, bit))

//#define bitWrite(value, bit, bitvalue)  (bitvalue ? bit_set(value, bit) : bit_clr(value, bit))

#define MS_IN_CYCLE                     10
#define DIGITAL_DELAY_ON                2.0
#define DIGITAL_DELAY_OFF               2.0
#define VOLTAGE_GISTERESIS              5.0
#define CURRENT_GISTERESIS              5.0
#define ANALOG_DELAY_ON                 2.0
#define ANALOG_DELAY_OFF                2.0
#define CURRENT_SHORT_DELAY_ON          3.0
#define CURRENT_SHORT_DELAY_OFF         3.0
#define VOLTAGE_KOEF                    2.0 //1.27 // 0.91
#define CURRENT_KOEF                    7.0  //3.5

#define VALUE_FIRST_STEP                170.0
#define VALUE_SECOND_STEP               210.0
#define VALUE_BYPASS                    230.0

#define VALUE_CURRENT                   100.0
#define VALUE_CURRENT_SHORT             120.0

#define KOEF_TRANSF                     5.5
#define VALUE_VOLT_HI                   270.0
#define VALUE_VOLT_LO                   110.0
#define DELAY_FIRST_START               20.0
#define START_DELAY                     15.0
#define DELAY_AFTER_CURRENT             50.0
#define DELAY_SWITCH                    7
#define MAIN_RELE_DELAY                 1400
#define IN_VOLTAGE                      4     //PA4
#define IN_CURRENT                      5     //PA5
#define TIME_KOEF                       20
#define RESET_DELAY                     30
#define SET_DELAY                       10

//==============================RELE OUT========================================
extern sfr sbit  RELE_1;
extern sfr sbit  RELE_2;
extern sfr sbit  RELE_BYPASS;
extern sfr sbit  RELE_OUT_MAIN;
//==============================LED OUTPUT======================================
extern sfr sbit  LED_BLUE;
extern sfr sbit  LED_GREEN;
//===============================DIGITAL INPUT==================================
extern sfr sbit  START_BUTTON;
extern sfr sbit CHANGE_BUTTON;
//===============================STRUCT=========================================
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
//------------------------------------------------------------------------------
};
extern struct flag flag_t;
//------------------------------------------------------------------------------
struct process_values {
 float mesurment_pressure ;

};

extern volatile float InVoltageValue,OutVoltageValue,CurrentValue;
//==============================FUNCTIONS=======================================
void  Init_flags();
void  Init_pin();
void  StartMainTimer_10ms();
void  Init_ADC_chanell();
void  ReadAnalogInput();
float Read_ADC_chanell(char chanell,unsigned char samples,float koef);
void  ControlAnalogFlags();
void  one_level_comparator(float reference,float value, float gisteresis,
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