name = "Magical Pouch"
description = "Shrinks items to fit in your pocket!"
author = "cr4shmaster"
version = "2.3.4"
forumthread = ""
api_version = 10
all_clients_require_mod = true
client_only_mod = false
dst_compatible = true
icon_atlas = "modicon.xml"
icon = "modicon.tex"
server_filter_tags = {"Magical Pouch"}

configuration_options =
{
 {
  name = "enable1",
  label = "MP Recipe",
  options =
  {
   {description = "Enabled", data = 1},
   {description = "Disabled", data = 0},
  },
  default = 1,
 },
 {
  name = "size1",
  label = "MP size",
  options =
  {
   {description = "4 slots", data = 1},
   {description = "9 slots", data = 2},
   {description = "16 slots", data = 3},
  },
  default = 2,
 },
 {
  name = "ingr1a",
  label = "MP rope",
  options =
  {
   {description = "1", data = 1},
   {description = "2", data = 2},
   {description = "3", data = 3},
   {description = "5", data = 5},
   {description = "10", data = 10},
   {description = "15", data = 15},
   {description = "20", data = 20},
  },
  default = 1,
 },
 {
  name = "ingr1b",
  label = "MP spider web",
  options =
  {
   {description = "1", data = 1},
   {description = "2", data = 2},
   {description = "3", data = 3},
   {description = "5", data = 5},
   {description = "10", data = 10},
   {description = "15", data = 15},
   {description = "20", data = 20},
  },
  default = 15,
 },
 {
  name = "ingr1c",
  label = "MP purple gem",
  options =
  {
   {description = "1", data = 1},
   {description = "2", data = 2},
   {description = "3", data = 3},
   {description = "5", data = 5},
   {description = "10", data = 10},
   {description = "15", data = 15},
   {description = "20", data = 20},
  },
  default = 5,
 },
 {
  name = "incept1",
  label = "MP-ception",
  options =
  {
   {description = "Disabled", data = 0},
   {description = "Enabled", data = 1},
  },
  default = 0,
 },
 {
  name = "enable2",
  label = "IMP Recipe",
  options =
  {
  {description = "Enabled", data = 1},
  {description = "Disabled", data = 0},
  },
  default = 1,
 },
 {
  name = "size2",
  label = "IMP size",
  options =
  {
   {description = "4 slots", data = 1},
   {description = "9 slots", data = 2},
   {description = "16 slots", data = 3},
  },
  default = 1,
 },
 {
  name = "peritime1",
  label = "IMP perish time",
  options =
  {
   {description = "Default", data = .5},
   {description = "25% longer", data = .37},
   {description = "50% longer", data = .25},
   {description = "75% longer", data = .12},
   {description = "None", data = 0},
  },
  default = .5,
 },
 {
  name = "ingr2a",
  label = "IMP rope",
  options =
  {
   {description = "1", data = 1},
   {description = "2", data = 2},
   {description = "3", data = 3},
   {description = "5", data = 5},
   {description = "10", data = 10},
   {description = "15", data = 15},
   {description = "20", data = 20},
  },
  default = 1,
 },
 {
  name = "ingr2b",
  label = "IMP spider web",
  options =
  {
   {description = "1", data = 1},
   {description = "2", data = 2},
   {description = "3", data = 3},
   {description = "5", data = 5},
   {description = "10", data = 10},
   {description = "15", data = 15},
   {description = "20", data = 20},
  },
  default = 15,
 },
 {
  name = "ingr2c",
  label = "IMP blue gem",
  options =
  {
   {description = "1", data = 1},
   {description = "2", data = 2},
   {description = "3", data = 3},
   {description = "5", data = 5},
   {description = "10", data = 10},
   {description = "15", data = 15},
   {description = "20", data = 20},
  },
 default = 10,
 },
 {
  name = "incept2",
  label = "IMP-ception",
  options =
  {
   {description = "Disabled", data = 0},
   {description = "Enabled", data = 1},
  },
  default = 0,
 },
 {
  name = "posx",
  label = "Horizontal Position",
  options =
  {
   {description = "-600", data = -600},
   {description = "-550", data = -550},
   {description = "-500", data = -500},
   {description = "-450", data = -450},
   {description = "-400", data = -400},
   {description = "-350", data = -350},
   {description = "-300", data = -300},
   {description = "-250", data = -250},
   {description = "-200", data = -200},
   {description = "-100", data = -100},
   {description = "0", data = 0},
   {description = "100", data = 100},
   {description = "200", data = 200},
   {description = "250", data = 250},
   {description = "300", data = 300},
   {description = "350", data = 350},
   {description = "400", data = 400},
   {description = "450", data = 450},
   {description = "500", data = 500},
   {description = "550", data = 550},
   {description = "600", data = 600},
  },
  default = -300,
 },
 {
  name = "posy",
  label = "Vertical Position",
  options =
  {
   {description = "-350", data = -350},
   {description = "-300", data = -300},
   {description = "-250", data = -250},
   {description = "-200", data = -200},
   {description = "-150", data = -150},
   {description = "-100", data = -100},
   {description = "0", data = 0},
   {description = "100", data = 100},
   {description = "150", data = 150},
   {description = "200", data = 200},
   {description = "250", data = 250},
   {description = "300", data = 300},
   {description = "350", data = 350},
  },
  default = -100,
 },
}
priority = 50
