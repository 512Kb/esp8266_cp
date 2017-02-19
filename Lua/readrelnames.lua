function getRelnames()
local s={}
local n={}
file.open('cfg_relay0',"r")
local json=file.read()
file.close()
s=cjson.decode(json)
n.r0=s.name;
n.r0act=s.active;
s={}
file.open('cfg_relay1',"r")
json=file.read()
file.close()
s=cjson.decode(json)
n.r1=s.name;
n.r1act=s.active;
s={}
file.open('cfg_relay2',"r")
json=file.read()
file.close()
s=cjson.decode(json)
n.r2=s.name;
n.r2act=s.active;
s={}
file.open('cfg_relay3',"r")
json=file.read()
file.close()
s=cjson.decode(json)
n.r3=s.name;
n.r3act=s.active;
s={}
local ok, _json = pcall(cjson.encode, n)
if ok then return _json else return end
end

