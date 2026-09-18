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
║   Last updated: 18/09/2026                                 ║
╚════════════════════════════════════════════════════════════╝
]]


-- Imports
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Fusion = require(ReplicatedStorage.Packages.Fusion)

local scoped = Fusion.scoped
local Children = Fusion.Children
local peek = Fusion.peek

local OnEvent = Fusion.OnEvent

type UsedAs<T> = Fusion.UsedAs<T>
type FusionScope = Fusion.Scope<typeof(Fusion)>

local Contextual = Fusion.Contextual


-- Functionality


--* Typically, values are shared via modules. 


local Theme = {}

Theme.Colors = {
    Background = Color3.fromHex("FFFFFF"),
    Text = Color3.fromHex("FFFFFF")
}



--[[
* Globals hold one value for all CODE.

* Contextuals aim to provide a fix for this, values can be temporarily changed for the duration of a code block.


]]
local MyContextual = Contextual("Foo")

print(MyContextual:now())

-- You can override for a limited span of time using :is(temp value):during(callback)

MyContextual:is("Bar"):during(function()
    print(MyContextual:now())
end)

print(MyContextual:now())


--! Decision rule for contextuals: you need a different answer per script, without utilising prop-drilling. 