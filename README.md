# Hubot Assign Issues

A script to notify a user whenever they are assigned to a Github pull request.
(In the chat room of their choosing.)

## Installation

In hubot project repo, run:

```
npm install hubot-github-pr-assign-notification --save
```

Then add **hubot-github-pr-assign-notification** to your `external-scripts.json`:

```javascript
["hubot-github-pr-assign-notification"]
```

## Configuration


   HUBOT_GITHUB_USERNAME_ROOM_MAPPINGS - A mapping of which github username and chat room belong together.
   (example:
   HUBOT_GITHUB_USERNAME_ROOM_MAPPINGS = user1:room1, user2:room2...
   So when user1 is assigned a PR the bot posts to room1.)

   In addition, you will have to do the following:
   1. Create a new webhook for your `myuser/myrepo` repository at:
    https://github.com/myuser/myrepo/settings/hooks/new

   2. Select the individual events to minimize the load on your Hubot.

   3. Add the url: <HUBOT_URL>:<PORT>/hubot/gh-repo-events
