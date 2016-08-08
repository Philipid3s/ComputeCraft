while true do
  local reactor1 = peripheral.wrap("BigReactors-Reactor_0")
  local reactor2 = peripheral.wrap("BigReactors-Reactor_1")
  local mon = peripheral.wrap("monitor_1")

  local length = 20
    
  mon.clear()

  mon.setCursorPos(1,1)
  mon.setTextColor(colors.red)
  mon.write("[Reactor 1]")
  
  local fuelAmt1 = reactor1.getFuelAmount()
  local wastAmt1 = reactor1.getWasteAmount()
  
  local graphFuel1 = math.floor(fuelAmt1 * length / (fuelAmt1 + wastAmt1))
  local percentFuel1 = math.floor(fuelAmt1 * 100 / (fuelAmt1 + wastAmt1))
  
  -- REACTOR 1
  
  mon.setCursorPos(1,2)
  mon.setTextColor(colors.white)
  mon.write("[")
  mon.setTextColor(colors.lime)
  for i = 1, graphFuel1, 1 do
    mon.write("=")
  end
  
  mon.setTextColor(colors.red)
  for i = 1, (length - graphFuel1), 1 do
    mon.write("=")
  end
  
  mon.setTextColor(colors.white)
  mon.write("] ")
  mon.write(percentFuel1)
  mon.write("%")

  -- REACTOR 2

  mon.setCursorPos(1,4)
  mon.setTextColor(colors.red)
  mon.write("[Reactor 2]")
  mon.setCursorPos(1,5)
  mon.setTextColor(colors.white)
  mon.write("[")  

  local fuelAmt2 = reactor2.getFuelAmount()
  local wastAmt2 = reactor2.getWasteAmount()

  local graphFuel2 = math.floor(fuelAmt2 * length / (fuelAmt2 + wastAmt2))
  local percentFuel2 = math.floor(fuelAmt2 * 100 / (fuelAmt2 + wastAmt2))    

  mon.setTextColor(colors.lime)
  for i = 1, graphFuel2, 1 do
    mon.write("=")
  end
  
  mon.setTextColor(colors.red)
  for i = 1, (length - graphFuel2), 1 do
    mon.write("=")
  end
  
  mon.setTextColor(colors.white)
  mon.write("] ")
  mon.write(percentFuel2)
  mon.write("%")
  
  -- ALERTS
  if percentFuel1 < 50.0 then
    mon.setCursorPos(1,8)
    mon.setTextColor(colors.red)
    mon.write("REACTOR 1 : fuel low!")
  end
  
  if percentFuel2 < 50.0 then
    mon.setCursorPos(1,9)
    mon.setTextColor(colors.red)
    mon.write("REACTOR 2 : fuel low!")
  end
  
  sleep(10)
end    
