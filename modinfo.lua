-- https://sites.google.com/view/cr4shmaster/magical-pouch-ds-dst

name = "Magical Pouch v2.4.1.2"
description = "Shrinks items to fit in your pocket!"
author = "cr4shmaster"
version = "2.4.1.2"
forumthread = ""
api_version = 10
all_clients_require_mod = true
client_only_mod = false
dst_compatible = true
icon_atlas = "modicon.xml"
icon = "modicon.tex"
server_filter_tags = {"magical", "pouch"}
priority = 50

local crsSize = {
    {description = "4 slots", data = 1, hover = "Meh."},
    {description = "9 slots", data = 2, hover = "Okay."},
    {description = "16 slots", data = 3, hover = "Nice!"},
    {description = "25 slots", data = 4, hover = "Awesome"},
    {description = "100 slots", data = 5, hover = "Pouchzilla!"},
}
local crsIngredient = {
    {description = "1", data = 1},
    {description = "2", data = 2},
    {description = "3", data = 3},
    {description = "5", data = 5},
    {description = "10", data = 10},
    {description = "15", data = 15},
    {description = "20", data = 20},
}
local crsCount = {
    {description = "-5", data = -5},
    {description = "-4", data = -4},
    {description = "-3", data = -3},
    {description = "-2", data = -2},
    {description = "-1", data = -1},
    {description = "0", data = 0},
    {description = "1", data = 1},
    {description = "2", data = 2},
    {description = "3", data = 3},
    {description = "4", data = 4},
    {description = "5", data = 5},
}
local crsToggle = {
    {description = "Enabled", data = true},
    {description = "Disabled", data = false},
}
local crsRadius = {
    {description = "1", data = 1},
    {description = "2", data = 2},
    {description = "3", data = 3},
    {description = "5", data = 5},
    {description = "10", data = 10},
    {description = "15", data = 15},
    {description = "20", data = 20},
}
local crsInterval = {
    {description = ".1", data = .1},
    {description = ".2", data = .2},
    {description = ".3", data = .3},
    {description = ".4", data = .4},
    {description = ".5", data = .5},
    {description = ".6", data = .6},
    {description = ".7", data = .7},
    {description = ".8", data = .8},
    {description = ".9", data = .9},
    {description = "1", data = 1},
}
local crsChance = {
    {description = "1", data = 1},
    {description = "2", data = 2},
    {description = "3", data = 3},
    {description = "4", data = 4},
    {description = "5", data = 5},
    {description = "6", data = 6},
    {description = "7", data = 7},
    {description = "8", data = 8},
    {description = "9", data = 9},
    {description = "10", data = 10},
}
local crsDarkMotes = {
    {description = "50", data = 50},
    {description = "60", data = 60},
    {description = "70", data = 70},
    {description = "80", data = 80},
    {description = "90", data = 90},
    {description = "100", data = 100},
    {description = "125", data = 125},
    {description = "150", data = 150},
    {description = "200", data = 200},
    {description = "250", data = 250},
    {description = "300", data = 300},
    {description = "350", data = 350},
    {description = "400", data = 400},
    {description = "450", data = 450},
    {description = "500", data = 500},
}
local crsPosition = {
    {description = "500", data = 500},
    {description = "475", data = 475},
    {description = "450", data = 450},
    {description = "425", data = 425},
    {description = "400", data = 400},
    {description = "375", data = 375},
    {description = "350", data = 350},
    {description = "325", data = 325},
    {description = "300", data = 300},
    {description = "275", data = 275},
    {description = "250", data = 250},
    {description = "225", data = 225},
    {description = "200", data = 200},
    {description = "175", data = 175},
    {description = "150", data = 150},
    {description = "125", data = 125},
    {description = "100", data = 100},
    {description = "75", data = 75},
    {description = "50", data = 50},
    {description = "25", data = 25},
    {description = "0", data = 0},
    {description = "-25", data = -25},
    {description = "-50", data = -50},
    {description = "-75", data = -75},
    {description = "-100", data = -100},
    {description = "-125", data = -125},
    {description = "-150", data = -150},
    {description = "-175", data = -175},
    {description = "-200", data = -200},
    {description = "-225", data = -225},
    {description = "-250", data = -250},
    {description = "-275", data = -275},
    {description = "-300", data = -300},
    {description = "-325", data = -325},
    {description = "-350", data = -350},
    {description = "-375", data = -375},
    {description = "-400", data = -400},
    {description = "-425", data = -425},
    {description = "-450", data = -450},
    {description = "-475", data = -475},
    {description = "-500", data = -500},
}

configuration_options = {
    {
        name = "cfgRecipeTab",
        label = "Recipe Tab",
        hover = "Recipe crafting tab.",
        options = {
            {description = "Tools", data = 1},
            {description = "Survival", data = 2},
            {description = "Farm", data = 3},
            {description = "Science", data = 4},
            {description = "Structures", data = 5},
            {description = "Refine", data = 6},
            {description = "Magic", data = 7},
        },
        default = 1,
    },
    {
        name = "cfgRecipeTech",
        label = "Recipe Tech",
        hover = "Crafting building requiremnt.",
        options = {
            {description = "None", data = 1},
            {description = "Science Machine", data = 2},
            {description = "Alchemy Engine", data = 3},
            {description = "Prestihatitator", data = 4},
            {description = "Shadow Manip.", data = 5},
            {description = "Broken APS", data = 6},
            {description = "Repaired APS", data = 7},
            {description = "Obs. Workbench", data = 8},
        },
        default = 5,
    },
    {
        name = "cfgMPSize",
        label = "MP Size",
        options = crsSize,
        default = 2,
    },
    {
        name = "cfgMPRope",
        label = "MP Rope",
        options = crsIngredient,
        default = 1,
    },
    {
        name = "cfgMPWeb",
        label = "MP Spider Web",
        options = crsIngredient,
        default = 15,
    },
    {
        name = "cfgMPGems",
        label = "MP Purple Gem",
        options = crsIngredient,
        default = 5,
    },
    {
        name = "cfgIMPRecipeToggle",
        label = "Toggle IMP",
        options = crsToggle,
        default = true,
    },
    {
        name = "cfgIMPSize",
        label = "IMP Size",
        options = crsSize,
        default = 1,
    },
    {
        name = "cfgIMPPerishMult",
        label = "IMP Spoilage",
        options = {
            {description = "Default", data = .5},
            {description = "25% longer", data = .37},
            {description = "50% longer", data = .25},
            {description = "75% longer", data = .12},
            {description = "None", data = .001},
        },
        default = .5,
    },
    {
        name = "cfgIMPTempDuration",
        label = "IMP Cool Rate",
        options = crsCount,
        default = -1,
    },
    {
        name = "cfgIMPRope",
        label = "IMP Rope",
        options = crsIngredient,
        default = 1,
    },
    {
        name = "cfgIMPWeb",
        label = "IMP Spider Web",
        options = crsIngredient,
        default = 15,
    },
    {
        name = "cfgIMPGems",
        label = "IMP Blue Gem",
        options = crsIngredient,
        default = 10,
    },
    {
        name = "cfgAutoCollectToggle",
        label = "Enable Auto-Collect",
        options = crsToggle,
        default = true,
    },
    {
        name = "cfgAutoCollectInterval",
        label = "Collect Interval",
        options = crsInterval,
        default = .3,
    },
    {
        name = "cfgXPos",
        label = "UI x Position",
        options = crsPosition,
        default = 0,
    },
    {
        name = "cfgYPos",
        label = "UI y Position",
        options = crsPosition,
        default = 0,
    },
    {
        name = "cfgMPCeption",
        label = "MP-ception",
        options = crsToggle,
        default = false,
    },
    {
        name = "cfgIMPCeption",
        label = "IMP-ception",
        options = crsToggle,
        default = false,
    },
    {
        name = "cfgTestCheck",
        label = "Installed",
        options = {
            {description = "Yes", data = true},
        },
        default = true,
    },
}
