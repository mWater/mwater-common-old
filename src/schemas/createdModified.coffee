module.exports = {
  type: "object" 
  properties: {
    by: { type: "string" }
    on: { type: "string", format: "date-time" }
  }
  required: ["by", "on"]
  additionalProperties: false
}




