
CP='UTF-8'

local function InitMax6675()
local MISO = 7            --> GPIO14
local CLK = 6             --> GPIO12
local CS = 4              --> GPIO13
local i = 0
local result = 0

gpio.mode(CS, gpio.OUTPUT)
gpio.mode(CLK, gpio.OUTPUT)
gpio.mode(MISO, gpio.INPUT,pullup)
gpio.write(CS,gpio.HIGH)
end

local function doInit()
dofile("ds3231.lc") DS3231_init(1,2)
require("ds18b20") ds18b20.pin=3 ds18b20.setup(3)
InitMax6675()
InitMax6675=nil
dofile("max6675.lc")
dofile("webserver.lc")
dofile('relay_control.lc')
control2()
dofile('setwifi.lc') rWiFiSt() rWiFiSt=nil setdefAP=nil
gensid()
httpserver()

        dofile('beep.lc')
        mbeep(3) mbeep=nil mBeepPanic=nil
end

function readCFGs()
local r

if file.exists('cfg_relay0') then 
 file.open('cfg_relay0','r')
local jsr0=file.read()
 file.close()
 r0=cjson.decode(jsr0)
 if r0.active=='0' then r0=nil end
end

if file.exists('cfg_relay1') then 
 file.open('cfg_relay1','r')
 jsr1=file.read()
 file.close()
 r=cjson.decode(jsr1)
 if r.active~='1' then jsr1=nil end 
end

if file.exists('cfg_relay2') then 
 file.open('cfg_relay2','r')
 jsr2=file.read()
 file.close()
 r=cjson.decode(jsr2)
 if r.active~='1' then jsr2=nil end   
end

if file.exists('cfg_relay3') then 
 file.open('cfg_relay3','r')
 jsr3=file.read()
 file.close()
 r=cjson.decode(jsr3)
 if r.active~='1' then jsr3=nil end 
end

end

--reset to default Wi-Fi settings
function btncheck()
gpio.mode(0,gpio.INPUT)
tmr.alarm(2, 1000, tmr.ALARM_AUTO, function()
        if gpio.read(0) == 1 then 
        tmr.unregister(2) 
        dofile('beep.lc')
        mbeep(2) mbeep=nil
        dofile('setwifi.lc') 
        setdefAP() rWiFiSt=nil setdefAP=nil
        file.open('cfg_passw','w+')
        file.write('{"password":"12345"}')
        file.close() 
        end 
       end)
end


node.setcpufreq(node.CPU160MHZ)
node.egc.setmode(node.egc.ALWAYS)
        
local r,reason = node.bootreason()
if (reason~=4) and (reason~=3) then dofile('f_integrity.lc') controlFIntegrity() 
 else
readCFGs() readCFGs=nil
doInit()
doInit=nil
btncheck()
end

