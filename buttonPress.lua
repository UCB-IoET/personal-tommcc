require("storm")
require("cord")
shield = require("starter")


shield.Button.start()
shield.LED.start()
last = 0
current = 0



time = function()
	shift = storm.os.SHIFT_0
	last = current
	current = storm.os.now(shift) / storm.os.MILLISECOND
	print(current - last)
	return
end

pressed = function(num)
	print("pressed time...")
	timehandle = shield.Button.whenever(num, storm.io.RISING, time)
	return
end
storm.io.set_pull(storm.io.PULL_KEEP)
pressed(1)



cord.enter_loop()

