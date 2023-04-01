local c = 0
for ___, surface in pairs(game.surfaces) do
	for ___, interface in pairs(surface.find_entities_filtered{
    name = "accumulator-interface",
    type = "accumulator"
  }) do 
    local walls = interface.surface.find_entities_filtered{
      name = "accumulator-wall",
      type = "wall",
      position = interface.position,
      radius = 0.5
    }
    if #walls < 1 then 
      interface.destroy() 
      c = c + 1 
    end
  end
end

if c > 0 then 
  game.print(
    "Accumulator Walls: "..c.." residual interface destroyed",
    {r = 1, g = 0.5, b = 0, a = 1}
  )
end