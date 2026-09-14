--!nolint
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
║   Last updated: 14/09/2026                                 ║
╚════════════════════════════════════════════════════════════╝
]]

-- Imports
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)

local scoped = Fusion.scoped
local Children = Fusion.Children

-- Functionality

--* At some point, you might need to refer to another part of the UI. There are various techniques that can let you do this.

--! Firstly, but the worst is by utilising Constants.

local scope = scoped(Fusion)

local selectionTarget = scope:New("Part")({
	Name = "Selection Target Part",
})

local UI = scope:New("Folder")({
	[Children] = scope:New("SelectionBox")({
		Adornee = selectionTarget,
	}),
})

--! Disadvantages: i) ui constructed in a different order. ii) inelegant and bothersome. iii) you can't have two pieces of UI refer to each other cyclically

--! Much better, use Value objects.

-- type is already clear.  selectionTarget will show as nil, until :set() method is used later on.
local selectionTarget: Fusion.Value<Part?> = scope:Value(nil)

local UI = scope:New("Folder")({
	[Children] = scope:New("SelectionBox")({
		Adornee = selectionTarget,
	}),
	selectionTarget:set(scope:New("Part")({
		Name = "Selection Target",
	})),
})



-- this allows for cyclic references. Value method is prefered. 