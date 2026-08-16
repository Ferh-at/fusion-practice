--!nolint LocalShadow
--[[
╔════════════════════════════════════════════════════════════╗
║                                                            ║
║   ███████╗███████╗██████╗ ██╗  ██╗ █████╗ ████████╗        ║
║   ██╔════╝██╔════╝██╔══██╗██║  ██║██╔══██╗╚══██╔══╝        ║
║   █████╗  █████╗  ██████╔╝███████║███████║   ██║           ║
║   ██╔══╝  ██╔══╝  ██╔══██╗██╔══██║██╔══██║   ██║           ║
║   ██║     ███████╗██║  ██║██║  ██║██║  ██║   ██║           ║
║   ╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝           ║
║                                                            ║
║   Last updated: 11/08/2026                                 ║
╚════════════════════════════════════════════════════════════╝
]]

-- Imports
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local scoped = Fusion.scoped
local peek = Fusion.peek


-- Functionality

--* ForKeys objects support both state objects (scope:Value()) + constants ({1,2,3,4,5})


local scope = scoped(Fusion)

local data = {Red = "foo", Blue = "bar"}

local renamedKeys = scope:ForKeys(data, function(use,scope, currentVal) -- currentVal acts as key
    return string.upper(currentVal)
end)

print(peek(renamedKeys))



-- Input table can also be a state object. When the input table changes, output will also update. 

local FoodSet = scope:Value({})

local Prefixes = {pie = "Tasty", Pizza = "Delicious", Cabbage = "Not my favorite"}

local RenamedFoodSet = scope:ForKeys(FoodSet, function(use, scope, current)
    return Prefixes[current] .. current
end)


FoodSet:set({ pie = true })
print(peek(RenamedFoodSet))


FoodSet:set({Pizza = true, Cabbage = false})
print(peek(RenamedFoodSet))

-- You can also perform use() on state objects within calculations. 

-- Additionally, anything added to the scope is cleaned up when the processed key is removed.


local newFoodSet = scope:Value({broccoli = true, chocolate = true})

local ShoutingFoodSet = scope:ForKeys(newFoodSet, function(use, scope, current)
    table.insert(scope, function()
        print("I ate the ".. current)
    end)
    return string.upper(current)
end)

print("--------------------------------------------------")
print(peek(ShoutingFoodSet))
newFoodSet:set({chocolate = true})

print(peek(ShoutingFoodSet))

