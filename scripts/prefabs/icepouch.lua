local assets = {
    Asset("ATLAS", "images/inventoryimages/pouchhuge.xml"),
    Asset("IMAGE", "images/inventoryimages/pouchhuge.tex"),
    Asset("ATLAS", "images/inventoryimages/pouchbig.xml"),
    Asset("IMAGE", "images/inventoryimages/pouchbig.tex"),
    Asset("ATLAS", "images/inventoryimages/pouchmedium.xml"),
    Asset("IMAGE", "images/inventoryimages/pouchmedium.tex"),
    Asset("ATLAS", "images/inventoryimages/pouchsmall.xml"),
    Asset("IMAGE", "images/inventoryimages/pouchsmall.tex"),
    Asset("ATLAS", "images/inventoryimages/pouchzilla.xml"),
    Asset("IMAGE", "images/inventoryimages/pouchzilla.tex"),
    Asset("ANIM", "anim/icepouch.zip"),
    Asset("SOUND", "sound/wilson.fsb"),
}

getConfig = GetModConfigData

local crsMagicalPouchDS = nil
if getConfig("cfgTestCheck", "workshop-399011777") then
    crsMagicalPouchDS = "workshop-399011777"
else
    crsMagicalPouchDS = "crsMagicalPouchDS"
end

local function fn(Sim)
    local inst = CreateEntity()

    inst.entity:AddTransform()

    MakeInventoryPhysics(inst)

    inst.entity:AddAnimState()
    inst.AnimState:SetBank("icepouch")
    inst.AnimState:SetBuild("icepouch")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:AddSoundEmitter()

    inst:AddTag("crsMagicalPouch")
    inst:AddTag("crsIcyMagicalPouch")

    inst:AddTag("crsCustomPerishMult")
    inst.crsCustomPerishMult = getConfig("cfgIMPPerishMult", crsMagicalPouchDS)
    inst:AddTag("crsCustomTempDuration")
    inst.crsCustomTempDuration = getConfig("cfgIMPTempDuration", crsMagicalPouchDS)

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("icepouch.tex") 

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.cangoincontainer = true
    inst.components.inventoryitem.atlasname = "images/inventoryimages/icepouch.xml"

    inst:AddComponent("inspectable")

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("icepouch")
    -- inst.components.container.widgetbgimagetint = {r=.44,g=.74,b=1,a=1}

    return inst
end

return Prefab( "common/icepouch", fn, assets)
