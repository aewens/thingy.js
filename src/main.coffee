Thingy = require("./thingy")

Thingy.add "test1", ->
   init: ->
      console.log "Test 1"
   destroy: ->
      console.log "Poof 1"

Thingy.add "test2", ->
   init: ->
      console.log "Test 2"
   destroy: ->
      console.log "Poof 2"

Thingy.add "test3", ->
   init: ->
      console.log "Test 3"
   destroy: ->
      console.log "Poof 3"
   
Thingy.start("test1").then -> Thingy.start("test2")
Thingy.start("test3")