function saverelay_config(header,fn)
local s=getPostData(header)
if not s then return "error" end 
if not file.open(fn,"w+") then return "error" end
file.write(s)
file.close()
return "ok"
end