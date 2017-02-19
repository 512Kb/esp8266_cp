function rGetState()
local ok,s
local t={}
if getStateRelay(0) then t.r0='1' else t.r0='0' end
if getStateRelay(1) then t.r1='1' else t.r1='0' end
if getStateRelay(2) then t.r2='1' else t.r2='0' end
if getStateRelay(3) then t.r3='1' else t.r3='0' end
ok,s=pcall(cjson.encode,t)
return s
end

--{"r":"1","s":"1"}
function rSetState(json)
local t=cjson.decode(json)
setStateRelay(tonumber(t.r),tonumber(t.s))
end
