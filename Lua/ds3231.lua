--------------------------------------------------------------------------------
-- DS3231 I2C module for NODEMCU
-- NODEMCU TEAM
-- LICENCE: http://opensource.org/licenses/MIT
-- Tobie Booth <tbooth@hindbra.in>
--------------------------------------------------------------------------------

local id = 0
local dev_addr = 0x68

local function decToBcd(val)
  if val == nil then return 0 end
  return((((val/10) - ((val/10)%1)) *16) + (val%10))
end

local function bcdToDec(val)
  return((((val/16) - ((val/16)%1)) *10) + (val%16))
end

function DS3231_init(sda, scl)
  i2c.setup(id, sda, scl, i2c.SLOW)
end

--get time from DS3231
function DS3231_getTime()
local ta={}
local s=''
local i
  i2c.start(id)
  i2c.address(id, dev_addr, i2c.TRANSMITTER)
  i2c.write(id, 0x00)
  i2c.stop(id)
  i2c.start(id)
  i2c.address(id, dev_addr, i2c.RECEIVER)
  local c=i2c.read(id, 7)
  i2c.stop(id)
  for i=1, 7 do ta[i]=bcdToDec(tonumber(string.byte(c, i))) end
  return ta,s   
end



function DS3231_setTime(ta)
 local i
  print("ds3231_settime")
  i2c.start(id)
  i2c.address(id, dev_addr, i2c.TRANSMITTER)
  i2c.write(id, 0x00)
  for i=1, 7 do i2c.write(id, decToBcd(ta[i])) end
  i2c.start(id)
  i2c.address(id, dev_addr, i2c.TRANSMITTER)
  i2c.write(id, 0x0E)
  i2c.stop(id)
  i2c.start(id)
  i2c.address(id, dev_addr, i2c.RECEIVER)
  local c = string.byte(i2c.read(id, 1), 1)
  i2c.stop(id)
  if disOsc == 1 then c = bit.bor(c,128)
  else c = bit.band(c,127) end
  i2c.start(id)
  i2c.address(id, dev_addr, i2c.TRANSMITTER)
  i2c.write(id, 0x0E)
  i2c.write(id, c)
  i2c.stop(id)
end

