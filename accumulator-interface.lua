if not AccumulatorWall then AccumulatorWall = {} end

local path_g = "__accumulator-walls__/graphics/"

--[[
  @ ACCUMULATOR
    name = "accumulator-interface
    icon = path_g .. "accumulator-wall.png"
    production = settings.startup["accumulator-wall-capaciy"].value --5
    units = "MJ"
    flow_limit = 300
    fl_units = "kW"
]]
local _layers = {
  {
    filename = path_g .. "transparent.png",
    priority = "extra-high",
    width = 32,
    height = 42,
    shift = util.by_pixel(0.078125, -0.3),
  }
}

local function accumulator_picture() return { layers = _layers } end
--local function accumulator_charge() return { layers = _layers } end
--local function accumulator_reflection() return { pictures = _layers[1] } end
--local function accumulator_discharge() return { layers = _layers } end

local function AccumulatorInterfaceEntity(accumulator)
  return {
    type = "accumulator",
    name = accumulator.name,
    icon = accumulator.icon,
    icon_size = 64,
    flags =
    {
      "not-on-map",
      "placeable-off-grid",
      "not-in-kill-statistics"
    },
    collision_box = {{0, 0}, {0, 0}},
    selection_box = {{0, 0}, {0, 0}},
	  hidden = true,
    energy_source =
    {
      type = "electric",
      buffer_capacity = tostring(accumulator.capacity) .. accumulator.units,
      usage_priority = "tertiary",
      input_flow_limit = tostring(accumulator.flow_limit) .. accumulator.fl_units,
      output_flow_limit = tostring(accumulator.flow_limit) .. accumulator.fl_units
    },
    picture = accumulator_picture(),
    --charge_animation = accumulator_charge(),
    --water_reflection = accumulator_reflection(),
    charge_cooldown = 30,
    discharge_cooldown = 60,
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/accumulator-working.ogg",
        volume = 0.4
      },
      idle_sound =
      {
        filename = "__base__/sound/accumulator-idle.ogg",
        volume = 0.35
      },
      --persistent = true,
      max_sounds_per_type = 3,
      audible_distance_modifier = 0.5,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    }
  }
end

local function NewTierAccumulatorInterface(accumulator)
  data:extend({ AccumulatorInterfaceEntity(accumulator) })
end

AccumulatorWall.AccumulatorInterfaceEntity = AccumulatorInterfaceEntity
AccumulatorWall.NewTierInterface = NewTierAccumulatorInterface
