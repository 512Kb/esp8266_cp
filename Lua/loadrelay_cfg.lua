function loadrelay_config(fname)
if not file.open(fname,"r") then return "error" end
local s=file.read()
file.close()
return s
end
