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
║   Last updated: 15/08/2026                                 ║
╚════════════════════════════════════════════════════════════╝
]]

-- Imports
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Fusion = require(ReplicatedStorage.Packages.Fusion)
local scoped = Fusion.scoped
local peek = Fusion.peek
--* Process of connecting scripts to pre-made UI is known as Hydration.


-- Functionality

local myScope = scoped(Fusion)

local instance = game.Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui")
local ShowUI = myScope:Value(true)

-- hydration --> first pass in instance, then pass in ur property table
local UI = myScope:Hydrate(instance){
    Enabled = ShowUI
}


print(UI.ClassName)
print(UI.Parent)

print("Turning off UI, wait 5 seconds")
ShowUI:set(false)
task.wait(5)
ShowUI:set(true)
print("Back on")