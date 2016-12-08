//==============================================================
//Altera Corporation 9/10/2015
//==============================================================
//Hello_World Example on Cyclone V E Dev Kit
//It demonstrates the following function:
//Printing "Hello World from NiosII!" in the console
//Displaying "Hello World from NiosII!" in the LCD
//Detecting PushButton[3:2] to control LED[3:2]
//==============================================================

#include <sys/alt_stdio.h>
#include <priv/alt_busy_sleep.h>
#include "altera_avalon_pio_regs.h"
#include "system.h"

#define LCD_BITBANG_BASE 0x00021000
#define NUMBERS 0x00021010

void SendCommand(alt_u8 cmd);  //Send command to LCD
void SendData(alt_u8 data);    //Send one character to LCD
void SendMessage(char *msg);   //Send a string to LCD

int main()
{
	while(1) {
		//Print "Hello World" in the console
		alt_putstr("Hello World from NiosII!\n");
		alt_u16 in = IORD_ALTERA_AVALON_PIO_DATA(NUMBERS);

		// From .sv code:
		// assign numbers	=  {complete, load, 10'h0, digit[3:0]};

		alt_u16 digit_mask = 0xf; // Get the digits from our computed output
		alt_u16 complete_mask = 0x8000; // Check if our calculation is complete
		alt_u16 load_mask = 0x4000; // Check if the load signal has been raised by the camera system

		alt_u16 result;

		while ((in & load_mask) == 0x4000) {
			result = 50; // ASCII for '0' is 48
			alt_printf ("it is true! %c\n", result);
			in = IORD_ALTERA_AVALON_PIO_DATA(NUMBERS);
		}

		//Initialize LCD
		SendCommand(0x0038);  //Function Set: 8 bit, 2 lines, 5*8 dots
		SendCommand(0x000C);  //Display on, cursor off
		//SendCommand(0x000F);  //Display on, cursor on, cursor blinking
		SendCommand(0x0001);  //Display Clear
		SendCommand(0x0006);  //Entry Mode: right-moving cursor (address increment), no display shift

		//Write first line message to LCD
		SendMessage("You wrote");

		//Change DDRAM locations to 40H to map to the second line
		SendCommand(0x00C0);  //Set DDRAM address to 40H

		//Write second line message to LCD
		switch (result) {
			case 0: SendMessage("number 0"); break;
			case 1: SendMessage("number 1"); break;
			case 2: SendMessage("number 2"); break;
			case 3: SendMessage("number 3"); break;
			case 4: SendMessage("number 4"); break;
			case 5: SendMessage("number 5"); break;
			case 6: SendMessage("number 6"); break;
			case 7: SendMessage("number 7"); break;
			case 8: SendMessage("number 8"); break;
			case 9: SendMessage("number 9"); break;
			default: SendMessage("nothing!");
		}
	}
    return 0;
}

void SendCommand(alt_u8 cmd)  //bitbang
{
	IOWR_ALTERA_AVALON_PIO_DATA(LCD_BITBANG_BASE, 0x0400 | cmd);
	alt_busy_sleep(1000);
	IOWR_ALTERA_AVALON_PIO_DATA(LCD_BITBANG_BASE, 0x0000 | cmd);  //Enable
	alt_busy_sleep(1000);
	IOWR_ALTERA_AVALON_PIO_DATA(LCD_BITBANG_BASE, 0x0400 | cmd);
	alt_busy_sleep(1000);
}

void SendData(alt_u8 data)  //bitbang
{
	IOWR_ALTERA_AVALON_PIO_DATA(LCD_BITBANG_BASE, 0x0600 | data);
	alt_busy_sleep(1000);
	IOWR_ALTERA_AVALON_PIO_DATA(LCD_BITBANG_BASE, 0x0200 | data);  //Enable
	alt_busy_sleep(1000);
	IOWR_ALTERA_AVALON_PIO_DATA(LCD_BITBANG_BASE, 0x0600 | data);
	alt_busy_sleep(1000);
}

void SendMessage(char *msg)
{
	for(;*msg!= 0;msg++)
	{
		SendData(*msg);
	}
}
