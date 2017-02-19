function forFirstPannel()
local a={}
local s

if not file.open('cfg_ds18b20','r') then return end
s=file.read()
table.insert(a,s)
file.close()
s=''
if not file.open('cfg_couple','r') then return end
s=file.read()
table.insert(a,s)
file.close()
s=''
dofile('readrelnames.lc')
s=getRelnames()
getRelnames=nil
table.insert(a,s)

return table.concat(a,'|')
end
