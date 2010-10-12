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
#The program name, as it will end up in the bin directory.
#####################################################################
PROGRAM = freertos_avr32

#####################################################################
#The directorys where the sources are, and where the binary should go.
#####################################################################
DIR = src
BINDIR = ../bin
SFDIR = $(DIR)/SOFTWARE_FRAMEWORK
PORTABLEDIR = $(FREERTOSDIR:%=../%)/portable

#####################################################################
#The source files which should be compiled.
#####################################################################
SOURCE = \
	$(SFDIR)/BOARDS/EVK1100/led.c \
	$(SFDIR)/DRIVERS/FLASHC/flashc.c \
	$(SFDIR)/DRIVERS/GPIO/gpio.c \
	$(SFDIR)/DRIVERS/INTC/intc.c \
	$(SFDIR)/DRIVERS/PM/pm.c \
	$(SFDIR)/DRIVERS/PM/pm_conf_clocks.c \
	$(SFDIR)/DRIVERS/TC/tc.c \
	$(SFDIR)/DRIVERS/USART/usart.c \
	$(PORTABLEDIR)/GCC/AVR32_UC3/port.c \
	$(PORTABLEDIR)/MemMang/heap_3.c \
	$(FREERTOSSOURCE:%=../%) \
	$(OTHERSOURCE:%=../%)

#####################################################################
#Include files are in these directories.
#####################################################################
INCDIR = \
	$(DIR)/CONFIG \
	$(SFDIR)/BOARDS \
	$(SFDIR)/DRIVERS/CPU/CYCLE_COUNTER \
	$(SFDIR)/DRIVERS/FLASHC \
	$(SFDIR)/DRIVERS/GPIO \
	$(SFDIR)/DRIVERS/INTC \
	$(SFDIR)/DRIVERS/PM \
	$(SFDIR)/DRIVERS/TC \
	$(SFDIR)/DRIVERS/USART \
	$(FREERTOSDIR:%=../%)/include \
	$(FREERTOSDIR:%=../%)/portable/GCC/AVR32_UC3 \
	$(SFDIR)/UTILS/ \
	$(SFDIR)/UTILS/LIBS/NEWLIB_ADDONS/INCLUDE \
	$(SFDIR)/UTILS/PREPROCESSOR \
	$(OTHERINCDIR:%=../%)

#####################################################################
#Other files that are needed
#####################################################################
STARTUP = \
	$(SFDIR)/ASM/trampoline.x \
	$(SFDIR)/UTILS/STARTUP_FILES/GCC/crt0.x \
	$(FREERTOSDIR:%=../%)/portable/GCC/AVR32_UC3/exception.x

LINKDIR= \
	$(SFDIR)/UTILS/LIBS/NEWLIB_ADDONS \
	$(SFDIR)/BOARDS

LINKSCRIPT = $(SFDIR)/UTILS/LINKER_SCRIPTS/AT32UC3A/0512/GCC/link_uc3a0512.lds

OBJECT = $(SOURCE:%.c=%.o) $(STARTUP:%.x=%.o)

#####################################################################
#AVR32 specifics
#####################################################################
BOARD = EVK1100
PART = uc3a0512

CC = avr32-gcc
AS = avr32-as
LD = avr32-ld
OBJCOPY = avr32-objcopy

#####################################################################
#Compiler flags
#####################################################################
DEBUG = -ggdb
CFLAGS = $(INCDIR:%=-I%) $(DEBUG) -O0 -fdata-sections -g3 -Wall -c -fmessage-length=0 -mpart=$(PART) -DBOARD=$(BOARD) -ffunction-sections -masm-addr-pseudos
AFLAGS = -x assembler-with-cpp
LDFLAGS = -nostartfiles $(DEBUG) -T$(LINKSCRIPT) $(LINKDIR:%=-L%) -lnewlib_addons-at32ucr2-speed_opt -mpart=$(PART) -Wl,--gc-sections --rodata-writable -Wl,--direct-data -Wl,-e,_trampoline

#####################################################################
#Compile rules below
#####################################################################
all: clean compile link objcopy done

print:
	$(VERBOSE)$(ECHO) "PORTABLEDIR = $(PORTABLEDIR)"
	$(VERBOSE)$(ECHO) "SOURCE = $(SOURCE)"

compile: $(STARTUPOBJECT) $(OBJECT)

%.o: %.x
	@echo -n .
	$(VERBOSE)$(CC) $(CFLAGS) $(AFLAGS) $< -o$@

#~ ../FreeRTOS/Source/portable/GCC/AVR32_UC3/port.o: ../FreeRTOS/Source/portable/GCC/AVR32_UC3/port.c
#	#~ @echo -n .
#	#~ $(VERBOSE)$(CC) $(CFLAGS) $< -o$@

%.o: %.c
	@echo -n .
	$(VERBOSE)$(CC) $(CFLAGS) $< -o$@


link:
	@echo -n .
	$(VERBOSE)test -d $(BINDIR) || mkdir $(BINDIR)
	$(VERBOSE)$(CC) $(LDFLAGS) $(OBJECT) -o$(BINDIR)/$(PROGRAM).elf

objcopy:
	@echo -n .
	$(VERBOSE)$(OBJCOPY) -O binary $(BINDIR)/$(PROGRAM).elf $(BINDIR)/$(PROGRAM).bin

program: $(BINDIR)/$(PROGRAM).bin
	$(VERBOSE)avr32program program -O0x80000000 -finternal@0x80000000 -e -v -cxtal -Rr $(BINDIR)/$(PROGRAM).bin

gdb:
	$(VERBOSE)avr32gdbproxy -t localhost:4712 -a localhost:4711 -cUSB -eavrdragon

done:
	@echo Done.
	@echo

clean:
	$(VERBOSE)rm -f \
	$(OBJECT) \
	$(BINDIR)/$(PROGRAM).bin \
	$(BINDIR)/$(PROGRAM).elf
