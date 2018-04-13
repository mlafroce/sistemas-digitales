MODEL_PATH ?= ../../src
MODEL_SRCS ?= $(wildcard $(MODEL_PATH)/*.vhdl)
TEST_SRCS ?= $(wildcard *.vhdl)
OBJS = $(patsubst %.vhdl,%,$(MODEL_SRCS))
TEST_OBJS = $(patsubst %.vhdl,%,$(TEST_SRCS))
MAIN ?= enable_gen_test

SIM_TIME = 1000ns

SRCS = $(MODEL_SRCS) $(TEST_SRCS)

all: analyze elaborate run

analyze: $(SRCS)
	ghdl -a $(SRCS)

elaborate: analyze
	$(foreach VHDL, $(TEST_OBJS), ghdl -e $(VHDL);)

run: analyze
	ghdl -r $(MAIN) --stop-time=$(SIM_TIME) --vcd=$(MAIN).vcd

.PHONY: all analyze run TEST_OBJS
