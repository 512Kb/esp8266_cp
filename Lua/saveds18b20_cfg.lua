function saveds18b20_config(header)
local s=getPostData(header)
if not s then return "error" end 
if not file.open("ds18b20.config","w+") then return "error" end
file.write(s)
file.close()
return "ok"
end