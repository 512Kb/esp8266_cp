function _stime(sk,header)
dofile('passw_procs.lc')
if not checkSid(header,sk) then getSidonPass=nil checkSid=nil return true end
getSidonPass=nil checkSid=nil
dofile('adjusttime.lc')
adjustTime(sk,header)
adjustTime=nil
qbeep(1)
sk:send(buildRequestStr('200 OK',_,'OK'))
end