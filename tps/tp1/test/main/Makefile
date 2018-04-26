########################################################################
# Copyright (c) 2018 Matías Lafroce <mlafroce@gmail.com>
#
# Based on David Caruso's makefiles
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
########################################################################
# Description
# 
# Makefile for Testbench for adc with COCOTB!
########################################################################
# Author: Matías Lafroce <mlafroce@gmail.com>
########################################################################

PWD=$(shell pwd)

ifeq ($(OS),Msys)
WPWD=$(shell sh -c 'pwd -W')
PYTHONPATH := $(WPWD)/../sim;$(PYTHONPATH)
else
WPWD=$(shell pwd)
PYTHONPATH := $(WPWD)/../sim:$(PYTHONPATH)
endif

SIM = ghdl

SRCS = common.vhdl bcd_to_7seg.vhdl bcd_counter.vhdl enable_gen.vhdl \
 counter_2bit.vhdl mux_4to1.vhdl mux_16to4.vhdl deco_2to4.vhdl \
 display_controller.vhdl main.vhdl

SRCS_FILES := $(addprefix $(WPWD)/../../src/,$(SRCS))
VHDL_SOURCES = $(SRCS_FILES)

TOPLEVEL := tp
MODULE   := main_tb

include $(COCOTB)/makefiles/Makefile.inc
include $(COCOTB)/makefiles/Makefile.sim

