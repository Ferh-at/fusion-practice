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
local Scoped = Fusion.scoped
local Peek = Fusion.peek

-- Functionality

-- Observers are used to detect changes with state objects.
--* connect code to run using :onChange() or :onBind()

local TestScope = Scoped(Fusion)
local Health = TestScope:Value(100)
local obs = TestScope:Observer(Health) -- what you want obs to watch

obs:onChange(function()
	print("Health has changed to:", Peek(Health))
end)

--task.spawn(function()
--task.wait(3)
-- Health:set(30)
--end)

-- Additionally, the obs:onChange() method returns a disconnect function if you want to disc. early. Whenever an observer object is destroyed, the connection also is destroyed.

local SecondScope = Scoped(Fusion)
local Stamina = SecondScope:Value(10)
local NewObs = SecondScope:Observer(Stamina)

local disconnect = NewObs:onChange(function()
	print("Stamina has changed to:", Peek(Stamina))
end)

Stamina:set(9)
task.wait(2)
disconnect()
Stamina:set(6) -- Will not output anything

-- Moreover, Obs objs also have a :onBind() method - runs on initial bind, and also acts as :onChange(). Good for when u want it to run ASAP.

local discFunction = NewObs:onBind(function()
	-- bla bla bla
end)

discFunction()

-- If objects are changed to the SAME value, updates are NOT broadcasted.
