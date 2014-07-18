# Licensed under the Apache License. See footer for details.

child_process = require "child_process"

q      = require "q"
_      = require "underscore"
concat = require "concat-stream"

Env = _.clone process.env
Env.CF_COLOR = "false"

ExecOptions =
  env: Env
  stdio: ["ignore", "pipe", "pipe"]

#-------------------------------------------------------------------------------
# execute the specified command (1st arg) with args, returning a promise which
# resolves to an object with the shape:
#     code:   exit code
#     stdout: a string with stdout contents
#     stderr: a string with stderr contents
#-------------------------------------------------------------------------------
module.exports = exec = (args) ->

  child    =  child_process.spawn "cf", args, ExecOptions
  deferred = q.defer()

  childStdout = null
  childStderr = null

  readStdout = concat encoding:"string", (data) -> childStdout = data
  readStderr = concat encoding:"string", (data) -> childStderr = data

  child.stdout.pipe readStdout
  child.stderr.pipe readStderr

  child.on "error", (error) ->
    deferred.reject {error}

  child.on "exit", (code) ->
    value =
      code:   code
      stdout: childStdout || ""
      stderr: childStderr || ""

    deferred.resolve value

  deferred.promise

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
