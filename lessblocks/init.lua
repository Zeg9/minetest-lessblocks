
-- Glowing dust
minetest.register_craftitem("lessblocks:glowing_dust", {
	description = "Glowing Dust",
	inventory_image = "lessblocks_glowing_dust.png",
})
mortar_pestle.register_recipe("default:mese_crystal_fragment",'"lessblocks:glowing_dust" 2')

-- Glowing stuff
minetest.register_node("lessblocks:glowing_glass", {
	description = "Glowing Glass",
	drawtype = "glasslike",
	tiles = {"lessblocks_glowing_glass.png"},
	inventory_image = minetest.inventorycube("lessblocks_glowing_glass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 14,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})
minetest.register_craft({
	type = "shapeless",
	output = "lessblocks:glowing_glass",
	recipe = {
		"default:glass",
		"lessblocks:glowing_dust",
	},
})

minetest.register_node("lessblocks:gold_brick", {
	description = "Gold Brick",
	tiles = {"lessblocks_gold_brick.png"},
	paramtype = "light",
	light_source = 14,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = '"lessblocks:gold_brick" 2',
	recipe = {
		{"","default:gold_ingot",""},
		{"default:gold_ingot","lessblocks:glowing_dust","default:gold_ingot"},
		{"","default:gold_ingot",""},
	}
})
minetest.register_craft({
	type = "shapeless",
	output = '"default:gold_ingot" 2',
	recipe = {"lessblocks:gold_brick"},
})

-- Carved stone
minetest.register_node("lessblocks:carved_stone", {
	description = "Carved Stone",
	tiles = {
		"lessblocks_carved_stone.png",
		"lessblocks_carved_stone.png",
		"lessblocks_carved_stone_side.png",
	},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

stairs.register_stair_and_slab("carved_stone", "lessblocks:carved_stone",
	{cracky=3},
	{
		"lessblocks_carved_stone.png",
		"lessblocks_carved_stone.png",
		"lessblocks_carved_stone_side.png",
	},
	"Carved Stone Stair",
	"Carved Stone Slab",
	default.node_sound_stone_defaults()
)

minetest.register_craft({
	output = '"lessblocks:carved_stone" 2',
	recipe = {
		{"default:stone"},
		{"default:stone"},
	},
})

mortar_pestle.register_recipe("lessblocks:carved_stone","default:cobble")

-- Faience
minetest.register_craftitem("lessblocks:faience_lump", {
	description = "Faience lump",
	inventory_image = "lessblocks_faience_lump.png",
})
minetest.register_craft({
	type = "shapeless",
	output = '"lessblocks:faience_lump" 3',
	recipe = {"default:clay_lump","default:clay_lump","default:iron_lump"},
})
minetest.register_node("lessblocks:uncooked_tile", {
	description = "Uncooked Tile",
	tiles = {"lessblocks_uncooked_tile.png"},
	inventory_image = "lessblocks_uncooked_tile_inv.png",
	wield_image = "lessblocks_uncooked_tile.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	drawtype = "nodebox",
	node_box = {
		type = "wallmounted",
		wall_top = {-.5,7/16,-.5, .5,.5,.5},
		wall_bottom = {-.5,-.5,-.5, -7/16,.5,.5},
		wall_bottom = {-.5,-.5,-.5, .5,-7/16,.5},
	},
	sunlight_propagates=true,
	groups = {crumbly=2,attached_node=1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_craft({
	output = "lessblocks:uncooked_tile",
	recipe = {{"lessblocks:faience_lump","lessblocks:faience_lump","lessblocks:faience_lump"}},
})
minetest.register_node("lessblocks:tile", {
	description = "Tile",
	tiles = {"lessblocks_tile.png"},
	inventory_image = "lessblocks_tile_inv.png",
	wield_image = "lessblocks_tile.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	drawtype = "nodebox",
	node_box = {
		type = "wallmounted",
		wall_top = {-.5,7/16,-.5, .5,.5,.5},
		wall_bottom = {-.5,-.5,-.5, -7/16,.5,.5},
		wall_bottom = {-.5,-.5,-.5, .5,-7/16,.5},
	},
	sunlight_propagates=true,
	groups = {cracky=3,attached_node=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	type = "cooking",
	output = "lessblocks:tile",
	recipe = "lessblocks:uncooked_tile",
})

