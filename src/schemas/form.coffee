createdModifiedSchema = require './createdModified'
rolesSchema = require './roles'

# A deployment is a grouping of people who can answer a form and an optional approval chain and viewers.
deployments = { 
  type: "array" 
  items: { 
    type: "object"
    properties: {
      _id: { type: "string" }

      # Name of the deployment
      name: { type: "string" }

      # True if deployment is accepting new responses
      active: { type: "boolean" }

      # List of ids of users and groups who can complete form. i.e. user:<username> or group:<groupname>
      enumerators: { type: "array", items: { type: "string" } }

      # List of ids of users and groups who can view final responses. i.e. user:<username> or group:<groupname>
      viewers: { type: "array", items: { type: "string" } } 

      # List of ids of users and groups who can edit/delete all responses. i.e. user:<username> or group:<groupname>
      admins: { type: "array", items: { type: "string" } }

      # Optional approval stages that responses must pass through to become final. Each stage
      # has a list of approvers who can approve/reject the response and move it along
      approvalStages: {
        type: "array"
        items: {
          type: "object"
          properties: {
            # List of ids of users and groups who can approve/reject responses at this step. i.e. user:<username> or group:<groupname>
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

# Form document which describes both the design of a form and who can edit it, etc
module.exports = {
  title: "form"
  type: "object"
  properties: {
    _id: { type: "string" }
    _rev: { type: "integer" }

    # _id of the form that this is a duplicate of
    _basedOn: { type: "string" }

    # List of deployments. See above
    deployments: deployments

    # Current status of the form. Starts in active state
    state: { enum: ["active", "deleted"] }

    # See mwater-forms for the schema
    design: { type: "object" } 
    
    roles: rolesSchema
    created: createdModifiedSchema
    modified: createdModifiedSchema
    removed: createdModifiedSchema
  }

  required: ["_id", "_rev", "state", "design", "roles", "created", "modified"]
  additionalProperties: false
}
