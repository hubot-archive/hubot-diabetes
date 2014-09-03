# Description:
#   Diabetes functions for hubot.
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_GLUCOSE_UNIT_THRESHOLD
#
# Commands:
#   <glucose level> - convert between mass/molar concentration units
#   hubot estimate a1c [from average] <glucose level> - Estimates average HbA1C
#
# Author:
#   awaxa

conversionratio = 18.0182

mgdlToMmol = (n) ->
  return n / conversionratio

mmolToMgdl = (n) ->
  return n * conversionratio

mgdlToDcct = (n) ->
  return (parseInt(n, 10)+46.7)/28.7

mgdlToIfcc = (n) ->
  return (mgdlToDcct(n)-2.15)*10.929

tenths = (n) ->
  Math.round(10*n)/10

module.exports = (robot) ->
  range = ///^( # begin a capture group anchored to the beginning of the string
    \d{2,3}     # numbers that fit mg/dL
    |           # or
    \d{1,2}\.\d # numbers that fit mmol/L
    )$///       # end the capture group anchored to the end of the string

  options =
    threshold: process.env.HUBOT_GLUCOSE_UNIT_THRESHOLD

  unless options.threshold
    options.threshold = 30

  robot.respond /estimate a1c (from average )?(.*)/i, (msg) ->
    bg = msg.match[2]
    if bg >= options.threshold
      reply = 'an average of ' + bg + ' mg/dL or '
      reply = reply + tenths(mgdlToMmol(bg)) + ' mmol/L'
      reply = reply + ' is approximately equivalent to '
      reply = reply + tenths(mgdlToDcct(bg)) + '% (DCCT) or '
      reply = reply + tenths(mgdlToIfcc(bg)) + ' mmol/mol (IFCC)'
    else
      reply = 'an average of ' + bg + ' mmol/L or '
      reply = reply + Math.round(mmolToMgdl(bg)) + ' mg/dL'
      reply = reply + ' is approximately equivalent to '
      reply = reply + tenths(mgdlToDcct(mmolToMgdl(bg))) + '% (DCCT) or '
      reply = reply + tenths(mgdlToIfcc(mmolToMgdl(bg))) + ' mmol/mol (IFCC)'
    msg.send reply

  robot.hear range, (msg) ->
    bg = msg.match[1]
    return unless bg > 0
    if bg >= options.threshold
      msg.send bg + ' mg/dL is ' + tenths(mgdlToMmol(bg)) + ' mmol/L'
    else
      msg.send bg + ' mmol/L is ' + Math.round(mmolToMgdl(bg)) + ' mg/dL'
