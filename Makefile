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
#The FreeRTOS source directory
#####################################################################
FREERTOSDIR = FreeRTOSV6.1.0/Source

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
#Directories where specific code for AVR32 or sim is located
#####################################################################
FREERTOS_AVR32 = specific_avr32
FREERTOS_SIM = specific_posix

#####################################################################
#Make rules
#####################################################################
export
ifeq ($(V),1)
VERBOSE = @
NOPRINT =
endif
ifndef V
VERBOSE = @
NOPRINT = --no-print-directory
endif


MAKE = make
ECHO = echo

all: avr32 sim

avr32:
	$(VERBOSE)$(ECHO) Compiling FreeRTOS for AVR32 and EVK1100
	$(VERBOSE)$(MAKE) $(NOPRINT) -C $(FREERTOS_AVR32)
	$(VERBOSE)$(ECHO)

clean: avr32clean simclean

avr32clean:
	$(VERBOSE)$(MAKE) $(NOPRINT) -C $(FREERTOS_AVR32) clean

program:
	$(VERBOSE)$(MAKE) $(NOPRINT) -C $(FREERTOS_AVR32) program


sim:
	$(VERBOSE)$(ECHO) Compiling FreeRTOS for PC
	$(VERBOSE)$(MAKE) $(NOPRINT) -C $(FREERTOS_SIM)
	$(VERBOSE)$(ECHO)

simclean:
	$(VERBOSE)$(MAKE) --no-print-directory -C $(FREERTOS_SIM) clean

run:
	$(VERBOSE)$(MAKE) --no-print-directory -C $(FREERTOS_SIM) run
