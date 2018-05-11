MODEL_PATH ?= ../../src
MODEL_SRCS ?= common.vhdl bcd_counter.vhdl enable_gen.vhdl mux_4to1.vhdl mux_16to4.vhdl deco_2to4.vhdl counter_2bit.vhdl bcd_to_7seg.vhdl display_controller.vhdl main.vhdl
MODEL_SRCS_FULL = $(patsubst %,$(MODEL_PATH)/%,$(MODEL_SRCS))
#MODEL_SRCS ?= $(wildcard $(MODEL_PATH)/*.vhdl)
TEST_SRCS ?= $(wildcard *.vhdl)
OBJS = $(patsubst %.vhdl,%,$(MODEL_SRCS_FULL))
TEST_OBJS = $(patsubst %.vhdl,%,$(TEST_SRCS))
#MAIN ?= bcd_counter_test
MAIN ?= display_controller_test
#MAIN ?= main_test

SIM_TIME = 500us

SRCS = $(MODEL_SRCS_FULL) $(TEST_SRCS)

all: analyze elaborate run

analyze: $(SRCS)
	ghdl -a $(SRCS)

elaborate: analyze
	$(foreach VHDL, $(TEST_OBJS), ghdl -e $(VHDL);)

run: analyze
	ghdl -r $(MAIN) --stop-time=$(SIM_TIME) --vcd=$(MAIN).vcd

.PHONY: all analyze run TEST_OBJS
