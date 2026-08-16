--!nolint LocalUnused
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
║   Last updated: 31/07/2026                                 ║
╚════════════════════════════════════════════════════════════╝
]]

--* Imports
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local scoped = Fusion.scoped

-- Functionality

--* This file contains the Improved Syntax for Scoping

local myScope = Fusion.scoped() -- scoped() can re-use old arrays.

local _thing1 = Fusion.Value(myScope, "1")
local _thing2 = Fusion.Value(myScope, "2")
local _thing3 = Fusion.Value(myScope, "3")

Fusion.doCleanup(myScope)

--* You can also pass a table of functions into scoped.

local newScope = Fusion.scoped({
	Value = Fusion.Value,
	doCleanup = Fusion.doCleanup,
})

local _thing1 = newScope:Value("thing 1 value")
local _thing2 = newScope:Value("thing 2 value")
local _thing3 = newScope:Value("thing 3 value")

newScope:doCleanup()

--*Adding methods in Bulk.

local aMoreNewScope = Fusion.scoped(Fusion) -- passes in all funcs of Fusion

local _extraNewThing = aMoreNewScope:Value("Hey")

--* Additionally --> you are permitted to mix in other functions.

local _coolScope =
	Fusion.scoped(Fusion, { -- ensure that there are no conflicting names or scoped() will error.
		Foo = ...,
		Bar = ...,
	})

--* Inheritance (similar to Python OOP) done via deriveScope.
local function testFunc()
	print("ok")
end

local myScope1 = scoped(Fusion, {
	Foo = testFunc,
	Bar = testFunc,
	Baz = testFunc,
})

-- Instead of repeating the process of defining methods, you can just

local myScopeDerived = myScope1:deriveScope()

-- access to regular Fusion and also additional funcs. e.g:
myScopeDerived:doCleanup()
-- print(myScope1.Foo == myScopeDerived.Foo)

--* Inner Scopes

-- Used for when you want things to get destroyed at different times.

--! When the original scope is cleaned up, the 'inner scope' is cleaned up too
--! You can still call doCleanup() to clean the inner scope up early

-- Inner scopes are often the safest choice for creating new scopes.
-- They let you call doCleanup whenever you like, but guarantee that they won't stick around beyond the rest of the code they're in.

-- Example of Inner Scopes.

local UIScope = scoped(Fusion)

-- Make the UI.
local dropdownOpened = nil
local dropdownClosed = nil

--table.insert(
--UIScope,
--dropdownOpened:Connect(function(): ()
--local dropdownScope = UIScope:innerScope()

--table.insert(
--dropdownScope,
--dropdownClosed:Connect(function(): ()
--dropdownScope:doCleanup()
--end)
--)
--end)
--)

-- The dropdown scope is guaranteed to be cleaned up if the UI it came from is cleaned up. This strictly limits how long the dropdown can exist for.
