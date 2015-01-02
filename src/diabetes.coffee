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

module.exports = (robot) ->
  range = ///
    ^              # anchor to the beginning of the string
    (              # begin a capture group
    \d{1,3}        # one to three digit numbers
    (\.\d)?        # optional tenths place
    )              # end a capture group
    $              # anchor to the end of the string
    ///

  options =
    threshold: process.env.HUBOT_GLUCOSE_UNIT_THRESHOLD

  unless options.threshold
    options.threshold = 30

  robot.respond /estimate a1c (from average )?(.*)/i, (msg) ->
    bg = msg.match[2]
    if bg >= options.threshold
      reply = 'an average of ' + bg + ' mg/dL or '
      reply = reply + mgdlToMmol(bg).toFixed(1) + ' mmol/L'
      reply = reply + ' is approximately equivalent to '
      reply = reply + mgdlToDcct(bg).toFixed(1) + '% (DCCT) or '
      reply = reply + mgdlToIfcc(bg).toFixed(1) + ' mmol/mol (IFCC)'
    else
      reply = 'an average of ' + bg + ' mmol/L or '
      reply = reply + Math.round(mmolToMgdl(bg)) + ' mg/dL'
      reply = reply + ' is approximately equivalent to '
      reply = reply + mgdlToDcct(mmolToMgdl(bg)).toFixed(1) + '% (DCCT) or '
      reply = reply + mgdlToIfcc(mmolToMgdl(bg)).toFixed(1) + ' mmol/mol (IFCC)'
    msg.send reply

  robot.hear range, (msg) ->
    bg = msg.match[1]
    return unless bg > 0
    if bg >= options.threshold
      msg.send bg + ' mg/dL is ' + mgdlToMmol(bg).toFixed(1) + ' mmol/L'
    else
      msg.send bg + ' mmol/L is ' + Math.round(mmolToMgdl(bg)) + ' mg/dL'
