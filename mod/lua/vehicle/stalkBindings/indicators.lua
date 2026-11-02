local indicators = {}

local flickSeconds = 0.6
local laneChangeFlashes = 3
local laneChangeTimeout = laneChangeFlashes * 1.5 + 1

local clock = 0
local heldSide
local heldSince
local laneChange

local function set(side, on)
  if side == "left" then
    electrics.set_left_signal(on)
  else
    electrics.set_right_signal(on)
  end
end

local function isLit(side)
  local value = side == "left" and electrics.values.signal_L or electrics.values.signal_R
  return value == true or (type(value) == "number" and value > 0)
end

local function isSignalling(side)
  return (electrics.values.turnsignal or 0) == (side == "left" and -1 or 1)
end

local function returnToCentre()
  local side = heldSide
  heldSide = nil
  if clock - heldSince < flickSeconds then
    laneChange = { side = side, flashes = 0, lit = true, started = clock }
  else
    set(side, false)
  end
end

local function updateLaneChange()
  local side = laneChange.side
  if not isSignalling(side) or clock - laneChange.started > laneChangeTimeout then
    laneChange = nil
    return
  end

  local lit = isLit(side)
  if laneChange.lit and not lit then
    laneChange.flashes = laneChange.flashes + 1
    if laneChange.flashes >= laneChangeFlashes then
      laneChange = nil
      set(side, false)
      return
    end
  end
  laneChange.lit = lit
end

function indicators.on(side)
  laneChange = nil
  heldSide, heldSince = side, clock
  set(side, true)
end

function indicators.off(side)
  if heldSide == side then
    returnToCentre()
  end
end

function indicators.cancel()
  if heldSide then
    returnToCentre()
    return
  end
  laneChange = nil
  set("left", false)
  set("right", false)
end

function indicators.update(dt)
  clock = clock + dt
  if laneChange then
    updateLaneChange()
  end
end

function indicators.reset()
  heldSide, heldSince, laneChange = nil, nil, nil
end

return indicators
