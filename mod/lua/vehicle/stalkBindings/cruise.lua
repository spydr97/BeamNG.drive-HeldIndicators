local cruise = {}

local repeatSeconds = 0.5
local heldStep = 5
local kilometresPerHour = 1 / 3.6
local milesPerHour = 0.44704

local clock = 0
local hasSetSpeed = false
local held

local function control()
  return extensions.use("cruiseControl")
end

local function isEngaged()
  return control().getConfiguration().isEnabled
end

local function speedUnit()
  return settings.getValue("uiUnitLength") == "imperial" and milesPerHour or kilometresPerHour
end

local function holdCurrentSpeed()
  control().holdCurrentSpeed()
  hasSetSpeed = hasSetSpeed or isEngaged()
end

local function startStepping(direction)
  control().changeSpeed(direction * speedUnit())
  held = { direction = direction, nextStep = clock + repeatSeconds }
end

local function nextHeldStep(speed, direction)
  if direction > 0 then
    return (math.floor(speed / heldStep + 0.01) + 1) * heldStep
  end
  return (math.ceil(speed / heldStep - 0.01) - 1) * heldStep
end

local function updateHeld()
  if clock < held.nextStep then
    return
  end
  if not isEngaged() then
    held = nil
    return
  end

  local unit = speedUnit()
  local speed = control().getConfiguration().targetSpeed / unit
  control().changeSpeed((nextHeldStep(speed, held.direction) - speed) * unit)
  held.nextStep = clock + repeatSeconds
end

function cruise.resumeOrUp()
  if isEngaged() then
    startStepping(1)
  elseif hasSetSpeed then
    control().setEnabled(true)
  else
    holdCurrentSpeed()
  end
end

function cruise.setOrDown()
  if isEngaged() then
    startStepping(-1)
  else
    holdCurrentSpeed()
  end
end

function cruise.release()
  held = nil
end

function cruise.cancel()
  control().setEnabled(false)
end

function cruise.onOff()
  if isEngaged() or hasSetSpeed then
    control().setEnabled(false)
    hasSetSpeed = false
  else
    holdCurrentSpeed()
  end
end

function cruise.update(dt)
  clock = clock + dt
  if held then
    updateHeld()
  end
end

function cruise.reset()
  hasSetSpeed, held = false, nil
end

return cruise
