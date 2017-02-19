function loadds18b20_config()
if not file.open("ds18b20.config","r") then return "error" end
local s=file.read()
file.close()
return s
end
