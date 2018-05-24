MODEL_PATH ?= ../../src
MODEL_SRCS ?= common.vhdl tp2.vhdl display/bcd_counter.vhdl display/enable_gen.vhdl vga/char_rom.vhdl vga/char_mapper.vhdl vga/gen_pixels.vhdl vga/vga_sync.vhdl vga/vga_ctrl.vhdl
MODEL_SRCS_FULL = $(patsubst %,$(MODEL_PATH)/%,$(MODEL_SRCS))
#MODEL_SRCS ?= $(wildcard $(MODEL_PATH)/*.vhdl)
TEST_SRCS ?= $(wildcard *.vhdl)
OBJS = $(patsubst %.vhdl,%,$(MODEL_SRCS_FULL))
TEST_OBJS = $(patsubst %.vhdl,%,$(TEST_SRCS))
MAIN ?= tp2_test
#MAIN ?= char_rom_test

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
