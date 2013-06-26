
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

