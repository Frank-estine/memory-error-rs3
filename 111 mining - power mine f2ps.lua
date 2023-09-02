print("Run Lua script mining copper, iron, coal, mithril, adamantite or runite @ falador west.")

local API = require("api")
ID = {
    copper = {113028,113027,113026},
    iron = {113040,113038,113039},
    coal = {113103,113102,113101},
    mithril = {113050,113051,113052},
    adamantite = {113055,113053,113054},
    runite = {113125,113127,113126},
    rune_ore = {451},
    geodes = {44816}
}
local totalOres = 0  -- Initialize totalOres to 0
local miningloop=0
local currentSessionStrings = 0  -- Initialize the variable to keep track of ores mined in the current session
local currentMiningStrings = 0  -- Initialize the variable to keep track of ores you are currently mining
local currentMiningGeodes = 0  -- Initialize the variable to keep track of geodes you are currently mining

local ore = {}
local strings, fail = 0, 0
---local copper = {113028,113027,113026}
-- Function to shuffle table

function shuffle(tbl)
    for i = #tbl, 2, -1 do
      local j = math.random(i)
      tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
  end
  
---- end IDs local

local startXp = API.GetSkillXP("MINING")
local startTime = os.time()
local player = API.GetLocalPlayerName()
local Cselect = API.ScriptDialogWindow2("Mining", {
    "Copper", "Iron", "Coal", "Mithril", "Adamantite", "Runite"
},"Start", "Close").Name;

--Assign stuff here
if "Copper" == Cselect then
    ScripCuRunning1 = "Mine copper";
    ore = ID.copper
end
if "Iron" == Cselect then
    ScripCuRunning1 = "Mine iron";
    ore = ID.iron
end
if "Coal" == Cselect then
    ScripCuRunning1 = "Mine coal";
    ore = ID.coal
end
if "Mithril" == Cselect then
    ScripCuRunning1 = "Mine mithril";
    ore = ID.mithril
end
if "Adamantite" == Cselect then
    ScripCuRunning1 = "Mine adamantite";
    ore = ID.adamantite
end
if "Runite" == Cselect then
    ScripCuRunning1 = "Mine runite";
    ore = ID.runite
end

print("Starting with:", ScripCuRunning1);

function fillorebox()
    --if API.InvItemFound2(Orebox)then--Need All OreBox's
        print("OreBox Found")
        API.DoAction_Interface(0x24,0xaef5,1,1473,5,0,5392) -- rune orebox
        API.RandomSleep2(650, 250, 250)
    --end
    -- Update the totalOres variable after depositing the ores into the ore box
    totalOres = totalOres + currentMiningStrings
end

local function mining()


    if API.Invfreecount_() > 0 and API.Read_LoopyLoop() then
    repeat
        
      if not API.IsPlayerAnimating_(player, 3) then
            API.RandomSleep2(1500, 3050, 2000)
            if not API.IsPlayerAnimating_(player, 2) then
                ore = shuffle(ore)
                API.DoAction_Object_r(0x3a, 0, {ore[1]}, 50, FFPOINT.new(0, 0, 0), 50)
            end
        end

        if math.random(0,1500) > 1000 then

        API.PIdle22() end

        while API.LocalPlayer_HoverProgress() <= 90 do
            API.RandomSleep2(1500, 3050, 2000)
            local foundSparkling = API.FindHl(0x3a, 0, ore, 50, {7165, 7164})
            if foundSparkling then
                API.RandomSleep2(2500, 3050, 12000)
            else
                API.DoAction_Object_r(0x3a, 0, ore, 50, FFPOINT.new(0, 0, 0), 50)
                API.RandomSleep2(2500, 3050, 12000)
            end
        end


            

        if API.Invfreecount_() < math.random(5,10) and API.Read_LoopyLoop() then
            repeat
                API.KeyboardPress('a', 60, 1000) 
                API.RandomSleep2(150, 500, 200)
                print(API.Invfreecount_())
            until API.Invfreecount_() > math.random(5,10) or not API.Read_LoopyLoop() or not API.PlayerLoggedIn()
        end
        if not API.Read_LoopyLoop() then break end
        

        API.RandomSleep2(2500, 3050, 12000)
    until API.Invfreecount_() == 0 or not API.Read_LoopyLoop() or not API.PlayerLoggedIn()
    end

        miningloop = miningloop + 1
    print("Mining Loop ended #" .. miningloop)
end
print( "read mining ")

-- Function to shuffle table
local function shuffle(tbl)
  for i = #tbl, 2, -1 do
    local j = math.random(i)
    tbl[i], tbl[j] = tbl[j], tbl[i]
  end
  return tbl
end
local startTime = os.time()
local idleTimeThreshold = math.random(120, 260)
local timerDuration = 60  -- Timer duration in seconds



local mainloop = 0
API.Write_LoopyLoop(true)
while(API.Read_LoopyLoop()) do

    if API.PlayerLoggedIn () then
        if API.Invfreecount_() > 0 then
            mining()
        end
    else
        print("logging in ")
        API.KeyboardPress(' ', 60, 1000)  
    end 
    local mainloop = mainloop+1
    print("Main Loop ended")

end
print ("looped amount :" .. mainloop)
