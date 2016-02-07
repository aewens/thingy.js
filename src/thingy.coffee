# author: Austin Ewens
# aka: aewens, @aewens_
# created: 2016-01-23

(((root, factory) ->
    if typeof define is "function" and define.amd
        define [], -> (root["Thingy"] = factory())
    else if typeof exports is "object"
        module.exports = factory()
    else
        root["Thingy"] = factory()
)(@, ->
    Magic = ->
        spells = {}
        return {
            listen: (name, fn, scope) ->
                spells[name] = spells[name] or []
                spells[name].push
                    fn: fn
                    scope: scope
            silence: (name, fn) ->
                spell = spells[name]
                if spell
                    for i in [0...spell.length]
                        if spell[i].fn is fn
                            spell.splice(i, 1)
                            break
            cast: (runes) ->
                name = runes.name
                data = runes.data
                spell = spells[name]
                ( spell.forEach (obj) -> obj.fn.call(obj.scope, data) ) if spell
        }
    
    Thingy = ->
        things = {}
        
        Magic: new Magic()
        add: (thingId, fn) ->
            things[thingId] =
                fn: fn
                instance: null
        start: (thingId) ->
            thing = things[thingId]
            thing.instance = new thing.fn(@Magic)
            Promise.resolve(thing.instance.init()) if thing.instance.init
        stop: (thingId) ->
            thing = things[thingId]
            if thing.instance
                thing.instance.destroy()
                thing.instance = null
        all: (mode) ->
            return null unless mode is "start" or mode is "stop"
            for thing in things
                @[mode](thing) if things.hasOwnProperty(thing)
    
    return new Thingy()
))