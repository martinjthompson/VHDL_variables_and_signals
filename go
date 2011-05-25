#!/bin/sh
ghdl -a clock.vhd
ghdl -a signals.vhd
ghdl -a variables.vhd
ghdl -a tb_clock.vhd
ghdl --elab-run tb_clock