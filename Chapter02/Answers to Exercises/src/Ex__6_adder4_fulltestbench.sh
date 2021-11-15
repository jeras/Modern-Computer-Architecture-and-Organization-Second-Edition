#!/bin/sh

# analyse VHDL source code
ghdl -a \
  Ex__4_adder4.vhdl \
  Ex__4_fulladder.vhdl \
  Ex__6_adder4_fulltestbench.vhdl

# elaborate top level entity
ghdl -e ADDER4_TESTBENCH

# run testbench
ghdl -r ADDER4_TESTBENCH --wave=Ex__6_adder4_fulltestbench.ghw

# open waveform with GTKWave
gtkwave Ex__6_adder4_fulltestbench.ghw --save=Ex__6_adder4_fulltestbench.gtkw
