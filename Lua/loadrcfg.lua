
 function loadRCfg()
local json
local t={}
local rc={}
if file.exists('cfg_relay0') then 
file.open('cfg_relay0','r') json=file.read() file.close()
t=cjson.decode(json)
rc.r0act=t.active
if t.active=='1' then
rc.r0tmpon=t.temp_on
rc.r0tmpoff=t.temp_off
end
end


if file.exists('cfg_relay1') then 
file.open('cfg_relay1','r') json=file.read() file.close()
t=cjson.decode(json)
rc.r1act=t.active

if t.active=='1' then
rc.r1tmpactiv=t.tmpactiv

if t.tmpactiv=='1' then
rc.r1tmpon=t.tmp_on
rc.r1tmpoff=t.tmp_off
rc.r1ds_a=t.ds_a
rc.r1d=t.d
else
rc.r1t1on=t.t1on
rc.r1t1off=t.t1off
rc.r1t1ed=t.t1ed
rc.r1t2on=t.t2on
rc.r1t2off=t.t2off
rc.r1t2ed=t.t2ed
rc.r1t3on=t.t3on
rc.r1t3off=t.t3off
rc.r1t3ed=t3ed
end

end
end

if file.exists('cfg_relay2') then 
file.open('cfg_relay2','r') json=file.read() file.close()
t=cjson.decode(json)
rc.r2act=t.active

if t.active=='1' then
rc.r2tmpactiv=t.tmpactiv
if t.tmpactiv=='1' then 
rc.r2tmpon=t.tmp_on
rc.r2tmpoff=t.tmp_off
rc.r2ds_a=t.ds_a
rc.r2d=t.d
else
rc.r2t1on=t.t1on
rc.r2t1off=t.t1off
rc.r2t1ed=t.t1ed
rc.r2t2on=t.t2on
rc.r2t2off=t.t2off
rc.r2t2ed=t.t2ed
rc.r2t3on=t.t3on
rc.r2t3off=t.t3off
rc.r2t3ed=t.t3ed
end
end
end

if file.exists('cfg_relay3') then 
file.open('cfg_relay3','r') json=file.read() file.close()
t=cjson.decode(json)
rc.r3act=t.active
if t.active=='1' then
rc.r3tmpactiv=t.tmpactiv
if t.tmpactiv=='1' then
rc.r3tmpon=t.tmp_on
rc.r3tmpoff=t.tmp_off
rc.r3ds_a=t.ds_a
rc.r3d=t.d
else
rc.r3t1on=t.t1on
rc.r3t1off=t.t1off
rc.r3t1ed=t.t1ed
rc.r3t2on=t.t2on
rc.r3t2off=t.t2off
rc.r3t2ed=t.t2ed
rc.r3t3on=t.t3on
rc.r3t3off=t.t3off
rc.r3t3ed=t.t3ed
end
end
end
return rc
end
