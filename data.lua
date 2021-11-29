require("accumulator-interface")
require("accumulator-technology")
require("accumulator-wall")

local path_g = "__accumulator-walls__/graphics/"

local accumulator = {
  {
    name = "accumulator-interface",
    icon = path_g .. "accumulator-wall.png",
    capacity = settings.startup["accumulator-wall-capacity"].value,
    units = "MJ",
    flow_limit = 60 * settings.startup["accumulator-wall-capacity"].value,
    fl_units = "kW"
  }
}

local wall_tier = {
  {
    name = "accumulator-wall",
    icon = path_g .. "accumulator-wall.png",
    order = "a[stone-wall]-b[accumulator-wall]",
    energy_required = 10,
    max_health = settings.startup["accumulator-wall-max-health"].value,
    ingredients = 
    {
      { "accumulator", 1 },
	    { "stone-wall", settings.startup["accumulator-wall-recipe-ratio"].value }
    },
    result_count = settings.startup["accumulator-wall-recipe-ratio"].value,
    stack_size = settings.startup["accumulator-wall-stack-size"].value,
    resistances = data.raw.wall["stone-wall"].resistances
  }
}

local technology_tier ={
  {
    name = "accumulator-wall",
    prerequisites = { "electric-energy-accumulators" },
    count = 160,
    ingredients = 
    {
      {"automation-science-pack", 1},
      {"logistic-science-pack", 1},
      {"chemical-science-pack", 1}
    },
    time = 30
  }
}

AccumulatorWall.NewTierInterface(accumulator[1])
AccumulatorWall.NewTierWall(wall_tier[1])
AccumulatorWall.NewTierTechnology(technology_tier[1])

for key, value in pairs(data.raw.wall) do
  data.raw.wall[value.name].stack_size = settings.startup["accumulator-wall-stack-size"].value
end
