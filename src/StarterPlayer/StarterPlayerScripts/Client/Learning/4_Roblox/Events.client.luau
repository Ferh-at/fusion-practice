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
║   Last updated: 17/08/2026                                 ║
╚════════════════════════════════════════════════════════════╝
]]

-- Imports
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local scoped = Fusion.scoped
local peek = Fusion.peek

local Children = Fusion.Children
local OnEvent  = Fusion.OnEvent


-- Functionality

--* when you call OnEvent with an event name, it will return a special key. 
task.wait(5)
local scope = scoped(Fusion)

local button = scope:New "TextButton" {
    Parent = game.Players.LocalPlayer.PlayerGui:FindFirstChild("ScreenGui"),
    [OnEvent("Activated")] = function(inputObj, numClicks)
        print(numClicks)
    end,
    Size = UDim2.fromScale(.2, .2),
    Position = UDim2.fromScale(.5, .5),
    TextScaled = true,
    Text = "Click"
}