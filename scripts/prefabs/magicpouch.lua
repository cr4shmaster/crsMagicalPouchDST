require "prefabutil"

local assets = {
    Asset("ANIM", "anim/magicpouch.zip"),
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

local function fn(Sim)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.entity:AddAnimState()
    inst.AnimState:SetBank("magicpouch")
    inst.AnimState:SetBuild("magicpouch")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:AddSoundEmitter()

    inst:AddTag("crsMagicalPouch")

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("magicpouch.tex")

    if not TheWorld.ismastersim then
        return inst
    end
    
    inst.entity:SetPristine()
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.cangoincontainer = true
    inst.components.inventoryitem.atlasname = "images/inventoryimages/magicpouch.xml"
    inst.components.inventoryitem:SetOnDroppedFn(ondropped)

    inst:AddComponent("inspectable")

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("magicpouch")
    inst.components.container.onopenfn = onopen
    inst.components.container.onclosefn = onclose

    return inst
end

return Prefab("common/magicpouch", fn, assets)
