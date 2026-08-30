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

-- ForPairs is able to process both keys and values at the same time.
-- Supports both constants and state objects.

local scope = scoped(Fusion)

local itemColors = { Shoe = "Blue", Pants = "Red" }

local swapped = scope:ForPairs(itemColors, function(use, scope, key, val)
	return val, key
end)

print(peek(swapped))

-- Similar to computed objs, you can use() prefix for output to change when input table changes.

local foodTypes = { Pasta = "Delicious", Cabbage = "Unpleasant" }
local state = scope:Value(true)

local inverter = scope:ForPairs(foodTypes, function(use, scope, key, val)
	if use(state) then
		return val, key
	else
		return key, val
	end
end)

print(peek(inverter)) -- inverts

state:set(false)
print(peek(inverter))

-- Anything added to the scope is cleaned up when the processed key or the procesed value is removed.

local itemColors = scope:Value({ Shoes = "Red", Pants = "Blue" })
local swapped = scope:ForPairs(itemColors, function(use, scope, key, val)
	table.insert(scope, function()
		print("Taking off.... " .. key .. " " .. val)
	end)
	return val, key
end)
print("---------------------------------")

print(peek(swapped))
itemColors:set({ Shoes = "Red", Pants = "Crimson" })
print(peek(swapped))
