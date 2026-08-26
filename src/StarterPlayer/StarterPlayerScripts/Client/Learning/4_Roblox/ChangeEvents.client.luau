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
║   Last updated: 18/08/2026                                 ║
╚════════════════════════════════════════════════════════════╝
]]

-- Imports
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)

local scoped = Fusion.scoped
local OnChange = Fusion.OnChange
local OnEvent = Fusion.OnEvent
local Children = Fusion.Children

-- Functionality
local scope = scoped(Fusion)

local msg = scope:Value("")
local bgColor = scope:Computed(function(use, scope): Color3
	return (if use(msg) == "" then Color3.fromRGB(108, 169, 54) else Color3.fromRGB(113, 59, 59))
end)

local UI = scope:New("ScreenGui")({
	Name = "Testing",
	Parent = game.Players.LocalPlayer.PlayerGui,

	[Children] = {
		scope:New("TextButton")({
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(0.2, 0.1),
			Text = "Click me!",

			[OnEvent("Activated")] = function()
				msg:set("This button is pressed. Please wait!")
			end,
		}),

		scope:New("TextLabel")({
			Position = UDim2.fromScale(0.5, 0.4),
			Size = UDim2.fromScale(0.2, 0.1),
			Text = msg,

			BackgroundColor3 = bgColor,
		}),
	},
})
