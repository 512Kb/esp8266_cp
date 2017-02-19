function save_rel(header,sk)
dofile('saverelay_cfg.lc')
local s
if hasStr(header, "+relay0+") then s=saverelay_config(header,'relay0.config') end
if hasStr(header, "+relay1+") then s=saverelay_config(header,'relay1.config') end 
if hasStr(header, "+relay2+") then s=saverelay_config(header,'relay2.config') end
if hasStr(header, "+relay3+") then s=saverelay_config(header,'relay3.config') end
sk:send(buildRequestStr('200 OK',_,s))
saverelay_config=nil
end