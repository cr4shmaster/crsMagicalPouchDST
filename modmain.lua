PrefabFiles = {
    "magicpouch",
    "icepouch",
    "utilpouch",
}

local crsPouches = {
    "MP",
    "IMP",
    "UMP",
}

Assets = {
    Asset("ATLAS", "images/inventoryimages/magicpouch.xml"),
    Asset("IMAGE", "images/inventoryimages/magicpouch.tex"),
    Asset("ATLAS", "minimap/magicpouch.xml" ),
    Asset("IMAGE", "minimap/magicpouch.tex" ),
    Asset("ATLAS", "images/inventoryimages/icepouch.xml"),
    Asset("IMAGE", "images/inventoryimages/icepouch.tex"),
    Asset("ATLAS", "minimap/icepouch.xml" ),
    Asset("IMAGE", "minimap/icepouch.tex" ),
    Asset("ATLAS", "images/inventoryimages/utilpouch.xml"),
    Asset("IMAGE", "images/inventoryimages/utilpouch.tex"),
    Asset("ATLAS", "minimap/utilpouch.xml" ),
    Asset("IMAGE", "minimap/utilpouch.tex" ),
}

_G = GLOBAL
STRINGS = _G.STRINGS
RECIPETABS = _G.RECIPETABS
Recipe = _G.Recipe
Ingredient = _G.Ingredient
TECH = _G.TECH
Vector3 = _G.Vector3
getConfig = GetModConfigData
containers = _G.require "containers"

-- MAP ICONS --

AddMinimapAtlas("minimap/magicpouch.xml")
AddMinimapAtlas("minimap/icepouch.xml")
AddMinimapAtlas("minimap/utilpouch.xml")

-- STRINGS --

STRINGS.NAMES.MAGICPOUCH = "Magical Pouch"
STRINGS.RECIPE_DESC.MAGICPOUCH = "Shrinks items to fit in your pocket!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MAGICPOUCH = "Shrinks items to fit in your pocket!"
STRINGS.NAMES.ICEPOUCH = "Icy Magical Pouch"
STRINGS.RECIPE_DESC.ICEPOUCH = "A Magical Pouch that can keep food fresh forever!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ICEPOUCH = "A Magical Pouch that can keep food fresh forever!"
STRINGS.NAMES.UTILPOUCH = "Utility Magical Pouch"
STRINGS.RECIPE_DESC.UTILPOUCH = "A Magical Pouch that can store tools, instruments and weapons!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.UTILPOUCH = "A Magical Pouch that can store tools, instruments and weapons!"

-- RECIPES --

local isIMPEnabled = getConfig("cfgIMPRecipeToggle")
local isUMPEnabled = getConfig("cfgUMPRecipeToggle")

local crsRecipeTabs = {
    RECIPETABS.TOOLS,
    RECIPETABS.SURVIVAL,
    RECIPETABS.FARM,
    RECIPETABS.SCIENCE,
    RECIPETABS.TOWN,
    RECIPETABS.REFINE,
    RECIPETABS.MAGIC,
    RECIPETABS.ANCIENT,
}
local recipeTab = crsRecipeTabs[getConfig("cfgRecipeTab")]

local crsRecipeTechs = {
    TECH.NONE,
    TECH.SCIENCE_ONE, -- Science Machine
    TECH.SCIENCE_TWO, -- Alchemy Engine
    TECH.MAGIC_TWO, -- Prestihatitator
    TECH.MAGIC_THREE, -- Shadow Manipulator
    TECH.ANCIENT_TWO, -- Broken APS
    TECH.ANCIENT_FOUR, -- Repaired APS
    TECH.OBSIDIAN_TWO, -- Obsidian Workbench
}
local recipeTech = crsRecipeTechs[getConfig("cfgRecipeTech")]

-- Magical Pouch --
local magicpouch = Recipe("magicpouch", {
    Ingredient("rope", getConfig("cfgMPRope")),
    Ingredient("silk", getConfig("cfgMPWeb")),
    Ingredient("purplegem", getConfig("cfgMPGems")),
}, recipeTab, recipeTech)
magicpouch.atlas = "images/inventoryimages/magicpouch.xml"
-- Icy Magical Pouch --
if isIMPEnabled then
    local icepouch = Recipe("icepouch", {
        Ingredient("rope", getConfig("cfgIMPRope")),
        Ingredient("silk", getConfig("cfgIMPWeb")),
        Ingredient("bluegem", getConfig("cfgIMPGems")),
    }, recipeTab, recipeTech)
    icepouch.atlas = "images/inventoryimages/icepouch.xml"
end
-- Utility Magical Pouch --
if isUMPEnabled then
    local utilpouch = Recipe("utilpouch", {
        Ingredient("rope", getConfig("cfgUMPRope")),
        Ingredient("silk", getConfig("cfgUMPWeb")),
        Ingredient("livinglog", getConfig("cfgUMPLogs")),
    }, recipeTab, recipeTech)
    utilpouch.atlas = "images/inventoryimages/utilpouch.xml"
end

-- CONTAINER --

local params = {}

local crsPouchDetails = {
    {id = 1, name = "pouchsmall", xy = 2, offset = 40, buttonx = 0, buttony = -100},
    {id = 2, name = "pouchmedium", xy = 3, offset = 80, buttonx = 0, buttony = -145},
    {id = 3, name = "pouchbig", xy = 4, offset = 120, buttonx = 0, buttony = -185},
    {id = 4, name = "pouchhuge", xy = 5, offset = 160, buttonx = 5, buttony = -225},
    {id = 5, name = "pouchzilla", x = 20, y = 5, xoffset = 762, yoffset = 160, buttonx = 20, buttony = -225},
}

local old_widgetsetup = containers.widgetsetup
function containers.widgetsetup(container, prefab, ...)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
    container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
    else
        old_widgetsetup(container, prefab, ...)
    end
end

local function createPouch(num)
    local pouch = crsPouchDetails[getConfig("cfg"..crsPouches[num].."Size")]
    local container = {
        widget = {
            slotpos = {},
            animbank = nil,
            animbuild = nil,
            bgimage = pouch.name..".tex",
            bgatlas = "images/inventoryimages/"..pouch.name..".xml",
			pos = Vector3(getConfig("cfgXPos"),getConfig("cfgYPos"),0),
            side_align_tip = 160,
        },
    type = "chest",
    }

    for y = (pouch.xy or pouch.y), 1, -1 do
        for x = 1, (pouch.xy or pouch.x) do
            table.insert(container.widget.slotpos, Vector3(80 * (x-1) - (pouch.offset or pouch.xoffset), 80 * (y-1) - (pouch.offset or pouch.yoffset), 0))
        end
    end

    return container
end

params.magicpouch = createPouch(1)
params.icepouch = createPouch(2)
params.utilpouch = createPouch(3)

-- ITEM TEST --

-- recursive function to find if the intended item to be stored is a parent of the container or the container itself
local function isParent(container, item, depth)
    depth = depth or 0
    if container.inst == nil or not container.inst:HasTag("magicalpouch") then
        return false
    end

    -- handle self-ception
    if container.inst == item then
        return true
    end

    if container.inst.parent == nil or not container.inst.parent:HasTag("magicalpouch") then
        return false
    end

    -- handle parent-ception
    if container.inst.parent == item then
        return true
    end

    -- traverse hierarchy in search of all parents and repeat test
    -- @TODO would be cleaner and easier to read if there was a method to get all parents of instance
    return isParent(container.inst.parent.components.container, item)
end

-- Icy Magical Pouch --
function params.icepouch.itemtestfn(container, item, slot)
    if item.prefab == "icepouch" then
        if not GetModConfigData("cfgIMPCeption") then
            return false
        end
        if isParent(container, item) then
            return false
        end
        return true
    end

    return (item.components.edible and item.components.perishable) or 
    item.prefab == "mandrake" or 
    item.prefab == "tallbirdegg" or 
    item.prefab == "heatrock" or 
    item.prefab == "spoiled_food" or 
    item:HasTag("frozen") or
    item:HasTag("icebox_valid")
end
-- Utility Magical Pouch --
function params.utilpouch.itemtestfn(container, item, slot)
    if item.prefab == "utilpouch" then
        if not GetModConfigData("cfgUMPCeption") then
            return false
        end
        if isParent(container, item) then
            return false
        end
        return true
    end
    
    return item.components.tool or
    item.components.instrument or
    item.components.weapon or
    item.components.shaver or
    item.components.equippable or
    item:HasTag("teleportato_part") or
    item:HasTag("wallbuilder") or
    -- item:HasTag("groundtile") or
    item:HasTag("mine") or
    item:HasTag("trap") or
    item:HasTag("hat") or
    item:HasTag("crsGoesInUtilityMagicalPouch")
end
-- Magical Pouch --
local function checkParent(container, item)
    if item.prefab == "magicpouch" then
        if not GetModConfigData("cfgMPCeption") then
            return false
        end
        if isParent(container, item) then
            return false
        end
        return true
    end
end
function params.magicpouch.itemtestfn(container, item, slot)
    if isIMPEnabled and isUMPEnabled then
        checkParent(container, item)
        return not params.utilpouch.itemtestfn(container, item, slot) and
        not params.icepouch.itemtestfn(container, item, slot) and
        not item:HasTag("crsMagicalPouch")
    elseif isIMPEnabled and not isUMPEnabled then
        checkParent(container, item)
        return not params.icepouch.itemtestfn(container, item, slot) and
        not item:HasTag("crsMagicalPouch")
    elseif not isIMPEnabled and isUMPEnabled then
        checkParent(container, item)
        return not params.utilpouch.itemtestfn(container, item, slot) and
        not item:HasTag("crsMagicalPouch")
    else
        checkParent(container, item)
        return not item:HasTag("crsMagicalPouch")
    end
end

for k, v in pairs(params) do
    containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end

-- TAGS --

-- Utility Magical Pouch --
local function crsGoesInUtilityMagicalPouch(inst)
    inst:AddTag("crsGoesInUtilityMagicalPouch") -- items with this tag can go in Utility Magical Pouch
end
local crsGoesInUtilityMagicalPouchList = {
    "webberskull",
    "chester_eyebone",
    "compass",
    "fertilizer",
    "featherfan",
    "bedroll_furry",
    "bedroll_straw",
    "healingsalve",
    "bandage",
    "pumpkin_lantern",
    "heatrock",
    "waxwelljournal",
    "sewing_kit",
    "gunpowder",
    "tropicalfan",
    "packim_fishbone",
    "boatrepairkit",
    "surfboard_item",
}
for k = 1, #crsGoesInUtilityMagicalPouchList do
    if crsGoesInUtilityMagicalPouchList[k] then
        AddPrefabPostInit(crsGoesInUtilityMagicalPouchList[k], crsGoesInUtilityMagicalPouch)
    end
end

-- TINT --

-- local function crsImageTintUpdate(self, num, atlas, bgim, owner, container)
    -- if container.widgetbgimagetint then
        -- self.bgimage:SetTint(container.widgetbgimagetint.r, container.widgetbgimagetint.g, container.widgetbgimagetint.b, container.widgetbgimagetint.a)
    -- end
-- end
-- AddClassPostConstruct("widgets/invslot", crsImageTintUpdate)
