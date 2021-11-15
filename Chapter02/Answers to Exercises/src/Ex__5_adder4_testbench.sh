#!/bin/sh

# analyse VHDL source code
ghdl -a \
  Ex__4_adder4.vhdl \
  Ex__4_fulladder.vhdl \
  Ex__5_adder4_testbench.vhdl

# elaborate top level entity
ghdl -e ADDER4_TESTBENCH

# run testbench
ghdl -r ADDER4_TESTBENCH --wave=Ex__5_adder4_testbench.ghw

# open waveform with GTKWave
gtkwave Ex__5_adder4_testbench.ghw --save=Ex__5_adder4_testbench.gtkw
