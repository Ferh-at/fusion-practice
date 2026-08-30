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
║   Last updated: 17/08/2026                                 ║
╚════════════════════════════════════════════════════════════╝
]]

-- Imports
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)

local scoped = Fusion.scoped
local peek = Fusion.peek
local Children = Fusion.Children

-- Functionality
local scope = Fusion.scoped(Fusion)

local UI = scope:New("ScreenGui")({
	Parent = game.Players.LocalPlayer.PlayerGui,
	[Children] = {
		scope:New("Folder")({
			[Children] = {
				scope:New("TextLabel")({
					Name = "FirstChild",
					Text = "Hello! I am #1",
				}),
				scope:New("TextButton")({
					Name = "Sammy",
					Text = "Bruv",
				}),
			},
		}),
	},
})

print(UI.Parent)
