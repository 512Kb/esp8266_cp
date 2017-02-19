function getSens()
local tb=ds18b20.addrs()
local k,v
local z=#tb
local tmp

local i=1
local l='{'
local s='';
local j=1
local coup=readSPI()

if z==0 then 
  if coup~=-1000 then l=l..'"couptemp":"'..string.format('%.1f',coup)..'"}' else l=l..'"couptemp":"--"}' end
return l 
end

for k,v in ipairs(tb) do
for i=1,8 do s=s..v:byte(i,i) 
if i<8 then s=s..' ' end
end

tmp=ds18b20.read(tb[j])
if not tmp then l=l..'"a'..j..'":"'..s..'","t'..j..'":"--"' else
l=l..'"a'..j..'":"'..s..'","t'..j..'":"'..string.format('%.1f',tmp)..'"'
end
s=''        

if j<z then l=l..',' else 
 if coup~=-1000 then l=l..',"couptemp":"'..string.format('%.1f',coup)..'"}' else l=l..',"couptemp":"--"}' end
  end
  
j=j+1
end
return l
end

