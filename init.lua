--Minetest API information,
--modding reference book, and other resources
--can be found at https://minetest.org/modbook/index.html
--or https://forum.minetest.net/viewtopic.php?f=14&t=10729
--3d_Armor API docs can be found in their README.md and .lua files

--## Register Internationalization, OP Block, and misc items ##
local S = minetest.get_translator(minetest.get_current_modname())
minetest.register_node("overpowered:block", {
    description = "OP Alloy Block",
    tiles = {"overpowered_block.png"},
    groups = {cracky = 3},
})
minetest.register_craftitem("overpowered:apple", {
    description = "OP Apple",
    inventory_image = "overpowered_apple.png",
    on_use = minetest.item_eat(20),
    --20 HP might be low when using more_upgrade_packs, potion effects, or enchantments
    --It should do more at a cost of 11HP per diamond, so feel free to raise it.
})
minetest.register_craftitem("overpowered:ingot", {
    description = "OP Alloy Ingot",
    inventory_image = "overpowered_ingot.png",
})
minetest.register_craftitem("overpowered:untreatedingot", {
    description = "Untreated OP Ingot",
    inventory_image = "overpowered_untreatedingot.png"
})
--## Register crafting recipes ##
minetest.register_craft({
    output = "overpowered:apple 10",
    --Change :apple <num> to how much you feel is fair
    recipe = {
        {"overpowered:ingot","default:apple","overpowered:ingot"},
    },
})
minetest.register_craft({
    type = "cooking",
    output = "overpowered:ingot",
    recipe = "overpowered:untreatedingot",
    cooktime = 667,
})
minetest.register_craft({
    type = "fuel",
    recipe = "overpowered:block",
    --OP Alloy Blocks can secretly be used as fuel, but only one lasts forever!
    --Inspired by the cooking recipe typo that almost let ingots be used as fuel
    burntime = 1000,
    replacements = {{"overpowered:block", "overpowered:block"}},
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
        {"overpowered:block", "overpowered:block", "overpowered:block"},
        {"", "default:obsidian_shard", ""},
        {"", "default:obsidian_shard", ""},
    }
})
--## Register Tools, Weapons, & Armor ##
minetest.register_tool("overpowered:multitool", {
    description = S("OP Mining Multitool"),
    inventory_image = "overpowered_multitool.png",
    range = 8,
    --default 4
    tool_capabilities = {
        full_punch_interval = 1.2,
        max_drop_level = 2,
        groupcaps = {
            crumbly = {
                --dirt, sand
                maxlevel = 3,
                --Actual uses before breaking is calculated by uses*math.pow(3,tool.maxlevel-node.level)
                --Default node level seems to be 0, so this is usually just 3^maxlevel, or a placebo.
                --The max maxlevel value is 256.
                uses = 2427,
                --Value chosen so as not to breach 65535, just in case, but increased from
                --1000 since it costs 243 diamonds.
                times = { [1]=0.10, [2]=0.05, [3]=0.01 }
            },
            cracky = {
                --tough but crackable stuff like stone
                maxlevel = 3,
                uses = 2427,
                times = { [1]=0.10, [2]=0.05, [3]=0.01 }
            },
            snappy = {
                --something that can be cut using fine tools; e.g. leaves, smallplants, wire, sheets of metal
                maxlevel = 3,
                uses = 2427,
                times = { [1]=0.10, [2]=0.05, [3]=0.01 }
            },
            choppy = {
                --something that can be cut using force; e.g. trees, wooden planks
                maxlevel = 3,
                uses = 2427,
                times = { [1]=0.10, [2]=0.05, [3]=0.01 }
            },
        },
        damage_groups = {fleshy=3}, --Living things like animals and the player. This could imply some blood effects when hitting.
    },
    sound = {breaks = "default_tool_breaks", gain = 2.0},
})

--[[ Groups used by 3d_Armor
3d_armor has many default groups already registered, these are categorized under 4 main headings
- **Elements:** armor_head, armor_torso, armor_legs, armor_feet
- **Attributes:** armor_heal, armor_fire, armor_water
- **Physics:** physics_jump, physics_speed, physics_gravity
- **Durability:** armor_use, flammable
Note: for calculation purposes "Attributes" and "Physics" values stack ]]

minetest.register_tool("overpowered:sword", {
    description = S("OP Sword"),
    inventory_image = "overpowered_sword.png",
    range = 8,
    --50% farther
    tool_capabilities = {
        full_punch_interval = 0.5,
        damage_groups = {fleshy=72},
        --20% higher than Draconic Steel
        uses = 180,
        --18 Diamonds gets us 4854 actual uses at a value of 180
        maxlevel = 3,
        max_drop_level = 1,
    },
    sound = {breaks = "default_tool_breaks", gain = 2.0},
})
--## Register armor crafting recipes if modpath 3d_armor exists ##
if minetest.get_modpath("3d_armor") then
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
    --## Register armor values with API ##
    armor:register_armor("overpowered:helmet", {
        description = S("OP Helmet of Water Breathing"),
        inventory_image = "overpowered_inv_helmet.png",
        groups = {armor_head=1, armor_heal=7, armor_use=2, armor_fire=10,
                  armor_water=1},
        --117 Diamonds, uses were raised to 32767 (2.077 float).
        --Added water breathing, moved gravity reduction to chest.
        armor_groups = {fleshy=50},
        sound = {breaks = "default_tool_breaks", gain = 2.0},
        wear = 0,
    })
    armor:register_armor("overpowered:chestplate", {
        description = S("OP Chestplate of Lightness"),
        inventory_image = "overpowered_inv_chestplate.png",
        groups = {armor_torso=1, armor_heal=35, armor_use=2, armor_fire=10,
                  physics_jump=.7, physics_gravity=-.6},
        --armor_use 1000=65 hits calculated via add_wear(65535/armor_use)
        --For 144 Diamonds, 59% the cost of the multitool, the uses were raised
        --to around 32767 (1.687 would be exact, but we can't use a float).
        armor_groups = {fleshy=60},
        --armor_groups values are odd, there is a tiny variable with blockchance.
        sound = {breaks = "default_tool_breaks", gain = 2.0},
        wear = 0,
    })
    armor:register_armor("overpowered:leggings", {
        description = S("OP Leggings of Speed"),
        inventory_image = "overpowered_inv_leggings.png",
        --For armor_heal values (actually just blockchance), we calculate the
        --percentage of skin area with Lund-Browder medical charts. Until we get a hands armor
        --element in 3d_armor we'll have to add the blockchance to another piece (helmet).
        --Overall, 1% neck, 6% forearms, 3% dorsal, 1.5% palmer,
        --and 1.5% facial are left uncovered. Total is 88% blockchance without
        --editing the 3d models and skins.
        groups = {armor_legs=1, armor_heal=39, armor_use=4, armor_fire=10,
                  physics_speed=1.6, physics_jump=.7},
        --63 Diamonds, uses were raised to 16383 (3.85 exact).
        armor_groups = {fleshy=40},
        sound = {breaks = "default_tool_breaks", gain = 2.0},
        wear = 0,
    })
    armor:register_armor("overpowered:boots", {
        description = S("OP Boots of Firewalking"),
        inventory_image = "overpowered_inv_boots.png",
        groups = {armor_feet=1, armor_heal=7, armor_use=7, armor_fire=10},
        --36 Diamonds, the uses were raised to 9362 (exact is 6.75).
        --Since this is the lowest cost, the speed multiplier was moved to the legs.
        armor_groups = {fleshy=30},
        sound = {breaks = "default_tool_breaks", gain = 2.0},
        wear = 0,
    })
end
