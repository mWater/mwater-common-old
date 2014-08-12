createdModifiedSchema = require './createdModified'

rolesSchema = {
  type: "array"
  minItems: 1
  items: { 
    type: "object"
    properties: {
      id: { type: "string" }
      role: { enum: ["view", "admin", "record"] }
    }
    required: ["id", "role"]
    additionalProperties: false
  }
}

module.exports = {
  title: "sensor"
  type: "object"
  properties: {
    _id: { type: "string" }
    _rev: { type: "integer" }
    type: { type: "string" }
    code: { type: "string" }
    duid: { type: "string" }
    name: { type: "string" }

    roles: rolesSchema
    created: createdModifiedSchema
    modified: createdModifiedSchema
    removed: createdModifiedSchema
  }

  required: ["_id", "_rev", "type", "code", "duid", "roles", "created", "modified"]
  additionalProperties: false
}
