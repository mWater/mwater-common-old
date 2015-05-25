createdModifiedSchema = require './createdModified'
rolesSchema = require './roles'

module.exports = {
  title: "response"
  type: "object"
  properties: {
    _id: { type: "string" }
    _rev: { type: "integer" }

    # String code of the response. Unique-ish and short enough for human use
    code: { type: "string" }

    # _id of the form
    form: { type: "string" }

    # _rev of the form this was based on
    formRev: { type: "integer" }

    # _id of the deployment that this response is part of
    deployment: { type: "string" }

    # Current successful approval list
    approvals: { 
      type: "array"
      items: {
        type: "object" 
        properties: {
          # Username who did approval
          by: { type: "string" }
          on: { type: "string", format: "date-time" }
          # True if was done by an admin, not the normal approver
          override: { type: "boolean" } 
        }
        required: ["by", "on"]
        additionalProperties: false
      }
    }
    # User who started the response
    user: { type: "string" }

    # Current status. Can go from draft->final if no approval stages
    status: { enum: ["draft", "pending", "rejected", "final"] }

    # Rejection message if in rejected state
    rejectionMessage: { type: "string" }

    # Response date. Organized by question id. See mwater-forms for more details
    data: { type: "object" }

    roles: rolesSchema

    # When response was started
    startedOn: { type: "string", format: "date-time" }

    # When response was last submitted (to pending or final)
    submittedOn: { type: "string", format: "date-time" }

    # Name of draft
    draftName: { type: "string" }
    
    created: createdModifiedSchema
    modified: createdModifiedSchema
    removed: createdModifiedSchema
  }

  required: ["_id", "_rev", "form", "formRev", "deployment", "user", "status", "data", "roles", "startedOn", "created", "modified"]
  additionalProperties: false
}
