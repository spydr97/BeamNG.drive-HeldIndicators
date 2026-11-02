local stalkBindings = {
  indicators = require("stalkBindings/indicators"),
  lights = require("stalkBindings/lights"),
  cruise = require("stalkBindings/cruise"),
}

function stalkBindings.updateGFX(dt)
  stalkBindings.indicators.update(dt)
  stalkBindings.cruise.update(dt)
end

function stalkBindings.onReset()
  stalkBindings.indicators.reset()
  stalkBindings.lights.reset()
  stalkBindings.cruise.reset()
end

return stalkBindings
