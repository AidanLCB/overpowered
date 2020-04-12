 
minetest.register_node("overpowered:block", {
                                                  description = "OP Alloy Block",
                                                  tiles = {"overpowered_block.png"},
                                                  groups = {cracky = 3},
                                                 })
minetest.register_craftitem("overpowered:apple", {
                                                         description = "OP Apple",
                                                         inventory_image = "overpowered_apple.png",
                                                         on_use = minetest.item_eat(20),
                                                         })
minetest.register_craftitem("overpowered:ingot", {
                                                       description = "OP Alloy Ingot",
                                                       inventory_image = "overpowered_ingot.png",
                                                       })
minetest.register_craftitem("overpowered:untreatedingot", {
                                                           description = "Untreated OP Ingot",
                                                           inventory_image = "overpowered_untreatedingot.png"
                                                          })
minetest.register_craft({
                         output = "overpowered:apple 10",
                         recipe = {
                                   {"overpowered:ingot","default:apple","overpowered:ingot"},
                                  },
                         })
minetest.register_craft({
                         type = "cooking",
                         output = "overpowered:ingot",
                         recipe = "overpowered:untreatedingot",
                         burntime = 5,
                         })
minetest.register_craft({
                         output = "overpowered:untreatedingot 2",
                         recipe = {
                                   {"default:diamondblock", "default:mese"},
                                   {"default:mese", "default:diamondblock"},
                                   }
                        })
minetest.register_craft({
                         output = "overpowered:untreatedingot 2",
                         recipe = {
                                   {"default:mese", "default:diamondblock"},
                                   {"default:diamondblock", "default:mese"},
                        }
                        })
minetest.register_craft({
                         output = "overpowered:block",
                         recipe = {
                                   {"overpowered:ingot", "overpowered:ingot", "overpowered:ingot"},
                                   {"overpowered:ingot", "overpowered:ingot", "overpowered:ingot"},
                                   {"overpowered:ingot", "overpowered:ingot", "overpowered:ingot"},
                                   }
                        })
minetest.register_craft({
                         output = "overpowered:ingot 9",
                         recipe = {
                                   {"overpowered:block"},
                                   }
                        })
minetest.register_craft({
                         output = "overpowered:sword",
                         recipe = {
                                   {"", "overpowered:ingot", ""},
                                  {"", "overpowered:ingot", ""},
                                  {"", "default:obsidian_shard", ""},
                                  }
                         })
minetest.register_craft({
                         output = "overpowered:multitool",
                         recipe = {
                                   {"overpowered:block", "overpowered:block", "overpowered:ingot"},
                                   {"", "default:obsidian_shard", ""},
                                   {"", "default:obsidian_shard", ""},
                                   }
                         })
                         
minetest.register_tool("overpowered:multitool", {
    description = "OP Mining Multitool",
    inventory_image = "overpowered_multitool.png",
    tool_capabilities = {
        full_punch_interval = 1.5,
        max_drop_level = 2,
        groupcaps = {
            cracky = {
                maxlevel = 3,
                uses = 1000,
                times = { [1]=0.10, [2]=0.10, [3]=0.10 }
            },
            crumbly = {
                maxlevel = 3,
                uses = 1000,
                times = { [1]=0.10, [2]=0.10, [3]=0.10 }
            },         
            choppy = {
                maxlevel = 3,
                uses = 1000,
                times = { [1]=0.10, [2]=0.10, [3]=0.10 }
            },         
        },
        damage_groups = {fleshy=2},
    },
    
})
minetest.register_tool("overpowered:sword", {
    description = "OP Sword",
    inventory_image = "overpowered_sword.png",
    tool_capabilities = {
        full_punch_interval = 0.5,
        damage_groups = {fleshy=15},
        },
    })
if minetest.get_modpath("3d_armor") then
armor:register_armor("overpowered:chestplate", {
        description = ("OP Chestplate"),
        inventory_image = "overpowered_inv_chestplate.png",
        groups = {armor_torso=1, armor_heal=23, armor_use=1000, armor_fire=10},
        armor_groups = {fleshy=40},
        wear = 0,
    })
armor:register_armor("overpowered:boots", {
        description = ("OP Boots"),
        inventory_image = "overpowered_inv_boots.png",
        groups = {armor_feet=1, armor_heal=10, armor_use=1000, armor_fire=10, physics_speed=1.3, physics_jump=.7},
        armor_groups = {fleshy=40},
        wear = 0,
    })
armor:register_armor("overpowered:leggings", {
        description = ("OP Leggings"),
        inventory_image = "overpowered_inv_leggings.png",
        groups = {armor_legs=1, armor_heal=15, armor_use=1000, armor_fire=10},
        armor_groups = {fleshy=20},
        wear = 0,
    })
armor:register_armor("overpowered:helmet", {
        description = ("OP Anti Gravity Helmet"),
        inventory_image = "overpowered_inv_helmet.png",
        groups = {armor_head=1, armor_heal=10, armor_use=1000, armor_fire=10, physics_speed=2, physics_jump=.7, physics_gravity=-.7},
        armor_groups = {fleshy=20},
        wear = 0,
    })

minetest.register_craft({
        output = "overpowered:helmet",
        recipe = {
            {"overpowered:ingot", "overpowered:block", "overpowered:ingot"},
            {"overpowered:ingot", "", "overpowered:ingot"},
        }
    })

    minetest.register_craft({
        output = "overpowered:chestplate",
        recipe = {
            {"overpowered:ingot", "", "overpowered:ingot"},
            {"overpowered:ingot", "overpowered:block", "overpowered:ingot"},
            {"overpowered:ingot", "overpowered:ingot", "overpowered:ingot"},
        }
    })

    minetest.register_craft({
        output = "overpowered:leggings",
        recipe = {
            {"overpowered:ingot", "overpowered:ingot", "overpowered:ingot"},
            {"overpowered:ingot", "", "overpowered:ingot"},
            {"overpowered:ingot", "", "overpowered:ingot"},
        }
    })

    minetest.register_craft({
        output = "overpowered:boots",
        recipe = {
            {"overpowered:ingot", "", "overpowered:ingot"},
            {"overpowered:ingot", "", "overpowered:ingot"},
        }
    })



end
