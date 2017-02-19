function relx_ctrl(r, relnum)
local c

if relnum==1 then pt1=false end
if relnum==2 then pt2=false end
if relnum==3 then pt3=false end


dofile('rel_utils.lc')
if r.tmpactiv=='1' then
if (r.ds_a ~='--') and (r.ds_a ~='') then 

if (relnum==1) and (not pt1) then c=getTemp(r.ds_a) pt1=true end
if (relnum==2) and (not pt2) then c=getTemp(r.ds_a) pt2=true end
if (relnum==3) and (not pt3) then c=getTemp(r.ds_a) pt3=true end

c=getTemp(r.ds_a)
if c==255 then qbeep(5) else
if (r.tmp_on~='--') and (r.tmp_off~='--') then


if tonumber(r.tmp_on) < tonumber(r.tmp_off) then 
    if c <= tonumber(r.tmp_on) then setStateRelay(relnum,1) end
    if c >= tonumber(r.tmp_off) then setStateRelay(relnum,0) end
return
end
  
if tonumber(r.tmp_on) > tonumber(r.tmp_off) then 
    if c >= tonumber(r.tmp_on) then setStateRelay(relnum,1) end
    if c <= tonumber(r.tmp_off) then setStateRelay(relnum,0) end
return
end

 return 

else qbeep(5) end
end
end

  else 

    if r.t1a=='1' then
     if r.t1ed=='1' then
      c=getTime(false)
      if c == gt(r.t1on) then setStateRelay(relnum,1) end
      if c == gt(r.t1off) then setStateRelay(relnum,0) end    
     else
      c=getTime(true)
      if c == gd(r.t1on) then setStateRelay(relnum,1) end
      if c == gd(r.t1off) then setStateRelay(relnum,0) end    
     end 
    end  

    if r.t2a=='1' then
     if r.t2ed=='1' then
      c=getTime(false)
      if c == gt(r.t2on) then setStateRelay(relnum,1) end
      if c == gt(r.t2off) then setStateRelay(relnum,0) end    
     else
      c=getTime(true)
      if c == gd(r.t2on) then setStateRelay(relnum,1) end
      if c == gd(r.t2off) then setStateRelay(relnum,0) end    
     end 
    end  

    if r.t3a=='1' then
     if r.t3ed=='1' then
      c=getTime(false)
      if c == gt(r.t3on) then setStateRelay(relnum,1) end
      if c == gt(r.t3off) then setStateRelay(relnum,0) end    
     else
      c=getTime(true)
      if c == gd(r.t3on) then setStateRelay(relnum,1) end
      if c == gd(r.t3off) then setStateRelay(relnum,0) end    
     end 
    end   

    if r.t4a=='1' then
     if r.t4ed=='1' then
      c=getTime(false)
      if c == gt(r.t4on) then setStateRelay(relnum,1) end
      if c == gt(r.t4off) then setStateRelay(relnum,0) end    
     else
      c=getTime(true)
      if c == gd(r.t4on) then setStateRelay(relnum,1) end
      if c == gd(r.t4off) then setStateRelay(relnum,0) end    
     end 
    end   

    if r.t5a=='1' then
     if r.t5ed=='1' then
      c=getTime(false)
      if c == gt(r.t5on) then setStateRelay(relnum,1) end
      if c == gt(r.t5off) then setStateRelay(relnum,0) end    
     else
      c=getTime(true)
      if c == gd(r.t5on) then setStateRelay(relnum,1) end
      if c == gd(r.t5off) then setStateRelay(relnum,0) end    
     end 
    end   


  end

d_destroy()  
d_destroy=nil 
end
