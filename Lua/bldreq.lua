function _buildRequestStr(resp,len,data)
if (not data) and (not len) then return '' end
local slen,sdata,s
s=''
if isindex then s="\r\nLast-modified: Fri, 23 Dec 2016 01:01:01 GMT" end
if not data then sdata='' else sdata=data end
if not len then slen=data:len() else slen=len end
return 'HTTP/1.1 '..resp..'\r\nServer: ESP8266\r\nConnection: close\r\nContent-Length: '..slen
..'\r\nContent-type: text/html;charset='..CP..s..'\r\n\r\n'..sdata
end
