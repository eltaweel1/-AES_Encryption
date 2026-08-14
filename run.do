vlib work
vlog *.*v
vsim -voptargs=+acc work.AES_CTR_512_tb
add wave *

run -all