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
║   Last updated: 15/09/2026                                 ║
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

-- Functionality

--* Callbacks are functions which you pass into other functions, so your code can do something in response.

local function RepeatFiveTimes(callback: (number) -> ()) -- it needs BOTH a type and a return.
	for i = 1, 5 do
		callback(i)
	end
end

RepeatFiveTimes(function(num)
	print("The number is", num)
end)

-- Callbacks in Fusion

local function Button(
	scope: FusionScope,
	props: {
		Position: UsedAs<UDim2>,
		Size: UsedAs<UDim2>,
		Text: UsedAs<string>?,

		-- Function
		OnClick: (() -> ())?, -- takes no params, returns no params
	}
)
	return scope:New("TextButton")({
		Position = props.Position,
		Size = props.Size,
		Text = props.Text,

		[OnEvent("Activated")] = props.OnClick,
	})
end

--! Alternatively, you can call props.OnClick manually - if you want to do your own processing first.

local function Button(
	scope: FusionScope,
	props: {
		Position: UsedAs<UDim2>,
		Size: UsedAs<UDim2>,
		Text: UsedAs<string>?,
		Disabled: UsedAs<boolean>?,

		-- Function
		OnClick: (() -> ())?, -- takes no params, returns no params
	}
)
	return scope:New("TextButton")({
		Position = props.Position,
		Size = props.Size,
		Text = props.Text,
		Enabled = props.Disabled,

		[OnEvent("Activated")] = function(): ()
			print("Checking status...")
			if props.OnClick ~= nil and not peek(props.Disabled) then
				props.OnClick() -- call the func
			end
		end,
	})
end

--* Children callbacks

-- This is for building inner UI. The component builds the UI on demand, whilst also giving more control over it's features.

local function Dialog(
	scope: FusionScope,
	props: {
		Render: (FusionScope) -> Instance,
	}
): Instance
	local inner = scope:innerScope()
	local kids = props.Render(inner)

    return scope:New "Frame" {
        [Children] = kids
    }
end

local myScope = scoped(Fusion, {Dialog = Dialog})

myScope:Dialog({
    Render = function(scope): {Instance}
        return scope:New "TextLabel" {
            Text = "placeholder"
        }
    end
})
