# Description:
#   Notify about Strider builds using webhooks
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_CAMPFIRE_ROOMS
#
# URLS:
#   POST /hubot/strider
#
# Author:
#   Kalman Speier

module.exports = (robot) ->
  robot.router.post "/hubot/strider", (req, res) ->
    payload = JSON.parse req.body.payload
    results = payload.test_results

    user = {
      room: process.env.HUBOT_CAMPFIRE_ROOMS
    }

    message = "[Strider] Job finished."

    if results.test_exitcode is 0
      message += " Tests passed."

    if results.deploy_exitcode is 0
      message += " Deploy succeeded."

    message += " ( #{results.repo_url} )"

    robot.send user, message
    
    res.end