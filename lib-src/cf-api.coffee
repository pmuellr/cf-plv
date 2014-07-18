# Licensed under the Apache License. See footer for details.

curl = require "./curl"
exec = require "./exec"

cf = exports

#-------------------------------------------------------------------------------
# issue a `cf` command, returning a promise which resolves to an object
# with the following shape:
#
#    code:   the exit code of the command
#    stdout: stdout of the command
#    stderr: stderr of the command
#-------------------------------------------------------------------------------
cf.exec = (args) ->
  exec args

#-------------------------------------------------------------------------------
# request the CF API info, returning a promise which resolves to an object
# with the following shape:
#
#    api:     the API url
#    version: version of Cloud Foundry
#-------------------------------------------------------------------------------
cf.getApi = ->
  cf.exec ["api"]
  .then ({code, stdout, stderr}) ->
    throw Error "exit code: #{code}" if code

    match = stdout.match /API endpoint: (.*?) \(API version: (.*?)\)/
    throw Error "unexpected output: #{stdout}" unless match?

    api     = match[1]
    version = match[2]

    {api, version}

#-------------------------------------------------------------------------------
# return a promise on target info, which resolves to an object with the
# JSON described by the /v2/info API
#-------------------------------------------------------------------------------
cf.getInfo = ->
  curl.get "/v2/info"
  .then ({code, stdout, stderr}) ->
    throw Error "exit code: #{code}" if code

    JSON.parse stdout

#-------------------------------------------------------------------------------
# return a promise on target info, which resolves to an object with the
# following shape:
#
#    url:     API endpoint
#    version: version of CLoud Foundry
#    user:    logged in user
#    org:     current org
#    space:   current space
#-------------------------------------------------------------------------------
cf.getTarget = ->
  cf.exec ["target"]
  .then ({code, stdout, stderr}) ->
    throw Error "exit code: #{code}" if code

    match = stdout.match /API endpoint: (.*?) \(API version: (.*?)\)/
    throw Error "unexpected output: #{stdout}" unless match?

    url     = match[1]
    version = match[2]

    match = stdout.match /\nUser:\s*(.*)\n/
    throw Error "unexpected output: #{stdout}" unless match?

    user = match[1]

    match = stdout.match /\nOrg:\s*(.*)\n/
    throw Error "unexpected output: #{stdout}" unless match?

    org = match[1]

    match = stdout.match /\nSpace:\s*(.*)\n/
    throw Error "unexpected output: #{stdout}" unless match?

    space = match[1]

    {url, version, user, org, space}


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
