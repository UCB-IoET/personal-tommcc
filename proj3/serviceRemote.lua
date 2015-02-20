require("storm") -- libraries for interfacing with the board and kernel
require("cord") -- scheduler / fiber library
print ("Base  test ")

sh = require "stormsh"
LED = require("led")
Button = require("button")
blu = LED:new("D2")
grn = LED:new("D3")
red1 = LED:new("D4")


asock= storm.net.udpsocket(1525,
	function(payload, from, port)
		p=storm.mp.unpack(payload)
	end
)
bsock = storm.net.udpsocket(1526,
		function(payload, from, port)
			--print(string.format("recieved, %d, %d", rec, total))
			p = storm.mp.unpack(payload)
			print(p)
			if p[2][1] == true then
				if p[1] == "blueOn" then
					blu:on()
				elseif p[1] == "grnOn" then
					grn:on()
				elseif p[1] == "setR" then
					red1:on()
				end
			elseif p[2][1] == false then
				if p[1] == "blueOn" then
					blu:off()
				elseif p[1] == "grnOn" then
					grn:off()
				elseif p[1] == "setR" then
					red1:off()
				end
			end
		end
)

local svc_manifest = {
		id="TomStorm",
		blueOn={ s="setBool"},
		grnOn={ s="setBool"},
		setR={ s="setBool"}
	}
local lightred = {"setR", {false}}
local msg = storm.mp.pack(svc_manifest)
local rmsg = storm.mp.pack(lightred)
handle = storm.os.invokePeriodically(725*storm.os.MILLISECOND, function()
	print("sending")
	storm.net.sendto(asock,msg, "ff02::1", 1525)
end)


-- for led in lab
lighte = "fe80::212:6d02:0:304e"
lightd = "fe80::212:6d02:0:304d"
redOn = function(ip)
	storm.os.invokePeriodically(750*storm.os.MILLISECOND, function()
		print("sending")
		--total = total + 1
		storm.net.sendto(bsock, rmsg, ip, 1526)
	end)
end


-- start a shell so you can play more
-- start a coroutine that provides a REPL
sh.start()

-- enter the main event loop. This puts the processor to sleep
-- in between events
cord.enter_loop()
