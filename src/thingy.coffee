# author: Austin Ewens
# aka: aewens, @wordsfromae
# created: 2016-01-23
Thingy = ->
    things = {}
    
    add: (thingId, fn) ->
        things[thingId] =
            fn: fn
            instance: null
    start: (thingId) ->
        things[thingId].instance = things[thingId].fn(null) #new Sandbox(this)
        init = things[thingId].instance.init
        Promise.resolve(init()) if init
    stop: (thingId) ->
        thing = things[thingId]
        if thing.instance
            thing.instance.destroy()
            thing.instance = null
    all: (mode) ->
        return null unless mode is "start" or mode is "stop"
        for thing in things
            @[mode](thing) if things.hasOwnProperty(thing)

module.exports = new Thingy()