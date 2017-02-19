
local indexfile="Index.html"
sid=''
isindex=false

function readSPI()
dofile('max6675.lc')
local a=_readSPI()
_readSPI=nil
return a
end

function qbeep(n)
local i,j
pwm.setup(5,800,1000)
for j=0,n-1 do
pwm.start(5)
for i=0,20000 do i=i+1 end
pwm.stop(5)
for i=0,20000 do i=i+1 end
end
pwm.close(5)
end

function gensid()
dofile('rel_utils.lc')
sid = tostring(math.random(getTime(true)-getTime(false)))
print('gensid=  '..sid)
d_destroy() d_destroy=nil
end

function hasStr(header, str)
local i,j=string.find(header,str,1,true)
if i then return true end
return false
end

function findHeaderParamValue(header, param)
local s,i
i=param:len()
s=param
if s:sub(i,i) ~= ' ' then s = s..' ' end
local i,j = string.find(header,s,1,true)
if not i then return end
local k,l =  string.find(header,"\r\n",j,true)
if k then return header:sub(j+1,k-1) end
end

function getPostData(header)
local i,j = string.find(header,"\r\n\r\n",1,true)
local lcontent = findHeaderParamValue(header,"Content-Length:")
if (not i) or (not lcontent) then return end
j=j+1
return header:sub(j,j+lcontent)
end


function buildRequestStr(r,l,d)
dofile('bldreq.lc')
local s=_buildRequestStr(r,l,d)
_buildRequestStr=nil
return s
end


function http_reqv(sk,req)
local res
dofile('httpreqv.lc')
res=parseHTTPRequest(sk,req)
parseHTTPRequest=nil
return res
end


function httpserver()
local i
srv = net.createServer(net.TCP)
srv:listen(80, function(conn)
  conn:on("receive", function(sck, req)
 -- print(req)

        i,_=string.find(req,'GET / HTTP/')
        if i==1 then
        i,_=string.find(req,'If-Modified-Si',1,true)
        if i then 
            sck:send(buildRequestStr('304 Not Modified',_,' 304 Not Modified'))
            sck:close()
           -- return        
        end
       
        if ifile then 
            file.close()
            ifile=nil
            end
        end
        
function send(sk)
       i,_=string.find(req,'GET / HTTP/')
       if i==1 then               
       if readHFile == nil then gensid() dofile('readfile.lc') end
        readHFile(sk,indexfile) 
        if not ifile then readHFile=nil getFileSize=nil end
            elseif
                 http_reqv(sk,req) then
                 sk:close()
               else 
                sk:send(buildRequestStr('400 ERROR',_,'ERROR'))
                sk:close()
              end 
 end  

    sck:on("sent", send)
    send(sck)
  end)
end)
end