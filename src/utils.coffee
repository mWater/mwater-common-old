_ = require 'lodash'

# Create ~ 128-bit uid that starts with c, d, e or f
exports.createUid = -> 
  'zxxxxxxxxxxx4xxxyxxxxxxxxxxxxxxx'.replace /[xyz]/g, (c) ->
    r = Math.random()*16|0
    v = if c == 'x' then r else if c == 'y' then (r&0x3|0x8) else (r|0xC)
    return v.toString(16)

# Create short unique id, with ~42 bits randomness to keep unique amoung a few choices
exports.createShortUid = ->
    chrs = "abcdefghjklmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ123456789"
    loop 
      id = ""
      for i in [1..7]
        id = id + chrs[_.random(0, chrs.length - 1)]
      if not _.find(@model, { id: id })? then break
    return id

# Create a base32 time code to write on forms
exports.createBase32TimeCode = (date) ->
  # Characters to use (skip 1, I, 0, O)
  chars = "23456789ABCDEFGHJLKMNPQRSTUVWXYZ"

  # Subtract date from July 1, 2013
  base = new Date(2013, 6, 1, 0, 0, 0, 0)

  # Get seconds since
  diff = Math.floor((date.getTime() - base.getTime()) / 1000)

  # Convert to array of base 32 characters
  code = ""

  while diff >= 1
    num = diff % 32
    diff = Math.floor(diff / 32)
    code = chars[num] + code

  return code

# Checks if a user with groups has a particular role. If no role specified, check for any role
exports.checkHasRole = (roles, user, groups, role) ->
  # Calculate my ids for searching roles
  ids = ["user:" + user, "all"]
  ids = ids.concat(_.map(groups, (g) -> "group:" + g))

  if role
    return _.find(roles, (r) -> (r.id in ids) and r.role == role)?
  else
    return _.find(roles, (r) -> (r.id in ids))?
