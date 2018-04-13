SRCS ?= $(wildcard *.vhdl)
OBJS = $(patsubst %.vhdl,%,$(SRCS))
MAIN = bcd_counter_test
SIM_TIME = 1000ns

all: compile run

compile: $(SRCS)
	ghdl -a $(SRCS)
	ghdl -e $(MAIN)

run: compile
	ghdl -r $(MAIN) --stop-time=$(SIM_TIME) --vcd=$(MAIN).vcd

.PHONY: all compile run
