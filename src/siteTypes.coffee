# Site types with their sub-types

# Wrap in T() so that localizer finds them
T = (str) ->
  return str

module.exports = [
  { 
    name: T("Water point")
    subtypes: [
      T("Protected dug well")
      T("Unprotected dug well")
      T("Borehole or tubewell")
      T("Protected spring")
      T("Unprotected spring")
      T("Rainwater")
      T("Surface water")
      T("Piped into dwelling")
      T("Piped into yard/plot")
      T("Piped into public tap or basin")
      T("Bottled water")
      T("Tanker truck")
      T("Cart with small tank/drum")
    ]
  }
  { 
    name: T("Sanitation facility")
    subtypes: [
      T("Flush/pour flush toilet")
      T("Ventilated improved pit latrine")
      T("Pit latrine with slab")
      T("Composting toilet")
      T("Pit latrine without slab")
      T("Hanging latrine")
      T("Bucket")
      T("No facilities or bush or field")
    ]
  }
  { 
    name: T("Household")
    subtypes: []
  }
  { 
    name: T("Community")
    subtypes: []
  }
  { 
    name: T("School")
    subtypes: []
  }
  { 
    name: T("Health facility")
    subtypes: []
  }
]   



