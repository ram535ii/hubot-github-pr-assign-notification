# Description:
#   Notifies Github user when they have been assigned to a Pull Request in their chat client of choice
#
# Configuration:
#   HUBOT_GITHUB_USERNAME_ROOM_MAPPINGS - A mapping of which github username
#                                         and chat room belong together.
#   (example:
#   HUBOT_GITHUB_USERNAME_ROOM_MAPPINGS = user1:room1, user2:room2...
#   So when user1 is assigned a PR the bot posts to room1)
#
#   You will have to do the following:
#   1. Create a new webhook for your `myuser/myrepo` repository at:
#    https://github.com/myuser/myrepo/settings/hooks/new
#
#   2. Select the individual events to minimize the load on your Hubot.
#
#   3. Add the url: <HUBOT_URL>:<PORT>/hubot/gh-repo-events
#
# Commands:
#   None
#
# URLS:
#   POST /hubot/gh-repo-events
#
# Authors:
#   ram535ii
#   Advice from seddy
#   Thanks to https://github.com/hubot-scripts/hubot-github-repo-event-notifier for inspiration

rawMappings = process.env["HUBOT_GITHUB_USERNAME_ROOM_MAPPINGS"]

splitAndSanitiseEnvVars = (commaSeparatedList) ->
  commaSeparatedList.split(",").map((mapping) ->
    splitMapping(mapping.trim())
  )

splitMapping = (mapping) ->
  pair = mapping.split(":")
  [pair[0].trim(), pair[1].trim()]

# Validate Inputs
if rawMappings?
  mappings = splitAndSanitiseEnvVars(rawMappings)

  for pair in mappings
    console.log("Sending notification for GH User: " + pair[0] + " to room: " + pair[1])
else
  console.warn "Github Username:Room pairs must be specified for posting, set HUBOT_GITHUB_USERNAME_ROOM_MAPPINGS"

module.exports = (robot) ->
  robot.router.post "/hubot/gh-repo-events", (req, res) ->
    data = req.body
    pr_url = data.pull_request.html_url

    if data.action == "assigned"
      for pair in mappings
        if data.assignee.login == pair[0]
          robot.messageRoom pair[1], "Sire, you have been assigned to a new pull request - do yourself a favor and check it here => " + pr_url

    res.end "{'status' : 200}"
