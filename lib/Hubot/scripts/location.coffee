module.exports = (robot) ->  
  robot.hear /location (.*)/, (msg) ->  
    request = robot.http("https://maps.googleapis.com/maps/api/geocode/json")  
                   .query(address: msg.match[1])  
                   .get()  
    request (err, res, body) ->  
      json = JSON.parse body  
      location = json['results'][0]['geometry']['location']  
  
      msg.send "#{location['lat']}, #{location['lng']}"
