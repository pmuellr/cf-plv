# Licensed under the Apache License. See footer for details.

exec = require "./exec"

curl = exports

#-------------------------------------------------------------------------------
# execute the specified curl request with specified args
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
curl.get = (url, headers={}) ->
  invoke "GET", url, headers

#-------------------------------------------------------------------------------
curl.post = (url, data, headers={}) ->
  invoke "POST", url, headers, data

#-------------------------------------------------------------------------------
curl.put = (url, data, headers={}) ->
  invoke "PUT", url, headers, data

#-------------------------------------------------------------------------------
curl.delete = (url, headers={}) ->
  invoke "DELETE", url, headers

#-------------------------------------------------------------------------------
invoke = (method, url, headers, data) ->
  args = ["curl", url]

  unless method is "GET"
    push "-X"
    push method

  for key, val of headers
    args.push "-H"
    args.push "#{key}: #{val}"

  if data?
    push "-d"
    push "#{data}"

  exec args

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
