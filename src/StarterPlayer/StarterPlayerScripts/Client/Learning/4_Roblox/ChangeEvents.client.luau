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
║   Last updated: 26/08/2026                                 ║
╚════════════════════════════════════════════════════════════╝
]]

-- Imports
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)

local scoped = Fusion.scoped
local OnChange = Fusion.OnChange
local OnEvent = Fusion.OnEvent

local peek = Fusion.peek
local Children = Fusion.Children

-- Functionality

local scope = scoped(Fusion)

local IsActive = scope:Value(false)

local color = scope:Computed(function(use, scope)
	return if use(IsActive) then Color3.fromRGB(0, 255, 13) else Color3.fromRGB(255, 0, 0)
end)

local UI = scope:New("ScreenGui")({
	Parent = game["Players"].LocalPlayer:WaitForChild("PlayerGui"),
	Name = "Testing",
	[Children] = {
		scope:New("TextButton")({
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromScale(0.1, 0.06),
			BackgroundColor3 = color,

			TextScaled = true,
			Text = "Click me!",

			[OnEvent("Activated")] = function()
				IsActive:set(not (peek(IsActive)))
			end,
		}),

		scope:New("TextLabel")({
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.35),
			Size = UDim2.fromScale(0.1, 0.05),

			TextScaled = true,
			Text = "Test.",
		}),
	},
})
