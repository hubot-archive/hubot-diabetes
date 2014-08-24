# Description:
#   Diabetes functions for hubot.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   awaxa

module.exports = (robot) ->
  mmol = /^(\d{1,2}\.\d)$/
  mgdl = /^(\d{2,3})$/
  ratio = 18.0182

  robot.hear mgdl, (msg) ->
    msg.send msg.match[1] + ' mg/dL is ' + Math.round(10*msg.match[1]/ratio)/10 + ' mmol/L'

  robot.hear mmol, (msg) ->
    msg.send msg.match[1] + ' mmol/L is ' + Math.round(msg.match[1]*ratio) + ' mg/dL'
