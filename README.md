cf-plv - Cloud Foundry personal log viewer
================================================================================

An HTTP server which displays logs for all your Cloud Foundry apps.

Note, you run this server on your local development box, not in the cloud.



install
================================================================================

To install `cf-plv`, use the command

    sudo npm -g install cf-plv

Drop the `sudo` on Windows or if you know what you're doing.



quick start
================================================================================

To start the `cf-plv` server, run

    cf-plv

It will display a message providing the URL of the server.



hacking
================================================================================

If you want to modify the source to play with it, you'll also want to have the
`jbuild` program installed.

To install `jbuild` on Windows, use the command

    npm -g install jbuild

To install `jbuild` on Mac or Linux, use the command

    sudo npm -g install jbuild

The `jbuild` command runs tasks defined in the `jbuild.coffee` file.  The
task you will most likely use is `watch`, which you can run with the
command:

    jbuild watch

When you run this command, the application will be built from source, the server
started, and tests run.  When you subsequently edit and then save one of the
source files, the application will be re-built, the server re-started, and the
tests re-run.  For ever.  Use Ctrl-C to exit the `jbuild watch` loop.

You can run those build, server, and test tasks separately.  Run `jbuild`
with no arguments to see what tasks are available, along with a short
description of them.



license
================================================================================

Apache License, Version 2.0

<http://www.apache.org/licenses/LICENSE-2.0.html>
