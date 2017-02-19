function _dfile(sk,header)
if hasStr(header,'.set&') then
dofile('passw_procs.lc')
if not checkSid(header,sk) then getSidonPass=nil checkSid=nil end
getSidonPass=nil checkSid=nil
qbeep(1)
end
dofile('dfile.lc')
dfile(header,sk)
dfile=nil
end