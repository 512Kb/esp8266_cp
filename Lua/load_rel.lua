function load_rel(header,sk)
dofile('loadrelay_cfg.lc')
local s
if hasStr(header, "&relay0&") then s=loadrelay_config('relay0.config') end
if hasStr(header, "&relay1&") then s=loadrelay_config('relay1.config') end 
if hasStr(header, "&relay2&") then s=loadrelay_config('relay2.config') end
if hasStr(header, "&relay3&") then s=loadrelay_config('relay3.config') end
sk:send(buildRequestStr('200 OK',_,s))
loadrelay_config=nil
end
