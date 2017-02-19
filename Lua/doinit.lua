

function doInit()
print('doInit')
gensid()
node.egc.setmode(node.egc.ALWAYS)
dofile('setwifi.lc')
httpserver()
end

doInit()
doInit=nil

