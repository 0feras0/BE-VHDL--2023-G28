
#include <stdio.h>
#include <system.h>
#include <alt_types.h>
#include <altera_avalon_pio_regs.h>
#include <altera_avalon_timer_regs.h>
#include <sys/alt_irq.h>

int degre, data_adc, tension, flag=0;

unsigned char switches,compass,continu,start_stop,sortie,data_valid;

static void timer_irq(void* context)
{  		flag++;
		if (flag==10){
			//compas
            flag=0;
			if((IORD_ALTERA_AVALON_PIO_DATA(CONTINUE_BASE)==1) {
			IOWR_ALTERA_AVALON_PIO_DATA(CMD_COMPAS_BASE,1);
			degre = IORD_ALTERA_AVALON_PIO_DATA(DEGRE_IN_BASE);
			printf("data compass = %d\n",degre);
			IOWR_ALTERA_AVALON_PIO_DATA(CMD_COMPAS_BASE,0);
            IOWR_ALTERA_AVALON_PIO_DATA(DATA_VALID_BASE,0)
		       
		}
		//ADC
		IOWR_ALTERA_AVALON_PIO_DATA(CMD_ADC_BASE,0);
		usleep(2);
		IOWR_ALTERA_AVALON_PIO_DATA(CMD_ADC_BASE,1);
		while(IORD_ALTERA_AVALON_PIO_DATA(ACKNOWLEDGE_BASE) == 0);
		data_adc = IORD_ALTERA_AVALON_PIO_DATA(POSITION_IN_BASE);
		tension = data_adc*5000/4095;
	        printf("La tension lu: %d (en mV) \n",tension);
		

		IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_ADC_BASE,0);
}
int main()
{
  printf("Hello from Nios II!\n");

  alt_irq_cpu_enable_interrupts();
  IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_ADC_BASE,0x0003);
  IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_ADC_BASE,0);
  alt_ic_isr_register(TIMER_ADC_IRQ_INTERRUPT_CONTROLLER_ID,
		  	  	  	  TIMER_ADC_IRQ,
					  timer_irq,
					  0,
  	  	  	  	  	  0);
  IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_ADC_BASE,0x0007);

while(1){
	if((IORD_ALTERA_AVALON_PIO_DATA(SS_BASE)==1 && ((IORD_ALTERA_AVALON_PIO_DATA(CONTINUE_BASE)==0) 
	{
	IOWR_ALTERA_AVALON_PIO_DATA(DATA_VALID_BASE,0)
	IOWR_ALTERA_AVALON_PIO_DATA(CMD_ADC_BASE,0);
	usleep(2);
	IOWR_ALTERA_AVALON_PIO_DATA(CMD_ADC_BASE,1);
	while(IORD_ALTERA_AVALON_PIO_DATA(ACKNOWLEDGE_BASE) == 0);
	data_adc = IORD_ALTERA_AVALON_PIO_DATA(POSITION_IN_BASE);
	tension = data_adc*5000/4095;
	printf("La tension lu: %d (en mV) \n",data_adc);
	IOWR_ALTERA_AVALON_PIO_DATA(DATA_VALID_BASE,1)
	}
		    

}


  return 0;
}
