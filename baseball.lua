require "cord"
require "storm"
shield = require "starter"


startGame = function()
	

shield.Button.start()
shield.LED.start()
shield.Button.when(2, storm.io.RISING, startGame)

cord.enter_loop()
