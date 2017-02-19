local function setAP(st)
wifi.setmode(wifi.SOFTAP)
apcfg={ssid=st.ssid, pwd=st.password}
wifi.ap.config(apcfg)
apipcfg ={ip=st.ip,netmask=st.mask,gateway=st.gate}
wifi.ap.setip(apipcfg)
wifi.ap.dhcp.start()
end

local function setSta(st)
wifi.setmode(wifi.STATION)
wifi.sta.config(st.ssid,st.password)
ipcfg = {ip=st.ip,netmask=st.mask,gateway=st.gate}
wifi.sta.setip(ipcfg)
wifi.sta.connect()
end

function setdefAP()
wifi.setmode(wifi.SOFTAP)
apcfg={ssid="espnet",pwd="123456789"}
wifi.ap.config(apcfg)
apipcfg ={ip="192.168.0.2",netmask="255.255.255.0",gateway="192.168.0.1"}
wifi.ap.setip(apipcfg)
wifi.ap.dhcp.start()
end

function rWiFiSt()
local fn="cfg_wifi"
if not file.exists(fn) then print('defAP') setdefAP() setdefAP=nil return end
local sfile=file.open(fn,"r")
if sfile==nil then return end
local json=file.read()
file.close()
local st=cjson.decode(json)
if st.mode=='ap' then
print('AP')
setAP(st)
  else 
print('STA')  
setSta(st) 
end
setdefAP=nil
end

