# Description:
#   img4me is awesome
#
# Dependencies:
#   "request": "2.14.0",
#
# Configuration:
#   None
#
# Commands:
#
# Author:
#   dpritchett

request = require 'request'

module.exports = (robot) ->
  robot.pngifyText = (longText, title, msg) ->

      # customize the requests at http://img4me.com/developer
      apiUrl = "http://api.img4me.com/"
      query =
        bcolor: 'FFFFFF'
        font:   'comic'
        size:   '10'
        text:   longText.trim()

      request.get {url: apiUrl, qs: query},
        (error, response, body) ->
          throw error if error

          resultUrl = response.body
          msg.send  title + resultUrl

  robot.respond /imagerize (.*)/i, (msg) ->
    words = msg.match[1]
    robot.pngifyText words, '', msg
