/********************************************************
 Name          : main.c
 Author        : Marcus Jansson
 Copyright     : GPLv3.0
 Description   : EVK1100 template
 **********************************************************/

// Include Files
#ifndef SIM
#include "board.h"
#endif

#ifdef SIM
// System includes
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

#include "FreeRTOS.h"
#include "task.h"
#include "queue.h"
#include "croutine.h"

#include "FreeRTOSConfig.h"

//~ static unsigned long uxQueueSendPassedCount = 0;

//~ void vMainQueueSendPassed( void )
//~ {
	//~ /* This is just an example implementation of the "queue send" trace hook. */
	//~ uxQueueSendPassedCount++;
//~ }

//~ void vApplicationIdleHook( void )
//~ {
	//~ /* The co-routines are executed in the idle task using the idle task hook. */
	//~ vCoRoutineSchedule();	/* Comment this out if not using Co-routines. */

//~ #ifdef SIM
	//~ struct timespec xTimeToSleep, xTimeSlept;
		//~ /* Makes the process more agreeable when using the Posix simulator. */
		//~ xTimeToSleep.tv_sec = 1;
		//~ xTimeToSleep.tv_nsec = 0;
		//~ nanosleep( &xTimeToSleep, &xTimeSlept );
//~ #endif
//~ }

int doprint(const char * str)
{
	#ifdef SIM
	printf("%s", str);
	#else
	//Send to usart, or something similar
	#endif
	return 0;
}

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

	xTaskCreate(task1, (const signed portCHAR *) "task1", 128, NULL, 1, NULL);
	xTaskCreate(task2, (const signed portCHAR *) "task2", 128, NULL, 1, NULL);
#ifdef SIM
	xTaskCreate(task3, (const signed portCHAR *) "task3", 128, NULL, 1, NULL);
#endif
	vTaskStartScheduler();
	while(1);
}
