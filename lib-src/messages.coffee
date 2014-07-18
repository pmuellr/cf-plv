# Licensed under the Apache License. See footer for details.

utils = require "./utils"

messages = exports

EventClients  = {}
EventClientID = 0
EventInterval = null

#-------------------------------------------------------------------------------
messages.sendMessage = (msg) ->
  msg = JSON.stringify msg
  data = "data: #{msg}\n\n"

  for id, eventClient of EventClients
    eventClient.response.write data

  return

#-------------------------------------------------------------------------------
messages.handleHttpRequest = (request, response) ->
  if !request.headers.accept
    return response.send 500, "expecting an Accept header of `text/event-stream`"

  if request.headers.accept != "text/event-stream"
    return response.send 500, "expecting an Accept header of `text/event-stream`"

  response.writeHead 200,
    "Content-Type":  "text/event-stream"
    "Cache-Control": "no-cache"
    "Connection":    "keep-alive"

  eventClient =
    id:       EventClientID++
    response: response

  EventClients[eventClient.id] = eventClient

  utils.log "event stream #{eventClient.id} opened"

  response.on "close", ->
    utils.log "event stream #{eventClient.id} closed"

    delete EventClients[eventClient.id]

  return

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
