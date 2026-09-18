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
║   Last updated: 18/09/2026                                 ║
╚════════════════════════════════════════════════════════════╝
]]

-- Imports
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)

local scoped = Fusion.scoped
local Children = Fusion.Children
local peek = Fusion.peek

local OnEvent = Fusion.OnEvent

type UsedAs<T> = Fusion.UsedAs<T>
type FusionScope = Fusion.Scope<typeof(Fusion)>

local Contextual = Fusion.Contextual
local Safe = Fusion.Safe



-- Functionality

--[[
When your computations return values that aren't meaningfully different, Fusion doesn't bother to perform further updates.

However, Fusion can't automatically do this for tables. So, you should freeze every table you create, unless you need to change what's inside the table later (for example, if it's a list that changes over time).
]]--

local scope = scoped(Fusion)

local number = scope:Value(1)
local isEven = scope:Computed(function(use)
    return use(number) % 2 == 0
end)
scope:Observer(isEven):onChange(function()
    print("-> isEven has changed to " .. peek(isEven))
end)

print("Number becomes 2")
number:set(2)
print("Number becomes 3")
number:set(3)
print("Number becomes 13")
number:set(13)
print("Number becomes 14")
number:set(14)
print("Number becomes 24")
number:set(24)


--! Observer only runs when there is a notable change in return.