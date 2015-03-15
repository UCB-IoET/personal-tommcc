require "cord"
sh = require "stormsh"

-- start input and outputs

init_adc = function ()
    storm.n.adcife_init()
end

init_a0 = function()
    return storm.n.adcife_new(storm.io.A0, storm.n.adcife_ADC_REFGND, storm.n.adcife_1X, storm.n.adcife_12BIT)
end

get_val = function(adc)
    return (adc:sample() - 2047) * 3300 / 2047
end

get_val_loop = function(adc)
    cord.new(function()
        while(1) do
            print(get_val_loop);   
        end
    end)
end

-- start a coroutine that provides a REPL
sh.start()

-- enter the main event loop. This puts the processor to sleep
-- in between events
cord.enter_loop()
