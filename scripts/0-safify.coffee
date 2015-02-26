# Description:
#   Add a shared function to wrap NSFW functions to limit output
#   to certain channels/rooms

module.exports = (robot) ->
  slugify = (str) ->
    str.toLowerCase().replace(/\W+/g, " ")

  explicitRoomsRaw = ("#{process.env.EXPLICIT_ROOMS || ''}").split ','
  explicitRooms = (slugify(room) for room in explicitRoomsRaw when room.length isnt 0)

  roomIsNaughty = (msg) ->
    explicitRooms.indexOf(slugify(msg.message.room)) isnt -1

  thisIsntIrc = ->
    canary = robot.sendPrivate is undefined
    console.log("This isn't IRC!") if canary
    canary

  robot.safify = (msg, fn)->
    console.log "Whitelisted rooms: #{explicitRooms.join(', ')}"

    if roomIsNaughty(msg) or thisIsntIrc()
        fn()
    else
        userName = msg.message.user.name
        responses =
        [
         "I would prefer not to.",
         "I'm sorry #{userName}, I'm afraid I can't do that.",
         "Cake, and grief counseling, will be available at the conclusion of the test.",
        ]

        msg.send "#{msg.random(responses)} ( ͡° ͜ʖ ͡°)"
