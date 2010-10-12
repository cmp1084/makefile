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

#####################################################################
#
#####################################################################
FREERTOS_AVR32 = FreeRTOS_AVR32
FREERTOS_SIM = FreeRTOS_Posix

#####################################################################
#
#####################################################################
export
MAKE = make
ECHO = echo

#####################################################################
#The FreeRTOS source directory
#####################################################################
FREERTOSDIR = FreeRTOS/Source

#####################################################################
#The FreeRTOS source files
#####################################################################
FREERTOSSOURCE = \
	$(FREERTOSDIR)/croutine.c \
	$(FREERTOSDIR)/queue.c \
	$(FREERTOSDIR)/tasks.c \
	$(FREERTOSDIR)/list.c \

#####################################################################
#Set other source files here
#####################################################################
OTHERSOURCEDIR = src
OTHERSOURCE = \
	$(OTHERSOURCEDIR)/main.c

#####################################################################
#Set other include directorys here
#####################################################################
OTHERINCDIR = \
	$(OTHERSOURCEDIR)/ \


#####################################################################
#Make rules
#####################################################################
VERBOSE = @

all: avr32 sim

avr32:
	$(VERBOSE)$(ECHO) Making FreeRTOS for AVR32 and EVK1100
	$(VERBOSE)$(MAKE) --no-print-directory -C $(FREERTOS_AVR32)

clean: avr32clean simclean

avr32clean:
	$(VERBOSE)$(MAKE) -sC $(FREERTOS_AVR32) clean

program:
	$(VERBOSE)$(MAKE) -sC $(FREERTOS_AVR32) program


sim:
	$(VERBOSE)$(ECHO) Making FreeRTOS for PC
	$(VERBOSE)$(MAKE) --no-print-directory -C $(FREERTOS_SIM)

simclean:
	$(VERBOSE)$(MAKE) -sC $(FREERTOS_SIM) clean

run:
	$(VERBOSE)$(MAKE) -sC $(FREERTOS_SIM) run
