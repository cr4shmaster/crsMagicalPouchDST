PrefabFiles = 
{
 "magicpouch",
 "icepouch",
}

Assets = 
{
 Asset("ATLAS", "images/inventoryimages/magicpouch.xml"),
 Asset("IMAGE", "images/inventoryimages/magicpouch.tex"),
 Asset("ATLAS", "minimap/magicpouch.xml"),
 Asset("IMAGE", "minimap/magicpouch.tex"),
 Asset("ATLAS", "images/inventoryimages/icepouch.xml"),
 Asset("IMAGE", "images/inventoryimages/icepouch.tex"),
 Asset("ATLAS", "minimap/icepouch.xml"),
 Asset("IMAGE", "minimap/icepouch.tex"),
}

AddMinimapAtlas("minimap/magicpouch.xml")
AddMinimapAtlas("minimap/icepouch.xml")

local require = GLOBAL.require
STRINGS = GLOBAL.STRINGS
RECIPETABS = GLOBAL.RECIPETABS
Recipe = GLOBAL.Recipe
Ingredient = GLOBAL.Ingredient
TECH = GLOBAL.TECH
local containers = require "containers"
local widgetsetup_old = containers.widgetsetup
local params = {}

STRINGS.NAMES.MAGICPOUCH = "Magical Pouch"
STRINGS.RECIPE_DESC.MAGICPOUCH = "Shrinks items to fit in your pocket!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.MAGICPOUCH = "Shrinks items to fit in your pocket!"
STRINGS.NAMES.ICEPOUCH = "Icy Magical Pouch"
STRINGS.RECIPE_DESC.ICEPOUCH = "A Magical Pouch that keeps food fresh forever!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.ICEPOUCH = "A Magical Pouch that keeps food fresh forever!"
GLOBAL.ICEPOUCH_PERISH_MULT = GetModConfigData("peritime1")

if GetModConfigData("enable1") == 1 then
 local magicpouch = Recipe("magicpouch",
 {
  Ingredient("rope", GetModConfigData("ingr1a")),
  Ingredient("silk", GetModConfigData("ingr1b")),
  Ingredient("purplegem", GetModConfigData("ingr1c")),
 },
 RECIPETABS.MAGIC, TECH.MAGIC_TWO)
 magicpouch.atlas = "images/inventoryimages/magicpouch.xml"
end


if GetModConfigData("enable2") == 1 then
 local icepouch = Recipe("icepouch",
 {
  Ingredient("rope", GetModConfigData("ingr2a")),
  Ingredient("silk", GetModConfigData("ingr2b")),
  Ingredient("bluegem", GetModConfigData("ingr2c")),
 },
 RECIPETABS.MAGIC, TECH.MAGIC_TWO)
 icepouch.atlas = "images/inventoryimages/icepouch.xml"
end

function containers.widgetsetup(container, prefab, ...)
 local t = params[prefab or container.inst.prefab]
  if t ~= nil then
   for k, v in pairs(t) do
    container[k] = v
   end
   container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
  else
   widgetsetup_old(container, prefab, ...)
  end
end

local function PouchSmall()
 local container =
 {
  widget =
  {
   slotpos = {},
   animbank = nil,
   animbuild = nil,
   bgimage = "ui_magicpouch_2x2.tex",
   bgatlas = "images/inventoryimages/ui_magicpouch_2x2.xml",
   pos = GLOBAL.Vector3(GetModConfigData("posx")+40,GetModConfigData("posy"),0),
   side_align_tip = 160,
  },
  type = "chest",
 }

 for y = 1, 0, -1 do
  for x = 0, 1 do
   table.insert(container.widget.slotpos, GLOBAL.Vector3(80*x-80*2+40, 80*y-80*2+40,0))
  end
 end

  return container
end

local function PouchMedium()
 local container =
 {
  widget =
  {
   slotpos = {},
   animbank = nil,
   animbuild = nil,
   bgimage = "ui_magicpouch_3x3.tex",
   bgatlas = "images/inventoryimages/ui_magicpouch_3x3.xml",
   pos = GLOBAL.Vector3(GetModConfigData("posx")+20,GetModConfigData("posy"),0),
   side_align_tip = 160,
  },
  type = "chest",
 }

 for y = 2, 0, -1 do
  for x = 0, 2 do
   table.insert(container.widget.slotpos, GLOBAL.Vector3(80*x-80*2+40, 80*y-80*2+40,0))
  end
 end

 return container
end

local function PouchBig()
 local container =
 {
  widget =
  {
   slotpos = {},
   animbank = nil,
   animbuild = nil,
   bgimage = "ui_magicpouch_4x4.tex",
   bgatlas = "images/inventoryimages/ui_magicpouch_4x4.xml",
   pos = GLOBAL.Vector3(GetModConfigData("posx"),GetModConfigData("posy"),0),
   side_align_tip = 160,
  },
  type = "chest",
 }

 for y = 3, 0, -1 do
  for x = 0, 3 do
   table.insert(container.widget.slotpos, GLOBAL.Vector3(80*x-80*2+40, 80*y-80*2+40,0))
  end
 end

 return container
end

local get_size_magicpouch = GetModConfigData("size1")
local get_size_icepouch = GetModConfigData("size2")

if get_size_magicpouch == 1 then
 params.magicpouch = PouchSmall()
elseif get_size_magicpouch == 2 then
 params.magicpouch = PouchMedium()
else
 params.magicpouch = PouchBig()
end

if get_size_icepouch == 1 then
 params.icepouch = PouchSmall()
elseif get_size_icepouch == 2 then
 params.icepouch = PouchMedium()
else
 params.icepouch = PouchBig()
end

-- Recursive function to find if the intended item to be stored is a parent of the container or the container itself
local function isParent(container, item, depth)
 depth = depth or 0
 if container.inst == nil or not container.inst:HasTag("magicalpouch") then
  return false
 end

 -- Handle self-ception
 if container.inst == item then
  return true
 end

 if container.inst.parent == nil or not container.inst.parent:HasTag("magicalpouch") then
  return false
 end

 -- Handle parent-ception
 if container.inst.parent == item then
  return true
 end

 -- Traverse hierarchy in search of all parents and repeat test
 -- @TODO would be cleaner and easier to read if there was a method to get all parents of instance
 return isParent(container.inst.parent.components.container, item)
end

function params.icepouch.itemtestfn(container, item, slot)
  -- Handle Pouch-ception
 if item:HasTag("icypouch") then
  if GetModConfigData("incept2") == 0 then
   return false
  end
  if isParent(container, item) == true then
   return false
  end
  return true
 end

 if item.prefab == "spoiled_food" then
  return true
 end

 --Perishable
 if not (item:HasTag("fresh") or item:HasTag("stale") or item:HasTag("spoiled")) then
  return false
 end

 --Edible
 for k, v in pairs(GLOBAL.FOODTYPE) do
  if item:HasTag("edible_"..v) then
   return true
  end
 end

 return false
end

function params.magicpouch.itemtestfn(container, item, slot)
 -- Handle Pouch-ception
 if GetModConfigData("incept1") == 1 then
  if isParent(container, item) == true then
   return false
  end

  return true
 end

 return not item:HasTag("magicalpouch")
end

for k, v in pairs(params) do
 containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
