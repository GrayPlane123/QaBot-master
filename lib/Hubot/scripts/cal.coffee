child_process = require('child_process')

module.exports = (robot) ->
    robot.respond /(cal|日历)( me)?/i, (res) ->
        child_process.exec 'cal', (err, stdout, stderr) ->
            res.send(stdout)
