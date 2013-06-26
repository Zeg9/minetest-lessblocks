-- Mortar & pestle mod
-- Copyright © 2013 Zeg9, released under the WTFPL

mortar_pestle = {}
mortar_pestle.recipes = {}

-- TODO: register_recipe should accept a "chance" param
-- this would allows recipes that take more time to do
-- Another TODO: make different pestles (wood, stone, metals?)
-- and make them break after a few uses
-- same for mortar?

-- registering a recipe:
-- Input: the input name. do NOT use an item string here, only the name
-- Output: the output itemstring
mortar_pestle.register_recipe = function(input, output)
	mortar_pestle.recipes[input] = output
end

-- Default stuff -waiting for remove_craft to be merged-
mortar_pestle.register_recipe("default:mese_crystal", '"default:mese_crystal_fragment" 9')
mortar_pestle.register_recipe("flowers:dandelion_white", '"dye:white" 4')
mortar_pestle.register_recipe("flowers:dandelion_yellow", '"dye:yellow" 4')
mortar_pestle.register_recipe("flowers:geranium", '"dye:blue" 4')
mortar_pestle.register_recipe("flowers:rose", '"dye:red" 4')
mortar_pestle.register_recipe("flowers:tulip", '"dye:orange" 4')
mortar_pestle.register_recipe("flowers:viola", '"dye:violet" 4')

-- Now our own recipes
mortar_pestle.register_recipe("default:stone", "default:cobble")
mortar_pestle.register_recipe("default:cobble", "default:gravel")

-- The magic:

minetest.register_node("mortar_pestle:mortar", {
	description = "Mortar",
	tiles = {"default_stone.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-.5,-.5,-.5,-6/16,.5,.5},
			{-.5,-.5,-.5,.5,.5,-6/16},
			{-.5,-.5,6/16,.5,.5,.5},
			{6/16,-.5,-.5,.5,.5,.5},
			{-.5,-.5,-.5,.5,-6/16,.5},
		},
	},
	selection_box = {
		type = "regular",
	},
})

minetest.register_node("mortar_pestle:pestle", {
	description = "Pestle",
	tiles = {"default_stone.png"},
	inventory_image = "mortar_pestle_pestle_inv.png",
	groups = {attached_node=1}, -- dig the mortar and the pestle will drop
	sounds = default.node_sound_stone_defaults(),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {0,-22/16,0,5/16,8/16,5/16},
	},
	-- Place pestles only above mortars.
	-- if you place it on the side of a mortar, it will be placed above magically.
	node_placement_prediction = "",
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then return end
		if minetest.get_node(pointed_thing.under).name == "mortar_pestle:mortar" then
			local u = pointed_thing.under
			pointed_thing.above = {x=u.x, y=u.y+1, z=u.z}
			local r = minetest.item_place(itemstack, placer, pointed_thing)
			return r
		end
	end,
	on_punch = function(pos, node, puncher)
		local sound = default.node_sound_stone_defaults().dug
		local params = {to_player=puncher:get_player_name()}
		minetest.sound_play(sound, params)
		if math.random(0,4) == 0 then
			pos.y = pos.y -1
			for _, o in pairs(minetest.get_objects_inside_radius(pos, .5)) do
				if (not o:is_player()) and o:get_luaentity().name == "__builtin:item" then
					local e = o:get_luaentity()
					local s = ItemStack(e.itemstring)
					local output = mortar_pestle.recipes[s:get_name()]
					if s:get_count() > 0 and output then
						local output_pos = o:getpos()
						output_pos.x = output_pos.x+math.random()*.2-.1
						output_pos.y = output_pos.y+math.random()*.1
						output_pos.z = output_pos.z+math.random()*.2-.1
						s:take_item()
						e.itemstring = s:to_string()
						if s:get_count() < 1 then
							o:remove()
						end
						minetest.add_item(output_pos,ItemStack(output))
						break -- only crush one item
					end
				end
			end
		end
	end,
})

minetest.register_craft({
	output = "mortar_pestle:mortar",
	recipe = {
		{"default:stone","","default:stone"},
		{"default:stone","","default:stone"},
		{"default:stone","default:stone","default:stone"},
	},
})
minetest.register_craft({
	output = "mortar_pestle:pestle",
	recipe = {
		{"default:stone"},
		{"default:stone"},
		{"default:stone"},
	},
})

