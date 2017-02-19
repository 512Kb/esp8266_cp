--&dfile[].get&
function getFName(header)
local s=''
local i = string.find(header,"&dfile[",1,true) 
local j = string.find(header,"].",1,true) 
if i > 0 then s=string.sub(header,i+7,j-1) end
return s
end

function dfile(header,sk)
local e='ERROR'
local s
fn=getFName(header)
getFName=nil
print(fn)
if string.sub(fn,1,4) ~='cfg_' then sk:send(buildRequestStr('200 OK',_,e)) return end 

if hasStr(header,'.get&') then
if fn=='cfg_passw' then sk:send(buildRequestStr('200 OK',_,e)) return end 
if not file.exists(fn) then s=e 
else
file.open(fn) s=file.read() file.close() 
end
elseif
hasStr(header,'.set&') then
s=getPostData(header)
if not file.open(fn,'w+') then s=e 
else file.write(s) file.flush() file.close() s='OK' end
end
 sk:send(buildRequestStr('200 OK',_,s))
end 
