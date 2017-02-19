function readTemp()
local tb=ds18b20.addrs()
local i=1
local l='{'
local s='';
local j=1
for k,v in ipairs(tb) do
for i=1,8 do s=s..v:byte(i,i)..' ' 
if i<8 then s=s..' ' end
end
l=l..'"a'..j..'":"'..s..'","t'..j..'":"'..string.format('%.1f',ds18b20.read(tb[j]))..'"'
s=''
if j<5 then l=l..',' else l=l..',"couptemp":"'..readSPI()..'"}' end
j=j+1
end
return l
end