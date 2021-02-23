/*                Definitons for GPIOs                */


//Miscellaneous

#define enable                                                                           0x1
#define disable                                                                          0x0

#define true                                                                             0x1
#define false                                                                            0x0

#define high                                                                             0x1
#define low                                                                              0x0

//Bitwise Operations

#define bit_set(reg, bit_val)                                                            reg |= (1 << bit_val)
#define bit_clr(reg, bit_val)                                                            reg &= (~(1 << bit_val))
#define get_bits(reg, msk)                                                               (reg & msk)
#define get_input(reg, bit_val)                                                          (reg & (1 << bit_val))

//Mode Definitions

#define GPIO_input                                                                       0x0
#define GPIO_output                                                                      0x1
#define AFIO                                                                             0x2
#define analog_input                                                                     0x3

#define set_GPIO_port_mode(pin, mode, reg)                                               do{reg &= (~(0x3 << (pin << 1))); reg |= (mode << (pin << 1));}while(0)

#define set_GPIOA_mode(pin, mode)                                                        set_GPIO_port_mode(pin, mode, GPIOA_MODER)
#define set_GPIOB_mode(pin, mode)                                                        set_GPIO_port_mode(pin, mode, GPIOB_MODER)
#define set_GPIOC_mode(pin, mode)                                                        set_GPIO_port_mode(pin, mode, GPIOC_MODER)
#define set_GPIOD_mode(pin, mode)                                                        set_GPIO_port_mode(pin, mode, GPIOD_MODER)
#define set_GPIOE_mode(pin, mode)                                                        set_GPIO_port_mode(pin, mode, GPIOE_MODER)
#define set_GPIOF_mode(pin, mode)                                                        set_GPIO_port_mode(pin, mode, GPIOF_MODER)
#define set_GPIOG_mode(pin, mode)                                                        set_GPIO_port_mode(pin, mode, GPIOG_MODER)
#define set_GPIOH_mode(pin, mode)                                                        set_GPIO_port_mode(pin, mode, GPIOH_MODER)


//Output Type Definitions

#define output_PP                                                                        0x0
#define output_open_drain                                                                0x1

#define set_GPIO_port_output_type(pin, type, reg)                                        do{reg &= (~(0x1 << pin)); reg |= (type << pin);}while(0)

#define set_GPIOA_output_type(pin, type)                                                 set_GPIO_port_output_type(pin, type, GPIOA_OTYPER)
#define set_GPIOB_output_type(pin, type)                                                 set_GPIO_port_output_type(pin, type, GPIOB_OTYPER)
#define set_GPIOC_output_type(pin, type)                                                 set_GPIO_port_output_type(pin, type, GPIOC_OTYPER)
#define set_GPIOD_output_type(pin, type)                                                 set_GPIO_port_output_type(pin, type, GPIOD_OTYPER)
#define set_GPIOE_output_type(pin, type)                                                 set_GPIO_port_output_type(pin, type, GPIOE_OTYPER)
#define set_GPIOF_output_type(pin, type)                                                 set_GPIO_port_output_type(pin, type, GPIOF_OTYPER)
#define set_GPIOG_output_type(pin, type)                                                 set_GPIO_port_output_type(pin, type, GPIOG_OTYPER)
#define set_GPIOH_output_type(pin, type)                                                 set_GPIO_port_output_type(pin, type, GPIOH_OTYPER)


//GPIO Speed Definitions

#define very_low_speed                                                                   0x0
#define low_speed                                                                        0x1
#define medium_speed                                                                     0x2
#define high_speed                                                                       0x3

#define set_GPIO_port_speed(pin, spd, reg)                                               do{reg &= (~(0x3 << (pin << 1))); reg |= (spd << (pin << 1));}while(0)

#define set_GPIOA_speed(pin, spd)                                                        set_GPIO_port_speed(pin, spd, GPIOA_OSPEEDER)
#define set_GPIOB_speed(pin, spd)                                                        set_GPIO_port_speed(pin, spd, GPIOB_OSPEEDER)
#define set_GPIOC_speed(pin, spd)                                                        set_GPIO_port_speed(pin, spd, GPIOC_OSPEEDER)
#define set_GPIOD_speed(pin, spd)                                                        set_GPIO_port_speed(pin, spd, GPIOD_OSPEEDER)
#define set_GPIOE_speed(pin, spd)                                                        set_GPIO_port_speed(pin, spd, GPIOE_OSPEEDER)
#define set_GPIOF_speed(pin, spd)                                                        set_GPIO_port_speed(pin, spd, GPIOF_OSPEEDER)
#define set_GPIOG_speed(pin, spd)                                                        set_GPIO_port_speed(pin, spd, GPIOG_OSPEEDER)
#define set_GPIOH_speed(pin, spd)                                                        set_GPIO_port_speed(pin, spd, GPIOH_OSPEEDER)


//Pull-up - Pull-down Definitions

#define no_pull_resistor                                                                 0x0
#define pull_up                                                                          0x1
#define pull_down                                                                        0x2
#define reserved                                                                         0x03

#define set_GPIO_pull_resistor(pin, pppd, reg)                                           do{reg &= (~(0x3 << (pin << 1))); reg |= (pppd << (pin << 1));}while(0)

#define set_GPIOA_pull_resistor(pin, pppd)                                               set_GPIO_pull_resistor(pin, pppd, GPIOA_PUPDR)
#define set_GPIOB_pull_resistor(pin, pppd)                                               set_GPIO_pull_resistor(pin, pppd, GPIOB_PUPDR)
#define set_GPIOC_pull_resistor(pin, pppd)                                               set_GPIO_pull_resistor(pin, pppd, GPIOC_PUPDR)
#define set_GPIOD_pull_resistor(pin, pppd)                                               set_GPIO_pull_resistor(pin, pppd, GPIOD_PUPDR)
#define set_GPIOE_pull_resistor(pin, pppd)                                               set_GPIO_pull_resistor(pin, pppd, GPIOE_PUPDR)
#define set_GPIOF_pull_resistor(pin, pppd)                                               set_GPIO_pull_resistor(pin, pppd, GPIOF_PUPDR)
#define set_GPIOG_pull_resistor(pin, pppd)                                               set_GPIO_pull_resistor(pin, pppd, GPIOG_PUPDR)
#define set_GPIOH_pull_resistor(pin, pppd)                                               set_GPIO_pull_resistor(pin, pppd, GPIOH_PUPDR)


//GPIO Alternate Function Definitions

#define AF0_system                                                                       0x0
#define AF1_TIM2                                                                         0x1
#define AF2_TIM3_5                                                                       0x2
#define AF3_TIM9_11                                                                      0x3
#define AF4_I2C1_I2C2                                                                    0x4
#define AF5_SPI1_SPI2                                                                    0x5
#define AF6_SPI3                                                                         0x6
#define AF7_USART1_3                                                                     0x7
#define AF8_UART4_5                                                                      0x8
#define AF9                                                                              0x9
#define AF10_USB                                                                         0xA
#define AF11_LCD                                                                         0xB
#define AF12_5FSMC                                                                       0xC
#define AF13                                                                             0xD
#define AF14_RI                                                                          0xE
#define AF15_eventout                                                                    0xF

#define set_GPIO_AFL(pin, func, reg)                                                     do{reg &= (~(0xF << (pin << 2))); reg |= (func << (pin << 2));}while(0)
#define set_GPIO_AFH(pin, func, reg)                                                     do{reg &= (~(0xF << ((pin - 8) << 2))); reg |= (func << ((pin - 8) << 2));}while(0)

#define setup_GPIOA_AF(pin, func)                                                        do{if((pin >= 0) && (pin < 8)) {set_GPIO_AFL(pin, func, GPIOA_AFRL);} else {set_GPIO_AFH(pin, func, GPIOA_AFRH);}}while(0)
#define setup_GPIOB_AF(pin, func)                                                        do{if((pin >= 0) && (pin < 8)) {set_GPIO_AFL(pin, func, GPIOB_AFRL);} else {set_GPIO_AFH(pin, func, GPIOB_AFRH);}}while(0)
#define setup_GPIOC_AF(pin, func)                                                        do{if((pin >= 0) && (pin < 8)) {set_GPIO_AFL(pin, func, GPIOC_AFRL);} else {set_GPIO_AFH(pin, func, GPIOC_AFRH);}}while(0)
#define setup_GPIOD_AF(pin, func)                                                        do{if((pin >= 0) && (pin < 8)) {set_GPIO_AFL(pin, func, GPIOD_AFRL);} else {set_GPIO_AFH(pin, func, GPIOD_AFRH);}}while(0)
#define setup_GPIOE_AF(pin, func)                                                        do{if((pin >= 0) && (pin < 8)) {set_GPIO_AFL(pin, func, GPIOE_AFRL);} else {set_GPIO_AFH(pin, func, GPIOE_AFRH);}}while(0)
#define setup_GPIOF_AF(pin, func)                                                        do{if((pin >= 0) && (pin < 8)) {set_GPIO_AFL(pin, func, GPIOF_AFRL);} else {set_GPIO_AFH(pin, func, GPIOF_AFRH);}}while(0)
#define setup_GPIOG_AF(pin, func)                                                        do{if((pin >= 0) && (pin < 8)) {set_GPIO_AFL(pin, func, GPIOG_AFRL);} else {set_GPIO_AFH(pin, func, GPIOG_AFRH);}}while(0)
#define setup_GPIOH_AF(pin, func)                                                        do{if((pin >= 0) && (pin < 8)) {set_GPIO_AFL(pin, func, GPIOH_AFRL);} else {set_GPIO_AFH(pin, func, GPIOH_AFRH);}}while(0)


//GPIO Power Control

#define enable_GPIOA(state)                                                              RCC_AHBENRbits.GPIOPAEN = state
#define enable_GPIOB(state)                                                              RCC_AHBENRbits.GPIOPBEN = state
#define enable_GPIOC(state)                                                              RCC_AHBENRbits.GPIOPCEN = state
#define enable_GPIOD(state)                                                              RCC_AHBENRbits.GPIOPDEN = state
#define enable_GPIOE(state)                                                              RCC_AHBENRbits.GPIOPEEN = state
#define enable_GPIOF(state)                                                              RCC_AHBENRbits.GPIOPFEN = state
#define enable_GPIOG(state)                                                              RCC_AHBENRbits.GPIOPGEN = state
#define enable_GPIOH(state)                                                              RCC_AHBENRbits.GPIOPHEN = state


//Configure GPIO Port Pins

#define setup_GPIOA(pin, mode, type, spd, pppd)                                          do{set_GPIOA_mode(pin, mode); set_GPIOA_output_type(pin, type); set_GPIOA_speed(pin, spd); set_GPIOA_pull_resistor(pin, pppd);}while(0)
#define setup_GPIOB(pin, mode, type, spd, pppd)                                          do{set_GPIOB_mode(pin, mode); set_GPIOB_output_type(pin, type); set_GPIOB_speed(pin, spd); set_GPIOB_pull_resistor(pin, pppd);}while(0)
#define setup_GPIOC(pin, mode, type, spd, pppd)                                          do{set_GPIOC_mode(pin, mode); set_GPIOC_output_type(pin, type); set_GPIOC_speed(pin, spd); set_GPIOC_pull_resistor(pin, pppd);}while(0)
#define setup_GPIOD(pin, mode, type, spd, pppd)                                          do{set_GPIOD_mode(pin, mode); set_GPIOD_output_type(pin, type); set_GPIOD_speed(pin, spd); set_GPIOD_pull_resistor(pin, pppd);}while(0)
#define setup_GPIOE(pin, mode, type, spd, pppd)                                          do{set_GPIOE_mode(pin, mode); set_GPIOE_output_type(pin, type); set_GPIOE_speed(pin, spd); set_GPIOE_pull_resistor(pin, pppd);}while(0)
#define setup_GPIOF(pin, mode, type, spd, pppd)                                          do{set_GPIOF_mode(pin, mode); set_GPIOF_output_type(pin, type); set_GPIOF_speed(pin, spd); set_GPIOF_pull_resistor(pin, pppd);}while(0)
#define setup_GPIOG(pin, mode, type, spd, pppd)                                          do{set_GPIOG_mode(pin, mode); set_GPIOG_output_type(pin, type); set_GPIOG_speed(pin, spd); set_GPIOG_pull_resistor(pin, pppd);}while(0)
#define setup_GPIOH(pin, mode, type, spd, pppd)                                          do{set_GPIOH_mode(pin, mode); set_GPIOH_output_type(pin, type); set_GPIOH_speed(pin, spd); set_GPIOH_pull_resistor(pin, pppd);}while(0)


//Output Functions

#define set_GPIO_high(reg, pin_no)                                                       bit_set(reg, pin_no)
#define set_GPIO_low(reg, pin_no)                                                        bit_set(reg, (pin_no + 16))

#define set_GPIOA_high(pin)                                                              set_GPIO_high(GPIOA_BSRR, pin)
#define set_GPIOB_high(pin)                                                              set_GPIO_high(GPIOB_BSRR, pin)
#define set_GPIOC_high(pin)                                                              set_GPIO_high(GPIOC_BSRR, pin)
#define set_GPIOD_high(pin)                                                              set_GPIO_high(GPIOD_BSRR, pin)
#define set_GPIOE_high(pin)                                                              set_GPIO_high(GPIOE_BSRR, pin)
#define set_GPIOF_high(pin)                                                              set_GPIO_high(GPIOF_BSRR, pin)
#define set_GPIOG_high(pin)                                                              set_GPIO_high(GPIOG_BSRR, pin)
#define set_GPIOH_high(pin)                                                              set_GPIO_high(GPIOH_BSRR, pin)

#define set_GPIOA_low(pin)                                                               set_GPIO_low(GPIOA_BSRR, pin)
#define set_GPIOB_low(pin)                                                               set_GPIO_low(GPIOB_BSRR, pin)
#define set_GPIOC_low(pin)                                                               set_GPIO_low(GPIOC_BSRR, pin)
#define set_GPIOD_low(pin)                                                               set_GPIO_low(GPIOD_BSRR, pin)
#define set_GPIOE_low(pin)                                                               set_GPIO_low(GPIOE_BSRR, pin)
#define set_GPIOF_low(pin)                                                               set_GPIO_low(GPIOF_BSRR, pin)
#define set_GPIOG_low(pin)                                                               set_GPIO_low(GPIOG_BSRR, pin)
#define set_GPIOH_low(pin)                                                               set_GPIO_low(GPIOH_BSRR, pin)


//Input Functions

#define read_GPIOA(pin)                                                                  get_input(GPIOA_IDR, pin)
#define read_GPIOB(pin)                                                                  get_input(GPIOB_IDR, pin)
#define read_GPIOC(pin)                                                                  get_input(GPIOC_IDR, pin)
#define read_GPIOD(pin)                                                                  get_input(GPIOD_IDR, pin)
#define read_GPIOE(pin)                                                                  get_input(GPIOE_IDR, pin)
#define read_GPIOF(pin)                                                                  get_input(GPIOF_IDR, pin)
#define read_GPIOG(pin)                                                                  get_input(GPIOG_IDR, pin)
#define read_GPIOH(pin)                                                                  get_input(GPIOH_IDR, pin)