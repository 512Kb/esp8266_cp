
function parseHTTPRequest(sk,header)
local res=false
local s

if hasStr(header,'favicon.ico') then 
sk:send(buildRequestStr('200 OK',_,'OK'))
res=true

  elseif

hasStr(header, '&fpdata&') then -- dinamic sensors data
dofile('fpdata.lc')
_fpdata(sk)
_fpdata=nil
res=true   

 elseif

hasStr(header, "&time&") then
s=table.concat(DS3231_getTime(),'.')
sk:send(buildRequestStr('200 OK',_,s))
res=true

 elseif
 
hasStr(header, "+time+") then
dofile('settime.lc')
_stime(sk,header)
_stime=nil
res=true

 elseif
 
hasStr(header, "&sens&") then
dofile('getsens.lc')
s=getSens()
getSens=nil
sk:send(buildRequestStr('200 OK',_,s))
res=true

 elseif
 
hasStr(header,'&relay.get&') then
dofile('getset_r_state.lc')
sk:send(buildRequestStr('200 OK',_,rGetState()))
rGetState=nil
rSetState=nil
res=true

 elseif

hasStr(header,'&relay.set&') then
dofile('relset.lc')
_relset(sk,header) 
_relset=nil
res=true
 

 elseif

--file size must be less then 1000 bytes
hasStr(header,'&dfile') then
dofile('fileop.lc')
_dfile(sk,header)
_dfile=nil
res=true

 elseif

hasStr(header,'&reboot&') then
dofile('passw_procs.lc')
if not checkSid(header,sk) then getSidonPass=nil checkSid=nil return true end
getSidonPass=nil checkSid=nil
qbeep(1)
sk:send(buildRequestStr('200 OK',_,'OK'))
tmr.alarm(3, 1500, tmr.ALARM_AUTO, function() node.restart() end)
res=true

 elseif

hasStr(header,'&getsid&') then
dofile('passw_procs.lc')
getSidonPass(header,sk)
getSidonPass=nil
checkSid=nil
res=true
end

return res
end
