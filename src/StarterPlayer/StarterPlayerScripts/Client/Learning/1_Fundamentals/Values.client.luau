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
local Scoped = Fusion.scoped
local peek = Fusion.peek
-- Functionality

local TestScope = Scoped(Fusion)
local Health = TestScope:Value(100)

print(peek(Health))

Health:set(25)
print(peek(Health))

-- set() also returns the value that you set.

print(Health:set(2 * 5))

local x = 5
