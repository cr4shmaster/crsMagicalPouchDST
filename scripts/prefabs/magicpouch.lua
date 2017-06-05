require "prefabutil"

local assets = {
    Asset("ANIM", "anim/magicpouch.zip"),
    Asset("ATLAS", "images/inventoryimages/pouchhuge_blue.xml"),
    Asset("IMAGE", "images/inventoryimages/pouchhuge_blue.tex"),
    Asset("ATLAS", "images/inventoryimages/pouchbig_blue.xml"),
    Asset("IMAGE", "images/inventoryimages/pouchbig_blue.tex"),
    Asset("ATLAS", "images/inventoryimages/pouchmedium_blue.xml"),
    Asset("IMAGE", "images/inventoryimages/pouchmedium_blue.tex"),
    Asset("ATLAS", "images/inventoryimages/pouchsmall_blue.xml"),
    Asset("IMAGE", "images/inventoryimages/pouchsmall_blue.tex"),
    Asset("ATLAS", "images/inventoryimages/pouchzilla_blue.xml"),
    Asset("IMAGE", "images/inventoryimages/pouchzilla_blue.tex"),
    Asset("ATLAS", "images/inventoryimages/pouchhuge_grey.xml"),
    Asset("IMAGE", "images/inventoryimages/pouchhuge_grey.tex"),
    Asset("ATLAS", "images/inventoryimages/pouchbig_grey.xml"),
    Asset("IMAGE", "images/inventoryimages/pouchbig_grey.tex"),
    Asset("ATLAS", "images/inventoryimages/pouchmedium_grey.xml"),
    Asset("IMAGE", "images/inventoryimages/pouchmedium_grey.tex"),
    Asset("ATLAS", "images/inventoryimages/pouchsmall_grey.xml"),
    Asset("IMAGE", "images/inventoryimages/pouchsmall_grey.tex"),
    Asset("ATLAS", "images/inventoryimages/pouchzilla_grey.xml"),
    Asset("IMAGE", "images/inventoryimages/pouchzilla_grey.tex"),
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
    
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
    
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
