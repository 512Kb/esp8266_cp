
function getSidonPass(header,sk)
local res='0'
local d=cjson.decode(getPostData(header))
if file.exists('cfg_passw') then 
file.open('cfg_passw','r')
local s=file.read()
file.close()
local t=cjson.decode(s)
if t.password==d.password then res=sid end
end
sk:send(buildRequestStr('200 OK',_,res))
return
end



function checkSid(header,sk)
local s=getPostData(header)
if hasStr(header,'&sid[') then
local i = string.find(header,"&sid[",1,true) 
local j = string.find(header,"]&",1,true) 
if i > 0 then s=string.sub(header,i+5,j-1) end
print('s= '..s)
if s==sid then return true end
end
sk:send(buildRequestStr('200 OK',_,'ERROR'))
 return false
end
