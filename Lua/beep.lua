
function mBeepPanic()
beep=false
pwm.setup(5,800,1000)
pwm.start(5)
tmr.alarm(6,150, tmr.ALARM_AUTO,function()
  if not beep then pwm.setclock(5,800) beep=true else
    pwm.setclock(5,300)
    beep=false
    end 
end)
end

function mbeep(p)
bc=p
beep=false
pwm.setup(5,1000,1000)
tmr.alarm(6,150, tmr.ALARM_AUTO,function()
  if not beep then pwm.start(5) beep=true else
    pwm.stop(5) beep=false  bc=bc-1
    end 
    if bc==0 then 
  pwm.stop(5)
  pwm.close(5)
  tmr.unregister(6) 
  bc=nil beep=nil
   end
end)
end
