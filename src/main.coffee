Thingy = require("./thingy")

Thingy.add "test1", (magic) ->
   init: ->
      console.log "Test 1"
   destroy: ->
      console.log "Poof 1"

Thingy.add "test2", (magic) ->
   init: ->
      console.log "Test 2"
      @talk()
   talk: ->
      magic.cast
          name: "new-message"
          data:
             name: "aewens"
             text: "he does things"
   destroy: ->
      console.log "Poof 2"

Thingy.add "test3", (magic) ->
   init: ->
      console.log "Test 3"
      magic.listen("new-message", @talk)
   talk: (data) ->
            console.log data
   destroy: ->
      console.log "Poof 3"
   
Thingy.start("test1").then -> Thingy.start("test2")
Thingy.start("test3")

# fn = ->
#    init: ->
#       @test()
#    test: ->
#       console.log "Test"
      
# fn().init()