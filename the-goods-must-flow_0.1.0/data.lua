local resource_autoplace = require("resource-autoplace")

data:extend({
  -- 1. PŘEDMĚTY (Zlatá ruda a Zlatý plát)
  {
    type = "item",
    name = "gold-ore",
    icon = "__the-goods-must-flow__/graphics/icons/gold-ore.png",
    icon_size = 64,
    subgroup = "raw-resource",
    order = "g[gold-ore]",
    stack_size = 50
  },
  {
    type = "item",
    name = "gold-plate",
    icon = "__the-goods-must-flow__/graphics/icons/gold-plate.png",
    icon_size = 64,
    subgroup = "intermediate-product",
    order = "a-b-g",
    stack_size = 100
  },

  -- 2. OVLÁDÁNÍ GENEROVÁNÍ NA MAPĚ (Posuvník v menu)
{
    type = "autoplace-control",
    name = "gold-ore",
    richness = true,
    order = "b-e",
    category = "resource"
  },

  -- 3. ENTITA RUDY (Ložisko na zemi)
  {
    type = "resource",
    name = "gold-ore",
    icon = "__the-goods-must-flow__/graphics/icons/gold-ore.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    order = "a-b-e",
    tree_removal_probability = 0.8,
    tree_removal_max_distance = 32 * 32,
    minable =
    {
      mining_particle = "copper-ore-particle",
      mining_time = 1,
      result = "gold-ore"
    },
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    autoplace = resource_autoplace.resource_autoplace_settings
    {
      name = "gold-ore",
      order = "b",
      base_density = 8,
      has_starting_area_placement = true,
      regular_rq_factor_multiplier = 1.10,
      starting_rq_factor_multiplier = 1.20
    },
    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
    stages =
    {
      sheet =
      {
        filename = "__base__/graphics/entity/copper-ore/copper-ore.png",
        priority = "extra-high",
        size = 128,
        frame_count = 8,
        variation_count = 8,
        scale = 0.5,
        tint = {r = 1.0, g = 0.85, b = 0.1}
      }
    },
    map_color = {r = 0.95, g = 0.80, b = 0.1}
  },

  -- 4. RECEPT (Tavení rudy na plát v peci)
  {
    type = "recipe",
    name = "gold-plate",
    categories = {"smelting"},
    enabled = false,
    energy_required = 3.2,
    ingredients =
    {
      {type = "item", name = "gold-ore", amount = 1}
    },
    results =
    {
      {type = "item", name = "gold-plate", amount = 1}
    }
  },

  -- 5. VÝZKUM
  {
    type = "technology",
    name = "gold-processing",
    icon = "__the-goods-must-flow__/graphics/icons/gold-plate.png",
    icon_size = 64,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "gold-plate"
      }
    },
    prerequisites = {"automation"},
    unit =
    {
      count = 50,
      ingredients =
      {
        {"automation-science-pack", 1}
      },
      time = 15
    },
    order = "c-a-g"
  }
})

-- 6. PŘIDÁNÍ RUDY NA PLANETU NAUVIS (Musí být až za koncem data:extend)
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_controls["gold-ore"] = {}
data.raw["planet"]["nauvis"].map_gen_settings.autoplace_settings["entity"].settings["gold-ore"] = {}