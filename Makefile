#*****************************************************************************
#
#    Copyright 2010 Marcus Jansson <mjansson256@yahoo.se>
#
#    This file is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This file is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this file.  If not, see <http://www.gnu.org/licenses/>.
#*****************************************************************************

FREERTOS_AVR32 = FreeRTOS_AVR32
FREERTOS_SIM = FreeRTOS_Posix

export VERBOSE = @

all: avr32 sim

avr32:
	@echo \* Making FreeRTOS for AVR32 and EVK1100
	@make --no-print-directory -C $(FREERTOS_AVR32)

clean: avr32clean simclean

avr32clean:
	@make -sC $(FREERTOS_AVR32) clean

program:
	@make -sC $(FREERTOS_AVR32) program


sim:
	@echo \* Making FreeRTOS for PC
	@make --no-print-directory -C $(FREERTOS_SIM)

simclean:
	@make -sC $(FREERTOS_SIM) clean

run:
	@make -sC $(FREERTOS_SIM) run
