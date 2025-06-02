--[[
csa_processor: it's intended to 
--]] local kRejected = 0
local kAccepted = 1
local kNoop = 2

local altMap = {}

local function init(env)
  altMap[0x2f] = '/'
  altMap[0x2c] = '<'
  altMap[0x2d] = '|'
  altMap[0x2e] = '>'
  altMap[0x30] = ']'
  altMap[0x37] = '{'
  altMap[0x38] = '}'
  altMap[0x39] = '['
  altMap[0x41] = 'Æ'
  altMap[0x51] = 'Œ'
  altMap[0x58] = '›'
  altMap[0x5a] = '‹'
  altMap[0x5d] = '~'
  altMap[0x5c] = '`'
  altMap[0x60] = '\\'
  altMap[0x61] = 'æ'
  altMap[0x71] = 'œ'
  altMap[0x78] = '»'
  altMap[0x7a] = '«'
end

local function map(event, env)
  if event.keycode == 0x60 then
    env.engine:commit_text('ù')
    return kAccepted
  end
  if event:alt() then
    local key = event.keycode
    local eng = env.engine
    local ctx = eng.context
    if key == 0x5b then
      ctx:push_input('`')
      return kAccepted
    end
    if altMap[key] ~= nil then
      eng:commit_text(altMap[key])
      return kAccepted
    end
  end
  return kNoop
end

return {init = init, func = map}
