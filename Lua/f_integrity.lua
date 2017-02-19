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

function crc32file(fn)
local _crc32=0
local i
if not file.exists(fn) then return 0 end
  file.open(fn,'r')
  while 1==1 do
  local s=file.readline()
  if s==EOF then file.close() return _crc32 end
  for i=1,string.len(s) do _crc32=crc32.crc32_byte(s:byte(i,i),_crc32) end
  end 
end


function controlFIntegrity()
require('crc32')
local s,ss='',''
if not file.exists('hash_lc') then dofile('beep.lc') mBeepPanic() return end
file.open('hash_lc','r')

while true do
local s=file.read()
if s ~= EOF then ss=ss..s else break end
end

file.close()
local t=cjson.decode(ss)


for k,v in pairs(t) do
 if string.sub(k,string.len(k)-2) == '.lc'then
   qbeep(1)
   if not file.exists(k) then print(k..' FILE NOT EXISTS!') dofile('beep.lc') mBeepPanic() return end 
   if crc32file(k) ~=tonumber(v) then print(k..' CRC32 ERROR!') dofile('beep.lc') mBeepPanic() return end 
   print(k..':'..v)
 end  
end

k='init.lua'
if not file.exists(k) then print(k..' FILE NOT EXISTS!') dofile('beep.lc') mBeepPanic() return end 
print(k..':'..t[k])
if crc32file(k) ~=tonumber(t[k]) then print(k..' CRC32 ERROR!') dofile('beep.lc') mBeepPanic() return end 
k='Index.html'
if not file.exists(k) then print(k..' FILE NOT EXISTS!') dofile('beep.lc') mBeepPanic() return end 
print(k..':'..t[k])
if crc32file(k) ~=tonumber(t[k]) then print(k..' CRC32 ERROR!') dofile('beep.lc') mBeepPanic() return end 
print('Files integrity ok')
print('Soft restart...')
node.restart()
end


function saveFHash()
require('crc32')
local l = file.list();
local t={}
for k,v in pairs(l) do
 if string.find(k,'.lc',1,true) then 
print('file: '..k) 
 t[k]=tostring(crc32file(k))
print('ok')  
   end
if string.find(k,'.lua',1,true) then 
print('file: '..k)
 t[k]=tostring(crc32file(k))
print('ok') 
    end
 end
print('file: Index.html')    
 t['Index.html']=tostring(crc32file('Index.html'))
print('ok') 
 local ok,s=pcall(cjson.encode,t)
if ok then 
file.open('hash_lc','w+')
file.write(s)
file.close()
   end
end
