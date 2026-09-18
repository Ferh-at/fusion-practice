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

-- Functionality

--* Components can hold their own data privately using state objects.

local HOVER_COLOUR = Color3.new(0.5, 0.75, 1)
local REST_COLOUR = Color3.new(0.25, 0.5, 1)

local function Button(
	scope: FusionScope,
	props: {
		Text: UsedAs<string>,
	}
)
	local state: Fusion.Value<boolean> = scope:Value(false) -- destroyed alongside the rest of the component

	return scope:New("TextButton")({
		BackgroundColor3 = scope:Computed(function(use): Color3
			return if use(state) then HOVER_COLOUR else REST_COLOUR
		end),
	})
end

--! Golden Rule: The parent decides what is true, and the child only displays it and reports what the user did.

--[[

Do not hide program state inside of a component. 

"Is sound enabled? Is this quest selected?" kinds of questions may need to be answered by other code. 

UI should show the setting. Not own it.

]]

-- Approach 1 - Checkbox OWNS the value (PROBLEMATIC)

local function CheckBox(
	scope: FusionScope,
	props: {
		-- some properties here
	}
): Instance
	local IsChecked = scope:Value(false)

	return scope:New("ImageButton")({
		Enabled = IsChecked,

		[OnEvent("Activated")] = function()
			IsChecked:set(not peek(IsChecked))
		end,
	})
end



-- Approach 2 - Pass a Value in. Slightly better.

local function CheckBox(
    scope: FusionScope,
    props: {
        IsChecked: Fusion.Value<boolean>
    }
)
    return scope:New "ImageButton" {
        [OnEvent "Activated"] = function()
            props.IsChecked:set(not peek(props.IsChecked))
        end
    }
end


-- Now, the parent owns the bool.
local PlayMusic = scoped(Fusion):Value(true)
CheckBox(scoped(Fusion), {IsChecked = PlayMusic})

--! Limit A:
--[[
    *The parent is forced to write to a Value object. Sometimes, we derive it through a Computed obj. 

    *Click behaviour is hard-coded. You cannot: confirm before toggling, toggle three values at once, open a menu instead of toggling. 

    ! Approach 3 fixes this.

]]


-- Approach 3 --> UsedAs (READ-ONLY OBJECT) and a callback function.


local function CheckBox(
    scope: FusionScope,
    props: {
        IsChecked: UsedAs<boolean>, -- a plain bool, or a state object which holds a bool. 
        OnClick: () -> () -- something happened!
    }
): Instance   
    return scope:New "ImageButton" {
        [OnEvent "Activated"] = function()
            props.OnClick()
        end
        -- appearance uses props.IsChecked, never writes to it.
    }
end


CheckBox(scoped(Fusion), {
    IsChecked = PlayMusic,
    OnClick = function()
        
    end
})



-- Why this is more flexible.

local myScope = scoped(Fusion)

local playMusic = myScope:Value(true)
local playSFX = myScope:Value(false)
local playNarration = myScope:Value(true)

-- master checkbox --> uncheck if all 3 off, checked if all are on.



local IsChecked = myScope:Computed(function(use): string
    local AnyChecked = use(playMusic) or use(playSFX) or use(playNarration)
    local NoneChecked = not (use(playMusic) and use(playSFX) and use(playNarration))

    if not AnyChecked then
        return "Unchecked"
    elseif not NoneChecked then
        return "Partially Checked"
    else
        return "Checked"
    end

end)