print("Run Lua script 111 CHaos altar.")

local API = require("api")

local player = API.GetLocalPlayerName()


--- enter your bone id here --------------------------
local bones = 526

local function bank()
   
    API.DoAction_NPC(0x5,3408,{1786},50)

    API.RandomSleep2(1200,1500,2500)
 
    repeat 
        API.RandomSleep2(2500, 1050, 1500)  
    until  not API.IsPlayerMoving_(player)  or not API.Read_LoopyLoop()
    
    if  API.BankOpen2() then
        API.KeyboardPress('2', 60, 100)
        API.RandomSleep2(1000, 2000)
    end

    repeat until API.BankClose()
end

local function offer()
   
    API.DoAction_Object_r(0x29,80,{122374},50,WPOINT.new(0,0,0),5)
    API.RandomSleep2(1200,1500,2500)
    API.WaitUntilMovingEnds()
  
    repeat
        API.RandomSleep2(3200,1500,2500)
        if math.random(0,1500) > 800 then
            API.PIdle2()
        end
    until API.Invfreecount_() == 28 or not API.Read_LoopyLoop()

end

local loopc=0
--Exported function list is in API
--main loop
API.Write_LoopyLoop(true)
while(API.Read_LoopyLoop())
do-----------------------------------------------------------------------------------
if API.PlayerLoggedIn then
    if math.random(0,1500) > 800 then
        API.PIdle2()
    end

    if API.Invfreecount_() == 28 then
    bank()
    
    if API.Invfreecount_() == 28 then API.Write_LoopyLoop(false) break end
    end
    if API.Invfreecount_() <= 27 then
        offer()
        end
    print( "looped amount :"..loopc)
    loopc=loopc+1
end

end----------------------------------------------------------------------------------
