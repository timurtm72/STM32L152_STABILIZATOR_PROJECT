#include "hider.h"

//==============================RELE OUT========================================
sbit RELE_1                      at      GPIOA_ODR.B11;
sbit RELE_2                      at      GPIOA_ODR.B12;
sbit RELE_BYPASS                 at      GPIOB_ODR.B6;
sbit RELE_OUT_MAIN               at      GPIOC_ODR.B12;
//==============================LED OUTPUT======================================
sbit LED_BLUE                    at      GPIOB_ODR.B6;
sbit LED_GREEN                   at      GPIOB_ODR.B7;
//===============================DIGITAL INPUT==================================
sbit START_BUTTON                at      GPIOD_IDR.B2;
sbit CHANGE_BUTTON               at      GPIOA_IDR.B0;
//==============================================================================
void Init_pin()
{
//#define IN_VOLTAGE                      4     //PA4
//#define IN_CURRENT                      5     //PA5
//==============================RELE OUT========================================
GPIO_Config(&GPIOA_BASE, _GPIO_PINMASK_11 | _GPIO_PINMASK_12,_GPIO_CFG_DIGITAL_OUTPUT);
GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_6,_GPIO_CFG_DIGITAL_OUTPUT);
GPIO_Config(&GPIOC_BASE, _GPIO_PINMASK_12,_GPIO_CFG_DIGITAL_OUTPUT);
GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_6,_GPIO_CFG_DIGITAL_OUTPUT);
//==============================LED OUTPUT======================================
GPIO_Config(&GPIOB_BASE, _GPIO_PINMASK_7,_GPIO_CFG_DIGITAL_OUTPUT);
//===========================DIGITAL INPUT======================================
GPIO_Config(&GPIOD_BASE, _GPIO_PINMASK_2,_GPIO_CFG_DIGITAL_INPUT);
GPIO_Config(&GPIOA_BASE, _GPIO_PINMASK_0,_GPIO_CFG_DIGITAL_INPUT);
}
//==============================================================================
void Init_flags()
{
  flag_t.ovf_flag                                       = 0;
  flag_t.start_button_status                            = 0;
  flag_t.input_voltage_status_first_step                = 0;
  flag_t.input_voltage_status_second_step               = 0;
  flag_t.status_main_contactor                          = 0;
  flag_t.input_voltage_status_bypass                    = 0;
  flag_t.input_voltage_status_hight                     = 0;
  flag_t.input_voltage_status_lo                        = 0;
  flag_t.output_voltage_status                          = 0;
  flag_t.current_status                                 = 0;
  flag_t.short_current_status                           = 0;
  flag_t.first_start                                    = 0;
  flag_t.current_global_status                          = 0;
  flag_t.status_bypass                                  = 0;
  flag_t.status_first_step                              = 0;
  flag_t.status_second_step                             = 0;
  flag_t.output_voltage_status_temp                     = 0;
  flag_t.current_status_temp                            = 0;
  flag_t.short_current_status_temp                      = 0;
  flag_t.change_button_status                           = 0;
}
//==============================================================================