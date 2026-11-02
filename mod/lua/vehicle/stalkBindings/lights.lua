local lights = {}

local off, lowBeam, highBeam = 0, 1, 2

local highBeamSelected = false
local stateBeforeFlash
local switchOnSound, switchOffSound

local function currentState()
  return electrics.values.lights_state or off
end

local function playSwitchSound(turningOn)
  if turningOn then
    switchOnSound = switchOnSound or sounds.createSoundscapeSound("LightOn")
    sounds.playSoundSkipAI(switchOnSound)
  else
    switchOffSound = switchOffSound or sounds.createSoundscapeSound("LightOff")
    sounds.playSoundSkipAI(switchOffSound)
  end
end

local function setState(state)
  local before = currentState()
  if state ~= before then
    electrics.setLightsState(state)
    playSwitchSound(state > before)
  end
end

local function isSwitchedOn()
  return (stateBeforeFlash or currentState()) > off
end

local function setSwitch(on)
  if stateBeforeFlash then
    stateBeforeFlash = on and lowBeam or off
  elseif on then
    setState(highBeamSelected and highBeam or lowBeam)
  else
    setState(off)
  end
end

function lights.off()
  setSwitch(false)
end

function lights.on()
  setSwitch(true)
end

function lights.toggle()
  setSwitch(not isSwitchedOn())
end

function lights.highBeam(on)
  highBeamSelected = on
  setSwitch(isSwitchedOn())
end

function lights.highBeamToggle()
  lights.highBeam(not highBeamSelected)
end

function lights.flash(on)
  if on and not stateBeforeFlash then
    stateBeforeFlash = currentState()
    setState(highBeam)
  elseif not on and stateBeforeFlash then
    local wasOn = stateBeforeFlash > off
    stateBeforeFlash = nil
    setSwitch(wasOn)
  end
end

function lights.fog(on)
  electrics.set_fog_lights(on)
end

function lights.fogToggle()
  electrics.toggle_fog_lights()
end

function lights.reset()
  highBeamSelected, stateBeforeFlash = false, nil
end

return lights
