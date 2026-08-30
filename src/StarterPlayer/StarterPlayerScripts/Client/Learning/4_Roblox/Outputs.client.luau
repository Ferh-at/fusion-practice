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
║   Last updated: 27/08/2026                                 ║
╚════════════════════════════════════════════════════════════╝
]]

-- Imports
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)

local scoped = Fusion.scoped
local peek = Fusion.peek

local Out = Fusion.Out

-- Functionality

--! The "Out" keys let you output a property's value to a Value object.

local scope = scoped(Fusion)

local PartName = scope:Value("")
local thing = scope:New("Part")({
	[Out("Name")] = PartName,
})

print(peek(PartName)) -- outputs Part.

thing.Name = "Jimmy"
task.wait()
print(peek(PartName)) -- Jimmy.

print("-----------------------------------------------------------------------------------------")

-- Two way bindings --> By default, Out

local name = scope:Value("")

local frame = scope:New("Frame")({
	Name = name,
	[Out("Name")] = name,
})

print(peek(name), frame.Name)
name:set("Testing!")
task.wait()
print(peek(name), frame.Name)
