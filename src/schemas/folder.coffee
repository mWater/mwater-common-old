createdModifiedSchema = require './createdModified'
rolesSchema = require './roles'

module.exports = {
  title: "folder"
  type: "object"
  properties: {
    _id: { type: "string" }
    _rev: { type: "integer" }

    contents: {
      type: "array"
      items: {
        type: "object"
        properties: {
          # Id of the content
          _id: { type: "string" }
          type: { enum: ["form"] }
        }
        required: ['_id', 'type']
        additionalProperties: false
      }
    }

    # Roles are admin and view
    roles: rolesSchema
    
    created: createdModifiedSchema
    modified: createdModifiedSchema
    removed: createdModifiedSchema
  }

  required: ["_id", "_rev", "contents", "roles", "created", "modified"]
  additionalProperties: false
}
