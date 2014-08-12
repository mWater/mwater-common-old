module.exports = {
  title: "sensorData"
  type: "object"
  properties: {
    _id: { type: "string" }
    ts: { type: "string", format: "date-time" } 
    duid: { type: "string" }
    sensor: { type: "string" }
  }

  required: ["_id", "sensor", "duid", "ts"]
  additionalProperties: true
}
