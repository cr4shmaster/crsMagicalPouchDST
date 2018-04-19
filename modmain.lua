PrefabFiles = {"magicpouch", "icepouch",}
local crsPouches = {"MP", "IMP",}

local crsAssets = {"pouchhuge_blue", "pouchbig_blue", "pouchmedium_blue", "pouchzilla_blue", "pouchsmall_blue",
        "pouchhuge_grey", "pouchbig_grey", "pouchsmall_grey", "pouchzilla_grey", "pouchmedium_grey"}
Assets = {}
for k=1,#PrefabFiles,1 do
    table.insert(Assets, Asset("ATLAS", "minimap/"..PrefabFiles[k]..".xml"))
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/"..PrefabFiles[k]..".xml"))
end
for k=1,#crsAssets,1 do
    table.insert(Assets, Asset("ATLAS", "images/inventoryimages/"..crsAssets[k]..".xml"))
end

local STRINGS = GLOBAL.STRINGS
local REC = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local TECH = GLOBAL.TECH
local Vector3 = GLOBAL.Vector3
local getConfig = GetModConfigData
local containers = GLOBAL.require "containers"
local FindEntity = GLOBAL.FindEntity
local acEnabled = getConfig("cfgAutoCollectToggle")

-- MAP ICONS --

AddMinimapAtlas("minimap/magicpouch.xml")
AddMinimapAtlas("minimap/icepouch.xml")

-- STRINGS --

STRINGS.NAMES.MAGICPOUCH = "Magical Pouch"
STRINGS.RECIPE_DESC.MAGICPOUCH = "Shrinks items to fit in your pocket!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MAGICPOUCH = "Shrinks items to fit in your pocket!"
STRINGS.NAMES.ICEPOUCH = "Icy Magical Pouch"
STRINGS.RECIPE_DESC.ICEPOUCH = "A Magical Pouch that can keep food fresh forever!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ICEPOUCH = "A Magical Pouch that can keep food fresh forever!"

-- RECIPES --

local isIMPEnabled = getConfig("cfgIMPRecipeToggle")

local crsRecipeTabs = {REC.TOOLS, REC.SURVIVAL, REC.FARM, REC.SCIENCE, REC.TOWN, REC.REFINE, REC.MAGIC,}
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
local magicpouch = AddRecipe("magicpouch", {
    Ingredient("rope", getConfig("cfgMPRope")),
    Ingredient("silk", getConfig("cfgMPWeb")),
    Ingredient("purplegem", getConfig("cfgMPGems")),
}, recipeTab, recipeTech)
magicpouch.atlas = "images/inventoryimages/magicpouch.xml"
-- Icy Magical Pouch --
if isIMPEnabled then
    local icepouch = AddRecipe("icepouch", {
        Ingredient("rope", getConfig("cfgIMPRope")),
        Ingredient("silk", getConfig("cfgIMPWeb")),
        Ingredient("bluegem", getConfig("cfgIMPGems")),
    }, recipeTab, recipeTech)
    icepouch.atlas = "images/inventoryimages/icepouch.xml"
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
function containers.widgetsetup(container, prefab, data, ...)
    local t = params[prefab or container.inst.prefab]
    if t ~= nil then
        for k, v in pairs(t) do
            container[k] = v
        end
    container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
    else
        old_widgetsetup(container, prefab, data, ...)
    end
end

local function createPouch(num)
    local pouch = crsPouchDetails[getConfig("cfg"..crsPouches[num].."Size")]
    local container = {
        widget = {
            slotpos = {},
            animbank = nil,
            animbuild = nil,
            bgimage = (num == 1) and  pouch.name.."_grey.tex" or (num == 2) and pouch.name.."_blue.tex",
            bgatlas = (num == 1) and "images/inventoryimages/"..pouch.name.."_grey.xml" or (num == 2) and "images/inventoryimages/"..pouch.name.."_blue.xml",
            pos = Vector3(getConfig("cfgXPos"),getConfig("cfgYPos"),0),
            side_align_tip = 160,
            buttoninfo = {
                text = acEnabled and "Toggle" or "Disabled",
                position = Vector3(pouch.buttonx, pouch.buttony, 0),
            }
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

for k=1,#crsPouches,1 do params[PrefabFiles[k]] = createPouch(k) end

-- ITEM TEST --

-- recursive function to find if the intended item to be stored is a parent of the container or the container itself
local function isParent(container, item, depth)
    depth = depth or 0
    if container.inst == nil or not container.inst:HasTag("crsMagicalPouch") then return false end
    -- handle self-ception
    if container.inst == item then return true end
    if container.inst.parent == nil or not container.inst.parent:HasTag("crsMagicalPouch") then return false end
    -- handle parent-ception
    if container.inst.parent == item then return true end
    -- traverse hierarchy in search of all parents and repeat test
    -- @TODO would be cleaner and easier to read if there was a method to get all parents of instance
    return isParent(container.inst.parent.components.container, item)
end

local function checkParent(container, item, pouch)
    if item.prefab == PrefabFiles[pouch] then
        if not GetModConfigData("cfg"..crsPouches[pouch].."Ception") then return false end
        if isParent(container, item) then return false end
        return true
    end
end

-- Icy Magical Pouch --
function params.icepouch.itemtestfn(container, item, slot)
    checkParent(container, item, 2)
    if item:HasTag("icebox_valid") then return true end
    if item:HasTag("fresh") or item:HasTag("stale") or item:HasTag("spoiled") or item:HasTag("frozen") then return true end
    return false
end
-- Magical Pouch --
function params.magicpouch.itemtestfn(container, item, slot)
    if isIMPEnabled then
        checkParent(container, item, 1)
        return not params.icepouch.itemtestfn(container, item, slot) and
        not item:HasTag("crsMagicalPouch")
    else
        checkParent(container, item, 1)
        return not item:HasTag("crsMagicalPouch")
    end
end

for k, v in pairs(params) do containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0) end

if acEnabled then

    -- function to search for valid items
    local interval = getConfig("cfgAutoCollectInterval")
    local function crsSearchForItem(inst)
        local item = FindEntity(inst, 1, function(item) 
            return item.components.inventoryitem and 
            item.components.inventoryitem.canbepickedup and
            item.components.inventoryitem.cangoincontainer
        end)
        if item and inst.components.container:Has(item.prefab, 1) then -- if found item exists in the pouch
            local given = 0
            if item.components.stackable then
                local canBeStacked = inst.components.container:FindItem(function(existingItem)
                    return (existingItem.prefab == item.prefab and not existingItem.components.stackable:IsFull())
                end)
                if canBeStacked then
                    inst.components.container:GiveItem(item)
                    given = 1
                end
            end
            if not inst.components.container:IsFull() and given == 0 then -- else if stack is full but the pouch isn't
                inst.components.container:GiveItem(item)
            end
        end
    end

    -- function to toggle auto-collect on/off
    local function crsButtonToggle(player, inst)
        if not inst.crsAutoCollectToggle then
            inst:DoPeriodicTask(interval, crsSearchForItem)
            inst.crsAutoCollectToggle = true
            player.components.talker:Say("ON")
        else
            inst:CancelAllPendingTasks()
            inst.crsAutoCollectToggle = false
            player.components.talker:Say("OFF")
        end
    end

    -- widget button function for MP
    function params.magicpouch.widget.buttoninfo.fn(inst)
        if GLOBAL.TheWorld.ismastersim then
            crsButtonToggle(inst.components.container.opener, inst)
        else
            SendModRPCToServer(GLOBAL.MOD_RPC["crsMagicalPouchDST"]["MPButtonToggle"], inst)
        end
    end
    AddModRPCHandler("crsMagicalPouchDST", "MPButtonToggle", crsButtonToggle)
    -- widget button functions for IMP
    function params.icepouch.widget.buttoninfo.fn(inst)
        if GLOBAL.TheWorld.ismastersim then
            crsButtonToggle(inst.components.container.opener, inst)
        else
            SendModRPCToServer(GLOBAL.MOD_RPC["crsMagicalPouchDST"]["IMPButtonToggle"], inst)
        end
    end
    AddModRPCHandler("crsMagicalPouchDST", "IMPButtonToggle", crsButtonToggle)

end
