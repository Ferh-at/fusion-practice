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

local Children = Fusion.Children

-- Functionality
--* Components allow for reusable code + to save time. Additionally, I think they may be used to make set styles.

type UsedAs<T> = Fusion.UsedAs<T>

local function Btn(
	scope: Fusion.Scope,
	props: {
		--Mand
		ButtonText: UsedAs<string>,
		ChildUICornerRadius: UsedAs<UDim>,
		Parent: Instance,

		--Opt
		Position: UsedAs<UDim2>?,
		Size: UsedAs<UDim2>?,
	}
): ...any
	return scope:New("TextButton")({
		Parent = props.Parent,
		Text = props.ButtonText,
		Size = props.Size,
		Position = props.Position,

		[Children] = scope:New("UICorner")({ CornerRadius = props.ChildUICornerRadius }),
	})
end

local myScope = Fusion.scoped(Fusion)

local HelloButton = Btn(myScope, {
	Parent = game["Players"].LocalPlayer.PlayerGui:WaitForChild("ScreenGui"),
	ButtonText = "Hello",
	ChildUICornerRadius = UDim.new(0.1),
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromScale(0.2, 0.2),
})

print("Done!")

-- Or, you can just add it to the scope as follows:

local newScope = Fusion.scoped(Fusion, { Button = Btn })

newScope:Button({
	ButtonText = "Hello!!!!!",
	ChildUICornerRadius = UDim.new(0.2),
	Parent = game["Players"].LocalPlayer.PlayerGui:WaitForChild("ScreenGui"),
	Position = UDim2.fromScale(0.2, 0.2),
	Size = UDim2.fromScale(0.2, 0.2),
})


--! Be mindful of angle brackets
--[[

-- A Vector3, or a state object storing Vector3, or nil.
UsedAs<Vector3>?

-- A Vector3?, or a state object storing Vector3?
UsedAs<Vector3?>


The first type is best for optional properties, where you provide a default value if it isn't specified by the user. If the user does specify it, they're forced to always give a valid value for it.

The second type is best if the property understands nil as a valid value. This means the user can set it to nil at any time.

]]
