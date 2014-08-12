createdModifiedSchema = require './createdModified'
rolesSchema = require './roles'

deployments = { 
  type: "array" 
  items: { 
    type: "object"
    properties: {
      _id: { type: "string" }
      name: { type: "string" }
      active: { type: "boolean" }
      enumerators: { type: "array", items: { type: "string" } }
      viewers: { type: "array", items: { type: "string" } } 
      admins: { type: "array", items: { type: "string" } } 
      approvalStages: {
        type: "array"
        items: {
          type: "object"
          properties: {
            "approvers": { type: "array", items: { type: "string" } }
          }
          required: ['approvers']
          additionalProperties: false
        }
      }
    }
    required: ["_id", "name", "enumerators", "approvalStages", "viewers", "admins"]
    additionalProperties: false
  }
} 

module.exports = {
  title: "form"
  type: "object"
  properties: {
    _id: { type: "string" }
    _rev: { type: "integer" }
    _basedOn: { type: "string" }
    deployments: deployments
    state: { enum: ["active", "deleted"] }
    design: { type: "object" } # TODO
    roles: rolesSchema
    created: createdModifiedSchema
    modified: createdModifiedSchema
    removed: createdModifiedSchema
  }

  required: ["_id", "_rev", "state", "design", "roles", "created", "modified"]
  additionalProperties: false
}
