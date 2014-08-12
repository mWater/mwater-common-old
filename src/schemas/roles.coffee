module.exports = {
  type: "array"
  minItems: 1
  items: { 
    type: "object"
    properties: {
      id: { type: "string" }
      role: { enum: ["view", "admin"] }
    }
    required: ["id", "role"]
    additionalProperties: false
  }
}