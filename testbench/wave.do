onerror {resume}
quietly WaveActivateNextPane {} 0


add wave -divider Clocks
add wave -noupdate 	/top/clock_gen/clk_50
add wave -noupdate 	/top/clock_gen/clk_200
add wave -noupdate 	/top/clock_gen/clk_400

add wave -divider SHA256
add wave -noupdate 	/top/SHA256/dif/rst_n
add wave -noupdate 	/top/SHA256/dif/load
add wave -noupdate 	/top/SHA256/dif/message
add wave -noupdate 	/top/SHA256/dif/message_length
add wave -noupdate 	/top/SHA256/dif/data_length
add wave -noupdate 	/top/SHA256/data0
add wave -noupdate 	/top/SHA256/data1
add wave -noupdate 	/top/SHA256/message_processed

add wave -divider sha_digester
add wave -noupdate   /top/SHA256/sha_transform/sha_digester/message
add wave -noupdate   /top/SHA256/sha_transform/sha_digester/sig0_x
add wave -noupdate 	 /top/SHA256/sha_transform/sha_digester/sig0_out
add wave -noupdate   /top/SHA256/sha_transform/sha_digester/sig1_x
add wave -noupdate 	 /top/SHA256/sha_transform/sha_digester/sig1_out
add wave -noupdate   /top/SHA256/sha_transform/sha_digester/w

add wave -divider sha_transform
add wave -noupdate 	/top/SHA256/sha_transform/m_temp
add wave -noupdate  /top/SHA256/sha_transform/a
add wave -noupdate  /top/SHA256/sha_transform/b
add wave -noupdate  /top/SHA256/sha_transform/c
add wave -noupdate  /top/SHA256/sha_transform/d
add wave -noupdate  /top/SHA256/sha_transform/e
add wave -noupdate  /top/SHA256/sha_transform/f
add wave -noupdate  /top/SHA256/sha_transform/g
add wave -noupdate  /top/SHA256/sha_transform/h
add wave -noupdate  /top/SHA256/sha_transform/maj_out
add wave -noupdate  /top/SHA256/sha_transform/ch_out
add wave -noupdate  /top/SHA256/sha_transform/ep0_out
add wave -noupdate  /top/SHA256/sha_transform/ep1_out
add wave -noupdate  /top/SHA256/sha_transform/t1
add wave -noupdate  /top/SHA256/sha_transform/t2

add wave -divider hash
add wave -noupdate /top/SHA256/sha_transform/m_temp
add wave -noupdate /top/SHA256/sha_transform/hash

add wave -divider debug_variables
add wave -noupdate /top/SHA256/sha_transform/temp_t1_0
add wave -noupdate /top/SHA256/sha_transform/temp_t2_0
add wave -noupdate /top/SHA256/sha_transform/ks_temp

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {490000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 250
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {2000 ns}
