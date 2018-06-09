local reactor1 = peripheral.wrap("BigReactors-Reactor_0")
local reactor2 = peripheral.wrap("BigReactors-Reactor_1")
local high = 500000
local low = 100000

while true do
  if reactor1.getEnergyStored() <= low then
    reactor1.setActive(true)
  end
  
  if reactor2.getEnergyStored() <= low then
    reactor2.setActive(true)
  end
  
  if reactor1.getEnergyStored() >= high then
    reactor1.setActive(false)
  end
  
  if reactor2.getEnergyStored() >= high then
    reactor2.setActive(false)
  end

  sleep(5)
end 
