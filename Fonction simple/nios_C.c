/*
 *Written by: Hichen Salah
 */
#include <system.h>
#include <alt_types.h>
#include <altera_avalon_pio_regs.h>
#include <stdio.h>

unsigned char flag,switches,compass,continu,start_stop,sortie,data_valid;
int degre;
int main()
{
  printf("ZIDANE !!!!!\n");

  while(1)
  {
	  switches = IORD_ALTERA_AVALON_PIO_DATA(SWITCH_BASE);
	  //compass = IORD_ALTERA_AVALON_PIO_DATA(S_COMPASS_BASE);

	  continu = switches & 0x1;
	  start_stop = switches & 0x2;

	  if(start_stop==0x2)
		  start_stop=1;

if(continu&&01==1)
	{
	IOWR_ALTERA_AVALON_PIO_DATA(SS_BASE,1);
	degre = IORD_ALTERA_AVALON_PIO_DATA(DEGRE_BASE);
	printf("data compass = %d\n",degre);
	IOWR_ALTERA_AVALON_PIO_DATA(SS_BASE,0);
	IOWR_ALTERA_AVALON_PIO_DATA(LEDS_DEGRE_BASE,1);
	usleep(1000000);

	}
else if(start_stop==1 && flag==1)
{	
	flag=0;
	//usleep(20000);
	IOWR_ALTERA_AVALON_PIO_DATA(SS_BASE,1);
	degre = IORD_ALTERA_AVALON_PIO_DATA(DEGRE_BASE);
	printf("data compass = %d\n",degre);
	IOWR_ALTERA_AVALON_PIO_DATA(SS_BASE,0);
	IOWR_ALTERA_AVALON_PIO_DATA(LEDS_DEGRE_BASE,!flag);

}
else if(start_stop==0)
{ flag=1;
  IOWR_ALTERA_AVALON_PIO_DATA(LEDS_DEGRE_BASE,!flag);

}
data_valid = IORD_ALTERA_AVALON_PIO_DATA(DATA_VALID_IN_BASE);

  }

  return 0;
}

