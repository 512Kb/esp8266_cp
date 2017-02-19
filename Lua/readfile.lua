
function getFileSize(filename)
local l = file.list();
for k,v in pairs(l) do
  if k:lower() == filename:lower() then
    return v;
  end
end
return 0
end

function readHFile(sk,filename)
local s
  if not ifile then print('openTXT') ifile=file.open(filename,"r")
  if not ifile then
 return 
  else
   isindex=true
   sk:send(buildRequestStr('200 OK',getFileSize(filename)))
   isindex=false   
   return
    end
      end
      
   s = file.read()
  if s~=EOF then  sk:send(s) s=''
         else ifile=nil;
              print('closeTXT')
              file.close()
              sk:close()
              s=nil
              print(node.heap())
            end
end


