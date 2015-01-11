# Description:
#   Diabetes functions for hubot.
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_GLUCOSE_UNIT_THRESHOLD
#   HUBOT_A1C_UNIT_THRESHOLD
#
# Commands:
#   number - convert glucose between mass/molar concentration units
#   _number_ - convert glucose between mass/molar concentration units inline
#   hubot estimate a1c [from average] <glucose level> - Estimates average HbA1C
#   hubot estimate average [from a1c] <HbA1C> - Estimates average blood glucose
#
# Author:
#   awaxa
#   cjo20

conversionratio = 18.0182

mgdlToMmol = (n) ->
  return n / conversionratio

mmolToMgdl = (n) ->
  return n * conversionratio

mgdlToDcct = (n) ->
  return (parseInt(n, 10)+46.7)/28.7

mgdlToIfcc = (n) ->
  return (mgdlToDcct(n)-2.15)*10.929

dcctToIfcc = (n) ->
  return (n - 2.15)*10.929

ifccToDcct = (n) ->
  return (n / 10.929) + 2.15

dcctToMgdl = (n) ->
  return (n * 28.7) - 46.7

ifccToMgdl = (n) ->
  return dcctToMgdl((n / 10.929) + 2.5)


module.exports = (robot) ->
  range = ///
    (?:^|_)        # anchor to the beginning of the string
    (              # begin a capture group
    \d{1,3}        # one to three digit numbers
    (\.\d)?        # optional tenths place
    )              # end a capture group
    (?:$|_)        # anchor to the end of the string
    ///

  options =
    threshold: process.env.HUBOT_GLUCOSE_UNIT_THRESHOLD
    a1cThreshold: process.env.HUBOT_A1C_UNIT_THRESHOLD

  unless options.threshold
    options.threshold = 30

  unless options.a1cThreshold
    options.a1cThreshold = 20

  robot.respond /estimate a1c (from average )?(.*)/i, (msg) ->
    bg = parseFloat(msg.match[2])
    mgdl = 0
    mmol = 0

    if bg >= options.threshold
      mgdl = bg.toFixed(0)
      mmol = mgdlToMmol(bg).toFixed(1)
    else
      mmol = bg.toFixed(1)
      mgdl = mmolToMgdl(bg).toFixed(0)

    dcct = mgdlToDcct(mgdl)

    reply = 'an average of ' + mgdl + ' mg/dL or '
    reply = reply + mmol + ' mmol/L'
    reply = reply + ' is about '
    reply = reply + dcct.toFixed(1) + '% (DCCT) or '
    reply = reply + dcctToIfcc(dcct).toFixed(0) + ' mmol/mol (IFCC)'
    msg.send reply

  robot.respond /estimate average (from a1c )?(.*)/i, (msg) ->
    a1c = parseFloat(msg.match[2])
    dcct = 0
    ifcc = 0

    if a1c >= options.a1cThreshold
      ifcc = a1c.toFixed(0)
      dcct = ifccToDcct(a1c).toFixed(1)
    else
      dcct = a1c.toFixed(1)
      ifcc = dcctToIfcc(a1c).toFixed(0)

    mgdl = dcctToMgdl(dcct)

    reply = 'an HbA1c of ' + dcct + '% (DCCT) or '
    reply = reply + ifcc + ' mmol/mol (IFCC)'
    reply = reply + ' is about '
    reply = reply + mgdl.toFixed(0) + ' mg/dL or '
    reply = reply + mgdlToMmol(mgdl).toFixed(1) + ' mmol/L'

    msg.send reply

  robot.hear range, (msg) ->
    bg = msg.match[1]
    return unless bg > 0
    if bg >= options.threshold
      msg.send bg + ' mg/dL is ' + mgdlToMmol(bg).toFixed(1) + ' mmol/L'
    else
      msg.send bg + ' mmol/L is ' + Math.round(mmolToMgdl(bg)) + ' mg/dL'
