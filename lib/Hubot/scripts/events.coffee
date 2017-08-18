child_process = require('child_process')

module.exports = (robot) ->
    robot.respond /(event|events)( me)?/i, (res) ->
        child_process.exec 'calendar', (err, stdout, stderr) ->
            res.send(stdout)

