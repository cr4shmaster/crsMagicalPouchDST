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
GetPlayer = _G.GetPlayer
FindEntity = _G.FindEntity
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

-- ITEM TEST --

local crsItemTest = {}
-- Icy Magical Pouch --
crsItemTest.icepouch = function(inst, item, slot)
    return (item.components.edible and item.components.perishable) or 
    item.prefab == "mandrake" or 
    item.prefab == "tallbirdegg" or 
    item.prefab == "heatrock" or 
    item.prefab == "spoiled_food" or 
    item:HasTag("frozen") or
    item:HasTag("icebox_valid")
end
-- Utility Magical Pouch --
crsItemTest.utilpouch = function(inst, item, slot)
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
crsItemTest.magicpouch = function(inst, item, slot)
    if isIMPEnabled and isUMPEnabled then
        return not item:HasTag("crsMagicalPouch") and
        not crsItemTest.utilpouch(inst, item, slot) and
        not crsItemTest.icepouch(inst, item, slot)
    elseif isIMPEnabled and not isUMPEnabled then
        return not item:HasTag("crsMagicalPouch") and
        not crsItemTest.icepouch(inst, item, slot)
    elseif not isIMPEnabled and isUMPEnabled then
        return not item:HasTag("crsMagicalPouch") and
        not crsItemTest.utilpouch(inst, item, slot)
    else
        return not item:HasTag("crsMagicalPouch")
    end
end

-- TINT --

-- local function crsImageTintUpdate(self, num, atlas, bgim, owner, container)
    -- if container.widgetbgimagetint then
        -- self.bgimage:SetTint(container.widgetbgimagetint.r, container.widgetbgimagetint.g, container.widgetbgimagetint.b, container.widgetbgimagetint.a)
    -- end
-- end
-- AddClassPostConstruct("widgets/invslot", crsImageTintUpdate)

-- CONTAINER --

local crsPouchDetails = {
    {id = 1, name = "pouchsmall", xy = 2, offset = 40, buttonx = 0, buttony = -100},
    {id = 2, name = "pouchmedium", xy = 3, offset = 80, buttonx = 0, buttony = -145},
    {id = 3, name = "pouchbig", xy = 4, offset = 120, buttonx = 0, buttony = -185},
    {id = 4, name = "pouchhuge", xy = 5, offset = 160, buttonx = 5, buttony = -225},
    {id = 5, name = "pouchzilla", x = 20, y = 5, xoffset = 762, yoffset = 160, buttonx = 20, buttony = -225},
}

for k = 1, #crsPouches do
    local pouch = crsPouchDetails[getConfig("cfg"..crsPouches[k].."Size")]
    local params = {}
    params[PrefabFiles[k]] = {
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
            table.insert(params[PrefabFiles[k]].widget.slotpos, Vector3(80 * (x-1) - (pouch.offset or pouch.xoffset), 80 * (y-1) - (pouch.offset or pouch.yoffset), 0))
        end
    end
    
	containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, params[PrefabFiles[k]].widget.slotpos ~= nil and #params[PrefabFiles[k]].widget.slotpos or 0)
    
    local old_widgetsetup = containers.widgetsetup
	function containers.widgetsetup(container, prefab, ...)
		local t = params[prefab or container.inst.prefab]
		if t ~= nil then
			for m, v in pairs(t) do
				container[m] = v
			end
		container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
		else
			return old_widgetsetup(container, prefab, ...)
		end
	end
    
    local old_itemtestfn = params[PrefabFiles[k]].itemtestfn
    params[PrefabFiles[k]].itemtestfn = crsItemTest[PrefabFiles[k]]
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

-- ON OPEN/CLOSED/DROPPED --

local function crsOnDropped(inst, owner)
    inst.components.container:Close(owner)
end

local function crsOnOpen(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/backpack_open", "open")
end

local function crsOnClose(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/backpack_close", "open")
end

for k = 1, #PrefabFiles do
    AddPrefabPostInit(PrefabFiles[k], function(inst)
        inst.components.inventoryitem:SetOnDroppedFn(crsOnDropped)
        inst.components.container.onopenfn = crsOnOpen
        inst.components.container.onclosefn = crsOnClose
    end)
end
