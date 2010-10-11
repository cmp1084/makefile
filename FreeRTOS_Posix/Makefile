
#*****************************************************************************
#
#    Copyright 2010 Marcus Jansson <mjansson256@yahoo.se>
#
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
PROGRAM = freertos_sim

#####################################################################
#The directorys where the source is, and where the binary should go.
#####################################################################
DIR = .
FREERTOSDIR = $(DIR)/FreeRTOS_Kernel
BINDIR = ../bin

#####################################################################
#The source files which should be compiled.
#####################################################################
SOURCE = \
	$(FREERTOSDIR)/portable/GCC/Posix/port.c \
	$(FREERTOSDIR)/portable/MemMang/heap_3.c \
	$(FREERTOSDIR)/croutine.c \
	$(FREERTOSDIR)/queue.c \
	$(FREERTOSDIR)/tasks.c \
	$(FREERTOSDIR)/list.c \
	$(DIR)/main.c

#####################################################################
#Include files are in these directories.
#####################################################################
INCDIR = ./ \
	$(DIR)/CONFIG \
	$(FREERTOSDIR)/include \
	$(FREERTOSDIR)/portable/GCC/Posix \

STARTUP =
LINKDIR =
LINKSCRIPT =
OBJECT = $(SOURCE:%.c=%.o)
STARTUPOBJECT = $(STARTUP:%.x=%.o)

#####################################################################
#PC specifics
#####################################################################
DEBUG = -ggdb
CC = gcc


#####################################################################
#Compiler flags
#####################################################################
DEBUG = -ggdb
CFLAGS = -DSIM=1 -DUSE_STDIO=1 -D__GCC_POSIX__=1 $(INCDIR:%=-I%) -O2 $(DEBUG) -Wall -c -fmessage-length=0 -pthread -lrt
LDFLAGS = -pthread -lrt $(DEBUG)
AFLAGS = -x assembler-with-cpp

#~ VERBOSE = @
#####################################################################
#Compile rules below
#####################################################################
all: clean compile link done

compile: $(STARTUPOBJECT) $(OBJECT)

%.o: %.x
	@echo -n .
	$(VERBOSE)$(CC) $(CFLAGS) $(AFLAGS) $< -o$@

%.o: %.c
	@echo -n .
	$(VERBOSE)$(CC) $(CFLAGS) $< -o$@

link:
	@echo -n .
	$(VERBOSE)test -d $(BINDIR) || mkdir $(BINDIR)
	$(VERBOSE)$(CC) $(LDFLAGS) $(STARTUPOBJECT) $(OBJECT) -o$(BINDIR)/$(PROGRAM)

done:
	@echo
	@echo Done.
	@echo

clean:
	$(VERBOSE)rm -f \
	$(STARTUPOBJECT) \
	$(OBJECT) \
	$(BINDIR)/$(PROGRAM)
