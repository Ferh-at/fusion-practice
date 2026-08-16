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

local scope = {}
--local thing = Fusion.Value(scope, "I am a test variable")

--print(scope[1]) -- function: 0x123456789abcdef

-- You can add as many objects to a scope.

--local thing1 = Fusion.Value(scope, "Test1")
--local thing2 = Fusion.Value(scope, "Test2")

-- Then, to perform a cleanup (any fnctions, event connections, instances, other nested objects) -->

Fusion.doCleanup(scope)
-- Using `doCleanup` is conceptually the same as:
--! CONTENTS ARE IN REVERSE ORDER.
-- thing3:destroy()
-- thing2:destroy()
-- thing1:destroy()
