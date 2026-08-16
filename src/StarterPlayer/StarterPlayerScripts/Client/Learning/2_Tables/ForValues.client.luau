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
║   Last updated: 09/08/2026                                 ║
╚════════════════════════════════════════════════════════════╝
]]

--* Imports
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Scoped = Fusion.scoped
local peek = Fusion.peek

-- Functionality
local myScope = Scoped(Fusion)
local numbers = {1,2,3,4,5,6,7,8,9,10}

-- a ForValues object takes: input table (numbers) and a processor function. The processor function has 3 args: use, scope (like computed objs) but also one of the values read from the input table. 

-- * ForValues obj supports both state objects (scope:Value()) + constants {}

local DoubleTheNumbers = myScope:ForValues(numbers, function(use, scope, val): number
    return val * 2
end)

print(peek(DoubleTheNumbers))



-- The input table can also be a state object, for example:

local newNumbers = myScope:Value({})

local DoubleTheNumbersButBetter = myScope:ForValues(newNumbers, function(use, scope, currentVal): number
    return currentVal * 2
end)

newNumbers:set({5,25,50})
print("Better", peek(DoubleTheNumbersButBetter))

-- You can also use the use() for state objects in calculation.

local factor = myScope:Value(2)

local multiplied = myScope:ForValues(newNumbers, function(use,scope,currrentVal)
    return currrentVal * use(factor)
end)

print(peek(multiplied))


factor:set(5)
print(peek(multiplied))


--! Similar to Computed objs, anything added to the scope is cleaned up for you when the processed value is removed. 

local names = myScope:Value({"Jodi", "Amber", "Umair"})

local ShoutingNames = myScope:ForValues(names, function(use, myScope, currentVal): string
    table.insert(myScope, function(): ()
        print("Goodbye, ".. currentVal .. "!")
    end)
    return string.upper(currentVal)
end)

print("--------------------------------------------------------------------")
print(peek(ShoutingNames))

names:set({"Amber", "Umair"})
print(peek(ShoutingNames))
