createdModifiedSchema = require './createdModified'
rolesSchema = require './roles'

# List of site types which are a 1 or 2 length array (type and subtype)
siteTypes = [
  {
    type: "array"
    additionalItems: false
    items: [
      { enum: ["Water point"] }
      { enum: [
        undefined
        "Protected dug well"
        "Unprotected dug well"
        "Borehole or tubewell"
        "Protected spring"
        "Unprotected spring"
        "Rainwater"
        "Surface water"
        "Piped into dwelling"
        "Piped into yard/plot"
        "Piped into public tap or basin"
        "Bottled water"
        "Tanker truck"
        "Cart with small tank/drum"] }
    ]
  }
  {
    type: "array"
    additionalItems: false
    items: [
      { enum: ["Household"] }
    ]
  }
  {
    type: "array"
    additionalItems: false
    items: [
      { enum: ["Sanitation facility"] }
      { enum: [
        undefined
        "Flush/pour flush toilet"
        "Ventilated improved pit latrine"
        "Pit latrine with slab"
        "Composting toilet"
        "Pit latrine without slab"
        "Hanging latrine"
        "Bucket"
        "No facilities or bush or field"] }
    ]
  }
  {
    type: "array"
    additionalItems: false
    items: [
      { enum: ["Community"] }
    ]
  }
  {
    type: "array"
    additionalItems: false
    items: [
      { enum: ["School"] }
    ]
  }
  {
    type: "array"
    additionalItems: false
    items: [
      { enum: ["Health facility"] }
    ]
  }
]

module.exports = {
  title: "site"
  type: "object"
  properties: {
    _id: { type: "string" }
    _rev: { type: "integer" }

    # Code with internal check. See siteCodes.coffee
    code: { 
      type: "string"
      pattern: "^[0-9]{5,}$"
    }

    type: {
      type: "array"
      oneOf: siteTypes
    }

    # Optional name of site
    name: { type: "string" }

    # Optional description of site
    desc: { type: "string" }

    # Optional GeoJSON geometry of site
    geo: {  
      type: "object" 
      properties: {
        type: { enum: ["Point"] }
        coordinates: { 
          type: "array"
          items: { type: "number" }
          maxItems: 2
          minItems: 2
        }
      }
      required: ["type", "coordinates"]
    }

    # Optional location if the geometry is a point
    location: { 
      type: "object" 
      properties: {
        latitude: { type: "number" }
        longitude: { type: "number" }
        accuracy: { type: ["number", "null"] }
        altitude: { type: ["number", "null"] }
        altitudeAccuracy: { type: ["number", "null"] }
      }
      required: ["latitude", "longitude"]
      additionalProperties: false
    }

    # Optional attributes. 
    attrs: { type: "object" }

    # Optional custom fields, arranged by group name. e.g { "WaterHelpers" : { <custom key value pairs> } }
    custom: { type: "object" }

    # Optional alternate id for site, arranged by group name. e.g { "WaterHelpers" : "1234a" }
    altIds: { type: "object" }

    # Tags of the site
    tags: {
      type: "array"
      items: { 
        type: "object"
        properties: {
          id: { type: "string" } # Id is user:<user> or group:<group>
          tag: { type: "string" }
        }
        required: ["id", "tag"]
        additionalProperties: false
      }
    }

    # Photos of the site.
    photos: {
      type: "array"
      items: { 
        type: "object"
        properties: {
          id: { type: "string", pattern: "^[a-f0-9]+$" } # Guid
          caption: { type: "string" } # Optional caption
          cover: { type: "boolean" } # True if cover photo. Only one can have cover true
        }
        required: ["id"]
        additionalProperties: false
      }
    }

    roles: rolesSchema

    created: {
      type: "object" 
      properties: {
        by: { type: "string" }
        on: { type: "string", format: "date-time" }
        for: { type: "string" } # Group on whose behalf site was created
      }
      required: ["by", "on"]
      additionalProperties: false
    }

    modified: createdModifiedSchema
    removed: createdModifiedSchema
  }

  required: ["_id", "_rev", "code", "type", "tags", "photos", "roles", "created", "modified"]
  additionalProperties: false
}
