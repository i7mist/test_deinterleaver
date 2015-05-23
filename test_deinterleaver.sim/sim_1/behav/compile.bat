@echo off
rem  Vivado(TM)
rem  compile.bat: a Vivado-generated XSim simulation Script
rem  Copyright 1986-1999, 2001-2013 Xilinx, Inc. All Rights Reserved.

set PATH=$XILINX/lib/$PLATFORM:$XILINX/bin/$PLATFORM;/opt/Xilinx/SDK/2013.4/bin/lin64:/opt/Xilinx/Vivado/2013.4/ids_lite/EDK/bin/lin64:/opt/Xilinx/Vivado/2013.4/ids_lite/ISE/bin/lin64;/opt/Xilinx/Vivado/2013.4/ids_lite/EDK/lib/lin64:/opt/Xilinx/Vivado/2013.4/ids_lite/ISE/lib/lin64;/opt/Xilinx/Vivado/2013.4/bin;%PATH%
set XILINX_PLANAHEAD=/opt/Xilinx/Vivado/2013.4

xelab -m64 --debug typical --relax -L fifo_generator_v11_0 -L work -L unisims_ver -L unimacro_ver -L secureip --snapshot tb_behav --prj /home/ceca/litianshi/test_deinterleaver/test_deinterleaver.sim/sim_1/behav/tb.prj   work.tb   work.glbl
if errorlevel 1 (
   cmd /c exit /b %errorlevel%
)
