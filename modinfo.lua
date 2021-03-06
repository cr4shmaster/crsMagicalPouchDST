-- https://sites.google.com/view/cr4shmaster/magical-pouch-ds-dst

name = "Magical Pouch v2.4"
description = "Shrinks items to fit in your pocket!"
author = "cr4shmaster"
version = "2.4.2"
forumthread = ""
api_version = 10
all_clients_require_mod = true
client_only_mod = false
dst_compatible = true
icon_atlas = "modicon.xml"
icon = "modicon.tex"
server_filter_tags = {"magical", "pouch", "portable", "container"}
priority = 50

local function crsSetTab(k)
    local name = {"Tools", "Survival", "Farm", "Science", "Structures", "Refine", "Magic"}
    return {description = ""..name[k].."", data = k}
end

local function crsSetTech(k)
    local name = {"None", "Science Machine", "Alchemy Engine", "Prestihatitator", "Shadow Manip.", "Broken APS", "Repaired APS"}
    return {description = ""..name[k].."", data = k}
end

local function crsSetSize(k)
    local slots = {4, 9, 16, 25, 100}
    return {description = ""..slots[k].." slots", data = k}
end

local function crsSetCount(k)
    return {description = ""..k.."", data = k}
end

local function crsSetSpoilage(k)
    local desc = {"Default", "25% longer", "50% longer", "75% longer", "None"}
    local val = {.5, .37, .25, .12, .001}
    return {description = ""..desc[k].."", data = val[k]}
end

local crsTab = {} for k=1,7,1 do crsTab[k] = crsSetTab(k) end
local crsTech = {} for k=1,7,1 do crsTech[k] = crsSetTech(k) end
local crsSize = {} for k=1,5,1 do crsSize[k] = crsSetSize(k) end
local crsIngredient = {} for k=1,20,1 do crsIngredient[k] = crsSetCount(k) end
local crsCount = {} for k=1,11,1 do crsCount[k] = crsSetCount(k-6) end
local crsToggle = {{description = "Enabled", data = true}, {description = "Disabled", data = false}}
local crsRadius = crsIngredient
local crsInterval = {} for k=1,10,1 do crsInterval[k] = crsSetCount(k/10) end
local crsChance = {} for k=1,10,1 do crsChance[k] = crsSetCount(k) end
local crsPosition = {} for k=1,41,1 do crsPosition[k] = crsSetCount(k*25-525) end
local crsSpoilage = {} for k=1,5,1 do crsSpoilage[k] = crsSetSpoilage(k) end

configuration_options = {
    {name = "cfgRecipeTab", label = "Recipe Tab", options = crsTab, default = 1, hover = "The crafting tab on which the recipe is found."},
    {name = "cfgRecipeTech", label = "Recipe Tech", options = crsTech, default = 5, hover = "The research building required to see/craft the recipe."},
    {name = "cfgMPSize", label = "MP Size", options = crsSize, default = 2, hover = "The size of the Magical Pouch."},
    {name = "cfgMPRope", label = "MP Rope", options = crsIngredient, default = 1, hover = "The amount of Rope required to craft the Magical Pouch."},
    {name = "cfgMPWeb", label = "MP Spider Web", options = crsIngredient, default = 15, hover = "The amount of Web required to craft the Magical Pouch."},
    {name = "cfgMPGems", label = "MP Purple Gem", options = crsIngredient, default = 5, hover = "The amount of Purple Gems required to craft the Magical Pouch."},
    {name = "cfgIMPRecipeToggle", label = "Toggle IMP", options = crsToggle, default = true, hover = "Enable/disable the Icy Magical Pouch"},
    {name = "cfgIMPSize", label = "IMP Size", options = crsSize, default = 1, hover = "The size of the Icy Magical Pouch."},
    {name = "cfgIMPPerishMult", label = "IMP Spoilage", options = crsSpoilage, default = .5, hover = "The rate at which food spils in the Icy Magical Pouch."},
    {name = "cfgIMPRope", label = "IMP Rope", options = crsIngredient, default = 1, hover = "The amount of Rope required to craft the Icy Magical Pouch."},
    {name = "cfgIMPWeb", label = "IMP Spider Web", options = crsIngredient, default = 15, hover = "The amount of Web required to craft the Icy Magical Pouch."},
    {name = "cfgIMPGems", label = "IMP Blue Gem", options = crsIngredient, default = 10, hover = "The amount of Blue Gems required to craft the Icy Magical Pouch."},
    {name = "cfgAutoCollectToggle", label = "Enable Auto-Collect", options = crsToggle, default = false, hover = "Enable/disable the auto-collect feature for all pouches."},
    {name = "cfgAutoCollectInterval", label = "Collect Interval", options = crsInterval, default = .3, hover = "The interval in seconds at which the pouches collect loot."},
    {name = "cfgXPos", label = "UI Horizontal Position", options = crsPosition, default = 0, hover = "The horizontal position of the pouch window."},
    {name = "cfgYPos", label = "UI Vertical Position", options = crsPosition, default = 100, hover = "The vertical position of the pouch window."},
    {name = "cfgMPCeption", label = "MP-ception", options = crsToggle, default = false, hover = "Enable/disable the ability to put pouches inside other pouches. May cause crashes if enabled."},
    {name = "cfgIMPCeption", label = "IMP-ception", options = crsToggle, default = false, hover = "Enable/disable the ability to put pouches inside other pouches. May cause crashes if enabled."},
    {name = "cfgTestCheck", label = "Installed", options = {{description = "Yes", data = true}}, default = true}
}