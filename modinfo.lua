-- This mod adds 3 portable containers:
--  The Magical Pouch holds ingredients and trinkets. 
--  The Icy Magical Pouch holds food and perishable items. 
--  The Utility Magical Pouch holds tools, instruments, weapons, etc.
-- The recipes require Rope, Spider Web, and Purple Gems, Blue Gems, or Living Rod,
--  depending on the pouch. The amounts are configurable in the settings.

-- Workshop Page: http://steamcommunity.com/sharedfiles/filedetails/?id=399527034
-- Author: cr4shmaster: http://steamcommunity.com/id/cr4shmaster

name = "Magical Pouch v2.4.0.1"
description = "Shrinks items to fit in your pocket!"
author = "cr4shmaster"
version = "2.2.2"
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
    {description = "4 slots", data = 1},
    {description = "9 slots", data = 2},
    {description = "16 slots", data = 3},
    {description = "25 slots", data = 4},
    {description = "Pouchzilla", data = 5},
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
        options = {
            {description = "Tools", data = 1},
            {description = "Survival", data = 2},
            {description = "Farm", data = 3},
            {description = "Science", data = 4},
            {description = "Structures", data = 5},
            {description = "Refine", data = 6},
            {description = "Magic", data = 7},
            {description = "Ancient", data = 8},
        },
        default = 1,
    },
    {
        name = "cfgRecipeTech",
        label = "Recipe Tech",
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
        label = "IMP Recipe",
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
        label = "IMP Perish Time",
        options = {
            {description = "Default", data = .5},
            {description = "25% longer", data = .37},
            {description = "50% longer", data = .25},
            {description = "75% longer", data = .12},
            {description = "None", data = 0},
        },
        default = .5,
    },
    {
        name = "cfgIMPTempDuration",
        label = "IMP Temp Duration",
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
        name = "cfgUMPRecipeToggle",
        label = "UMP Recipe",
        options = crsToggle,
        default = true,
    },
    {
        name = "cfgUMPSize",
        label = "UMP Size",
        options = crsSize,
        default = 1,
    },
    {
        name = "cfgUMPRope",
        label = "UMP Rope",
        options = crsIngredient,
        default = 1,
    },
    {
        name = "cfgUMPWeb",
        label = "UMP Spider Web",
        options = crsIngredient,
        default = 15,
    },
    {
        name = "cfgUMPLogs",
        label = "UMP Living Log",
        options = crsIngredient,
        default = 10,
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
        name = "cfgTestCheck",
        label = "Installed",
        options = {
            {description = "Yes", data = true},
        },
        default = true,
    },
}
