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

-- Functionality
local plr = game["Players"].LocalPlayer
local PlayerGui = plr.PlayerGui

local scope = scoped(Fusion)

local Message = scope:Value("Hello!")
local State = scope:Value(true)

local UI = scope:New("TextLabel")({
	Name = "Greeting Text Label",
	Parent = PlayerGui:WaitForChild("ScreenGui"),
	Text = Message,
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromScale(0.1, 0.1),
	Visible = State,
})

task.wait(5)
print("Turning off....")
State:set(false)
task.wait(3)
print("turnign back on...")
State:set(true)
