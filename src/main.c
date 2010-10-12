/********************************************************
 Name          : main.c
 Author        : Marcus Jansson
 Copyright     : GPLv3.0
 Description   : EVK1100 template
 **********************************************************/

//AVR32 includes
#ifndef SIM
#include "board.h"
#endif

//Simulator includes
#ifdef SIM
#include <stdio.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <sys/stat.h>
#include <mqueue.h>
#include <errno.h>
#include <unistd.h>
#endif

//FreeRTOS includes
#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "croutine.h"


void vApplicationIdleHook( void )
{
#ifdef SIM
	/* Makes the process more agreeable when using the simulator. */
	struct timespec xTimeToSleep, xTimeSlept;
	xTimeToSleep.tv_sec = 1;
	xTimeToSleep.tv_nsec = 0;
	nanosleep( &xTimeToSleep, &xTimeSlept );
#endif
}

//Just a small example
int doprint(const char * str)
{
	#ifdef SIM
	printf("%s", str);
	#else //AVR32
	//Send to usart, or something similar
	#endif
	return 0;
}

//Just a small example
void task1(void * p)
{
	while(1) {
		doprint("a");
		taskYIELD();
	}
}

void task2(void * p)
{
	while(1) {
		doprint("b");
		taskYIELD();
	}
}

#ifdef SIM
void task3(void * p)
{
	while(1) {
		doprint("c");
		taskYIELD();
	}
}
#endif

int main(void)
{
	//Just a small example
	xTaskCreate(task1, (const signed portCHAR *) "task1", 128, NULL, 1, NULL);
	xTaskCreate(task2, (const signed portCHAR *) "task2", 128, NULL, 1, NULL);
#ifdef SIM
	xTaskCreate(task3, (const signed portCHAR *) "task3", 128, NULL, 1, NULL);
#endif
	vTaskStartScheduler();
	while(1);
}
