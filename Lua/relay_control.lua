
ro=2

function ri2c_r()
i2c.start(0)
i2c.address(0, 0x20, i2c.RECEIVER)
local res=i2c.read(0,1)
i2c.stop(0)
return string.byte(res)
end


function ri2c_w(d)
i2c.start(0)
i2c.address(0, 0x20, i2c.TRANSMITTER)
i2c.write(0,d)
i2c.stop(0)
end


function setStateRelay(n,s)
local k=ri2c_r()
if s==0 then 
k=bit.set(k,n) else k=bit.clear(k,n)
end
ri2c_w(k)
end

function getStateRelay(n)
return not bit.isset(ri2c_r(),n)
end

function rel0_ctrl()
local c=readSPI()
if c ~=-1000 then
if c==tonumber(0) then qbeep(7) end
if c >= tonumber(r0.temp_on) then setStateRelay(0,1) end 
if c <= tonumber(r0.temp_off) then setStateRelay(0,0) end
else
qbeep(5)
end
end

function relay_control()
local r
if r0 then rel0_ctrl() end


if (ro==2) and (jsr1) then
r=cjson.decode(jsr1) 
if r.active=='1' then
dofile('relay_x_ctrl.lc')
relx_ctrl(r,1) relx_ctrl=nil 
end
end


if (ro==3) and (jsr2) then
r=cjson.decode(jsr2) 
if r.active=='1' then 
dofile('relay_x_ctrl.lc')
relx_ctrl(r,2) relx_ctrl=nil 
end
end


if (ro==4) and (jsr3) then
r=cjson.decode(jsr3) 
if r.active=='1' then 
dofile('relay_x_ctrl.lc')
relx_ctrl(r,3) relx_ctrl=nil 
end
end

ro=ro+1
if ro==5 then ro=2 end
end

function control2()
tmr.alarm(0, 2000, tmr.ALARM_AUTO, relay_control)
end
