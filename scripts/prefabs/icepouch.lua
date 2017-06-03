require "prefabutil"

local assets = {
    Asset("ANIM", "anim/icepouch.zip"),
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
}

local function ondropped(inst, owner)
    inst.components.container:Close(owner)
end

local function onopen(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/backpack_open", "open")
end

local function onclose(inst)
    inst.SoundEmitter:PlaySound("dontstarve/wilson/backpack_close", "open")
end

getConfig = GetModConfigData

local crsWorkshopCheck = nil
if getConfig("cfgTestCheck", "workshop-399527034") then
    crsWorkshopCheck = "workshop-399527034"
else
    crsWorkshopCheck = "crsMagicalPouchDS"
end

local function fn(Sim)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.entity:AddAnimState()
    inst.AnimState:SetBank("icepouch")
    inst.AnimState:SetBuild("icepouch")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:AddSoundEmitter()

    inst:AddTag("crsMagicalPouch")
    inst:AddTag("crsIcyMagicalPouch")

    inst:AddTag("crsCustomPerishMult")
    inst.crsCustomPerishMult = getConfig("cfgIMPPerishMult", crsWorkshopCheck)
    inst:AddTag("crsCustomTempDuration")
    inst.crsCustomTempDuration = getConfig("cfgIMPTempDuration", crsWorkshopCheck)

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("icepouch.tex") 
    
    if not TheWorld.ismastersim then
        return inst
    end
    
    inst.entity:SetPristine()

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.cangoincontainer = true
    inst.components.inventoryitem.atlasname = "images/inventoryimages/icepouch.xml"
    inst.components.inventoryitem:SetOnDroppedFn(ondropped)

    inst:AddComponent("inspectable")

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("icepouch")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose
    -- inst.components.container.widgetbgimagetint = {r=.44,g=.74,b=1,a=1}

    return inst
end

return Prefab( "common/icepouch", fn, assets)
