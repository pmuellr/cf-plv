# Licensed under the Apache License. See footer for details.

#-------------------------------------------------------------------------------
main = ->
  initEventSource()

#-------------------------------------------------------------------------------
initEventSource = ->

  # set up the event source to get status
  eventSource = new EventSource("api/messages")

  eventSource.onopen = (event) ->
    console.log "eventSource open"

  # log a message to the console on error
  eventSource.onerror = (event) ->
    console.log "error opening eventSource #{event.target.url}"
    console.log "will attempt reconnect in 1 second"

    setTimeout initEventSource, 1000
    eventSource.close()

  # normal message
  eventSource.onmessage = (event) ->
    unless event.data?
      console.log "got null for the status; rut-ro"
      return

    data = JSON.parse event.data

    console.log "got #{event.data}"

#-------------------------------------------------------------------------------
main()

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
