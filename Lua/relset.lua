function _relset(sk,header)
dofile('passw_procs.lc')
if not checkSid(header,sk) then getSidonPass=nil checkSid=nil return end
getSidonPass=nil checkSid=nil
dofile('getset_r_state.lc')
s=getPostData(header)
rSetState(s)
rGetState=nil
rSetState=nil
qbeep(1)
sk:send(buildRequestStr('200 OK',_,'OK'))
end