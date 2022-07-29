# See LICENSE.vyoma for details

TOPLEVEL_LANG ?= verilog

PWD=$(shell pwd)

VERILOG_SOURCES = $(PWD)/               # provide your design path

TOPLEVEL := Sequenctial_Logic_Finite_State_Machine_Pattern_Recognition         # design file
MODULE   :=  test_Sequenctial_Logic_Finite_State_Machine_Pattern_Recognition # test file

include $(shell cocotb-config --makefiles)/Makefile.sim

clean_all: clean
	rm -rf *.xml sim_build __pycache__ 
