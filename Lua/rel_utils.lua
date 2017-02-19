function gt(s)
s=string.sub(s,7,10)
return tonumber(s)
end

function gd(s)
return tonumber(s)
end

function getTime(all)
local t=DS3231_getTime()
local d=''
if all then 
if string.len(t[7]) == 1 then d='0'..t[7] else d=t[7] end
if string.len(t[6]) == 1 then d=d..'0'..t[6] else d=d..t[6] end
if string.len(t[5]) == 1 then d=d..'0'..t[5] else d=d..t[5] end
if string.len(t[3]) == 1 then d=d..'0'..t[3] else d=d..t[3] end
if string.len(t[2]) == 1 then d=d..'0'..t[2] else d=d..t[2] end
else
if string.len(t[3]) == 1 then d='0'..t[3] else d=t[3] end
if string.len(t[2]) == 1 then d=d..'0'..t[2] else d=d..t[2] end
end
 return tonumber(d)
end

function getTemp(a)
local tb=ds18b20.addrs()
local k,v
local i,s=1,''
local j=1
for k,v in ipairs(tb) do
for i=1,8 do s=s..v:byte(i,i) 
if i<8 then s=s..' ' end 
end
local tmp=ds18b20.read(tb[j])
if not tmp then return 255 end
if a==s then return tonumber(string.format('%.1f',tmp)) end
s=''
j=j+1
end
return 255
end

function d_destroy()
gt=nil
gd=nil
getTime=nil
getTemp=nil
end
