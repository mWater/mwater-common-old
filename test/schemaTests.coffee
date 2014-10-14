assert = require('chai').assert
_ = require 'lodash'
schemas = require '../src/schemas'
jjv = require 'jjv'

schemaEnv = jjv()
schemaEnv.addSchema("site", schemas.site)
schemaEnv.addSchema("response", schemas.response)
schemaEnv.addSchema("folder", schemas.folder)

describe "site schema", ->
  beforeEach ->
    @site = {
      _id: "123"
      _rev: 2
      code: "10007"
      type: ["Water point"]
      name: "name"
      desc: "desc"
      geo: {
        "type" : "Point",
        "coordinates" : [ 10, 20 ]
      }
      tags: []
      photos: [
        { id: "12345", caption: "a photo", cover: true }
        { id: "23456" }
      ]
      roles: [
        { id: "all", role: "view" }
      ]
      created : {
        "on" : "2013-08-05T18:49:59.304466Z"
        "by" : "someuser"
      }
      modified : {
        "on" : "2014-08-05T18:49:59.304466Z"
        "by" : "someuser2"
      }    
    }

  it "validates if correct", ->
    errors = schemaEnv.validate("site", @site)
    assert.isNull errors, JSON.stringify(errors)

  it "validates if no name or desc or geo", ->
    delete @site.name
    delete @site.desc
    delete @site.geo
    errors = schemaEnv.validate("site", @site)
    assert.isNull errors, JSON.stringify(errors)

  it "validates if extra type", ->
    @site.type.push("Protected dug well")
    errors = schemaEnv.validate("site", @site)
    assert.isNull errors, JSON.stringify(errors)

  it "validates if custom", ->
    @site.custom = { "xyz": { a:1 } }
    errors = schemaEnv.validate("site", @site)
    assert.isNull errors, JSON.stringify(errors)

  it "validates if tags", ->
    @site.tags.push { id: "group:somegroup", tag: "created" }
    errors = schemaEnv.validate("site", @site)
    assert.isNull errors, JSON.stringify(errors)

  it "fails if no code", ->
    delete @site.code
    assert schemaEnv.validate("site", @site)

  it "requires a type", ->
    @site.type = []
    assert schemaEnv.validate("site", @site)

  it "requires valid type", ->
    @site.type[0] = "abc"
    assert schemaEnv.validate("site", @site)

  it "requires allows Sanitation facility subtypes", ->
    @site.type = ["Sanitation facility", "Bucket"]
    errors = schemaEnv.validate("site", @site)
    assert.isNull errors, JSON.stringify(errors)

  it "requires correct GeoJSON", ->
    @site.geo.type = "abc"
    assert schemaEnv.validate("site", @site)

  it "requires correct GeoJSON", ->
    @site.geo.coordinates.push 123
    assert schemaEnv.validate("site", @site)

describe "response schema", ->
  beforeEach ->
    @response = {
      "_id" : "1234",
      "_rev" : 27,
      "approvals" : [],
      "code" : "user123-WN5E2",
      "created" : {
          "on" : "2014-06-13T09:35:51.337Z",
          "by" : "user123"
      },
      "data" : {
          "c4875f130d1d450f8ffcf9f07c5bd0ca" : {
              "value" : "2CJzfln"
              "alternate" : "dontknow"
          },
          "c4381f0b4f764de19bdae32daedf1dc8" : {
              "value" : "3U6gYwb",
              "specify" : {}
          },
      },
      "deployment" : "123456",
      "form" : "abc1234",
      "formRev" : 12,
      "modified" : {
          "on" : "2014-06-24T13:54:33.481Z",
          "by" : "user123"
      },
      "roles" : [ 
          {
              "id" : "user:user123",
              "role" : "admin"
          }, 
          {
              "id" : "group:Team",
              "role" : "view"
          }
      ],
      "startedOn" : "2014-06-13T09:35:44.651Z",
      "status" : "final",
      "submittedOn" : "2014-06-13T09:48:17.336Z",
      "user" : "user123"
  }
    
  it "validates if correct", ->
    errors = schemaEnv.validate("response", @response)
    assert.isNull errors, JSON.stringify(errors)


describe "folder schema", ->
  beforeEach ->
    @folder = {
      "_id" : "1234",
      "_rev" : 27,
      "created" : {
          "on" : "2014-06-13T09:35:51.337Z",
          "by" : "user123"
      },
      "modified" : {
          "on" : "2014-06-24T13:54:33.481Z",
          "by" : "user123"
      },
      "roles" : [ 
          {
              "id" : "user:user123",
              "role" : "admin"
          }, 
          {
              "id" : "group:Team",
              "role" : "view"
          }
      ],
      contents: [
        { _id: "12345", type: "form" }
      ],
      name: "Some name"
      desc: "Some desc"
  }
    
  it "validates if correct", ->
    errors = schemaEnv.validate("folder", @folder)
    assert.isNull errors, JSON.stringify(errors)

  it "fails validation if unknown type", ->
    @folder.contents.push { _id: "1234", type: "xyz" }
    errors = schemaEnv.validate("folder", @folder)
    assert.isNotNull errors, JSON.stringify(errors)
