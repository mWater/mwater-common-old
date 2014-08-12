createdModifiedSchema = require './createdModified'
rolesSchema = require './roles'

module.exports = {
  title: "sourceNote"
  type: "object"
  properties: {
    _id: { type: "string" }
    _rev: { type: "integer" }
    user: { type: "string" }
    org: { type: ["string", "null"] } # Legacy

    source: { 
      type: "string"
      pattern: "^[0-9]{5,}$"
    }

    date: { type: "string", format: "date-time" }
    notes: { type: "string" }
    status: { enum: ["broken", "ok", "missing", "maint"]} 
    
    created: createdModifiedSchema
    modified: createdModifiedSchema
    removed: createdModifiedSchema
  }

  required: ["_id", "_rev", "user", "source", "date", "created", "modified"]
  additionalProperties: false
}
