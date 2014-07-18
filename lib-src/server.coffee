# Licensed under the Apache License. See footer for details.

fs      = require "fs"
path    = require "path"

ports   = require "ports"
express = require "express"

utils    = require "./utils"
messages = require "./messages"

server = exports

#-------------------------------------------------------------------------------
server.main = (args, opts) ->

  port = ports.getPort utils.PROGRAM

  app = express()

  wwwPath = path.join __dirname, "..", "www"

  # our APIs
  app.get "/api/messages", handleMessages

  # static files
  app.use express.static(wwwPath)

  # start server
  app.listen port, "localhost", ->
    utils.log "server starting on http://localhost:#{port}"

  setInterval sendMessages, 1000

#-------------------------------------------------------------------------------
sendMessages = ->
  # messages.sendMessage {date: "#{new Date()}"}

#-------------------------------------------------------------------------------
handleMessages = (request, response) ->
  messages.handleHttpRequest request, response

#-------------------------------------------------------------------------------
# Copyright IBM Corp. 2014
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#-------------------------------------------------------------------------------
