function _fpdata(sk)
dofile('getsens.lc')
s=getSens()
getSens=nil
dofile('getset_r_state.lc')
s=s..'|'..rGetState()
rGetState=nil
sk:send(buildRequestStr('200 OK',_,s))
end
