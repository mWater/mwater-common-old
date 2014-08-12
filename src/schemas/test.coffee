createdModifiedSchema = require './createdModified'
rolesSchema = require './roles'

module.exports = {
  title: "test"
  type: "object"
  properties: {
    _id: { type: "string" }
    _rev: { type: "integer" }
    code: { type: "string" }
    user: { type: "string" }
    type: { type: "string" }
    type_rev: { type: "integer" }

    org: { type: ["string", "null"] } # Legacy

    data: { type: "object" } # TODO fill in
    
    started: { type: ["string", "null"] }
    completed: { type: ["string", "null"] }

    created: createdModifiedSchema
    modified: createdModifiedSchema
    removed: createdModifiedSchema
  }

  required: ["_id", "_rev", "type", "user", "data", "created", "modified"]
  additionalProperties: false
}
