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
local Safe = Fusion.Safe


-- Functionality


--* Two types of errors: fatal and non-fatal. Fatal: crash your program. Non-fatal - handled by fusion, program continues. 

-- for example, error() will halt code execution within that script. 

-- State objects always run code in a safe environment, to ensure an error doesn't leave your state objects in a broken configuration. 


print("before")
print("before")
print("before")
print("before")

local scope = scoped(Fusion)

scope:Computed(function()
    error("Kaboom!")
end)

print("after")
print("after")



-- Functions like pcall and xpcall but makes code clunky.


-- Hence, Fusion introduces Safe expressions. Allow you to attempt a calculation, fallback to another calculation if it fails. 


Safe({
    try = function()
        return -- a value that MIGHT error during calculation
    end,
    fallback = function(theError)
        return -- a fallback value if an error does occur. 
    end
})


-- * Do not forget that Safe is only for fatal errors - ones which causes a crash in the program.

local number = scope:Value(3)
local double = scope:Computed(function(use)
    return Safe {
        try = function()
            local number = use(number)
            assert(number ~= 3, "I don't like the number 3") -- checks 
            return number * 2
        end,
        fallback = function()
            return "Failed, error."
        end
    }
end)

print(peek(double))






-- * Do not forget that Safe is only for fatal errors - ones which causes a crash in the program.