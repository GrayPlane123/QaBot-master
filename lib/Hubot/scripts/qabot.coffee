module.exports = (robot) ->
  robot.respond /q (.*)/, (msg) ->
    data = JSON.stringify({
      kw: msg.match[1]
    })
    request = robot.http("http://127.0.0.1:50000/q")
                   .post(data)

    request (err, res, body) ->
      if err
        res.reply "QaBot also got troubles sometimes :( #{err}"
        return
      data = JSON.parse body
      msg.reply "#{data.ans}"
