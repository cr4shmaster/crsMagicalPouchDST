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
    Asset("ANIM", "anim/utilpouch.zip"),
}

local function fn(Sim)
    local inst = CreateEntity()

    inst.entity:AddTransform()

    MakeInventoryPhysics(inst)

    inst.entity:AddAnimState()
    inst.AnimState:SetBank("utilpouch")
    inst.AnimState:SetBuild("utilpouch")
    inst.AnimState:PlayAnimation("idle")

    inst.entity:AddSoundEmitter()

    inst:AddTag("crsMagicalPouch")
    inst:AddTag("crsUtilityMagicalPouch")

    local minimap = inst.entity:AddMiniMapEntity()
    minimap:SetIcon("utilpouch.tex")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.cangoincontainer = true
    inst.components.inventoryitem.atlasname = "images/inventoryimages/utilpouch.xml"

    inst:AddComponent("inspectable")

    inst:AddComponent("container")
    inst.components.container:WidgetSetup("utilpouch")
    -- inst.components.container.widgetbgimagetint = {r=.80,g=.52,b=.24,a=1}

    return inst
end

return Prefab("common/utilpouch", fn, assets)
