assert = require("chai").assert
utils = require '../src/utils'

describe "utils", ->
  describe "checkHasRole", ->
    before ->
      @roles = [
        { id: "user:a", role: "r1" }
        { id: "group:b", role: "r2" }
        { id: "all", role: "r3" }
      ]

    it "checks particular role", ->
      assert.isTrue utils.checkHasRole(@roles, "a", [], "r1")
      assert.isFalse utils.checkHasRole(@roles, "a", [], "r2")
      assert.isTrue utils.checkHasRole(@roles, "a", ['b'], "r2")

    it "checks all", ->
      assert.isTrue utils.checkHasRole(@roles, "x", [], "r3")

    it "checks any role", ->
      assert.isTrue utils.checkHasRole(@roles, "a", [])

