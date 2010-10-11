/********************************************************
 Name          : main.c
 Author        : Marcus Jansson
 Copyright     : GPLv3.0
 Description   : EVK1100 template
 **********************************************************/

// Include Files
#include "board.h"
#include "FreeRTOS.h"
#include "FreeRTOSConfig.h"
#include "task.h"

void task1(void * p)
{
	while(1) {
		taskYIELD();
	}
}

void task2(void * p)
{
	while(1) {
		taskYIELD();
	}
}

int main(void)
{

	xTaskCreate(task1, (const signed portCHAR *) "task1", 128, NULL, 1, NULL);
	xTaskCreate(task2, (const signed portCHAR *) "task2", 128, NULL, 1, NULL);
	vTaskStartScheduler();
	while(1);
}
