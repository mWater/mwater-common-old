createdModifiedSchema = require './createdModified'
rolesSchema = require './roles'

module.exports = {
  title: "response"
  type: "object"
  properties: {
    _id: { type: "string" }
    _rev: { type: "integer" }
    code: { type: "string" }
    form: { type: "string" }
    formRev: { type: "integer" }
    deployment: { type: "string" }
    approvals: { 
      type: "array"
      items: {
        type: "object" 
        properties: {
          by: { type: "string" }
          on: { type: "string", format: "date-time" }
          override: { type: "boolean" } # True if was done by an admin, not the normal approver
        }
        required: ["by", "on"]
        additionalProperties: false
      }
    }
    user: { type: "string" }
    status: { enum: ["draft", "pending", "rejected", "final"] }
    rejectionMessage: { type: "string" }
    data: { type: "object" }
    roles: rolesSchema
    startedOn: { type: "string", format: "date-time" }
    submittedOn: { type: "string", format: "date-time" }
    created: createdModifiedSchema
    modified: createdModifiedSchema
    removed: createdModifiedSchema
  }

  required: ["_id", "_rev", "form", "formRev", "deployment", "user", "status", "data", "roles", "startedOn", "created", "modified"]
  additionalProperties: false
}
