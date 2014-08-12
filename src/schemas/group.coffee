createdModifiedSchema = require './createdModified'

module.exports = {
  title: "group"
  type: "object"
  properties: {
    _id: { type: "string" }
    _rev: { type: "integer" }
    groupname: { type: "string" }
    desc: { type: "string" }
    public: { type: "boolean" }
    members: { type: "array", items: { type: "string" } }
    admins: { type: "array", items: { type: "string" }, minItems: 1 }

    created: createdModifiedSchema
    modified: createdModifiedSchema
    removed: createdModifiedSchema
  }

  required: ["_id", "_rev", "groupname", "public", "members", "admins", "created", "modified"]
  additionalProperties: false
}
