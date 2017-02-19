-- code source http://www.esp8266.com/viewtopic.php?f=11&t=8671 
-- Function to read SPI
function _readSPI()
local MISO = 7            --> GPIO14
local CLK = 6             --> GPIO12
local CS = 4              --> GPIO13
local i = 0
local result = 0

    gpio.write(CS, gpio.LOW)      -->Activate the chip
    tmr.delay(1)                  -->1us Delay
    gpio.write(CLK, gpio.HIGH)    -->First bit is dummy, ignore it(refer MAX6675 datasheet)
    tmr.delay(2)
    gpio.write(CLK, gpio.LOW)
    tmr.delay(2)
    result = 0
   
   for i=15,1,-1
    do
      result = bit.lshift(result, 1)
      result = bit.bor(result ,(bit.band(gpio.read(MISO),0x01)))
      gpio.write(CLK, gpio.HIGH)   
      tmr.delay(1)
      gpio.write(CLK, gpio.LOW)
      tmr.delay(1)
    end
    if(bit.isset(result,2)) then                      -- refer MAX6675 Datasheet
        print("Sensor not connected")
        gpio.write(CS, gpio.HIGH)
        do return -1000 end
    end
           gpio.write(CS, gpio.HIGH)
    return bit.rshift(result , 3)* .25
end

