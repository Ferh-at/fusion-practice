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
║   Last updated: 03/08/2026                                 ║
╚════════════════════════════════════════════════════════════╝
]]

--* Imports
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local Scoped = Fusion.scoped
local Peek = Fusion.peek

-- Functionality

-- Computeds are state objects which immediately process values from other state objs.

local scope = Scoped(Fusion)

local ExampleComputed = scope:Computed(function(_, _): number
	return 1 + 1
end)

-- The value the callback returns is stored as the computed's value. You are able to peek it.
print(Peek(ExampleComputed)) -- prints 2

--! With computeds, the calculation MUST be immediate. It must not delay at all - for example, waiting for server to respond to a request.

-- Calculations are run only once by default.

local Number = scope:Value(5)

local DoubleTheNumber = scope:Computed(function(_, _): number
	return Peek(Number) * 2
end)

print(Peek(DoubleTheNumber)) -- Outputs 10 as expected.

-- If we alter the number, and re run the calculation.
Number:set(10)
print(Peek(DoubleTheNumber)) -- Will output 10, not 20.

-- To fix this, computed objs provide a use function as a first argument. As logic runs, you can call this function with different state objects.
-- If any values which are used changes, it recalculates from scratch.

-- Hence, it should be.

local DoubleTheNumber = scope:Computed(function(use, _)
	use(Number) -- the calculation will re-run when Number changes value.
	return Peek(Number) * 2
end)

print(Peek(DoubleTheNumber)) -- Will output 20 as expected.

-- use() acts like peek(). So, for conciseness:

local DoubleTheNumber = scope:Computed(function(use, _)
	return use(Number) * 2
end)

print(Peek(DoubleTheNumber))

--! Fusion sometimes applies optimisations. Recalculations might be postponed or cancelled if the value of Computed isn't being used.

--* Computeds w/ Inner Scopes

-- the callback function in computeds also have a second argument for a brand new scope. The purpose of it is: automatically cleaned up when the computed object recalculates.
print("---------------------------------------------------------------------------")
local coolScope = Scoped(Fusion)
local Number = coolScope:Value(10)

local DoubleTheNumber = coolScope:Computed(function(use, ANewScope): number
	local CurrentNumber = use(Number)
	print("Making...", CurrentNumber)

	-- Cleanup code
	table.insert(ANewScope, function()
		print("Destroying", CurrentNumber)
	end)
	return CurrentNumber * 2
end)

print("Doubling the number...", Peek(DoubleTheNumber))

Number:set(20)
print("We are doubling again, booyah", Peek(DoubleTheNumber))

-- Better practice is to give the parameter the same name as the original scope. Prevents you from accidentally using the original scope.

print("---------------------------------------------------------------------------")

local EvenCoolerScope = Scoped(Fusion)
local Number = EvenCoolerScope:Value(10)

local DoubleTheNumber = EvenCoolerScope:Computed(function(use, EvenCoolerScope): number
	local CurrentNumber = use(Number)
	print("Making...", CurrentNumber)

	-- perform cleanup code
	table.insert(EvenCoolerScope, function()
		print("Destroying...", CurrentNumber)
	end)
	return CurrentNumber * 2
end)

print("Initial double:", Peek(DoubleTheNumber))

print("We are now going to change the number to:", Number:set(30))
print("Now, peeking into our computed..", Peek(DoubleTheNumber))
