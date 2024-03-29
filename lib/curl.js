// Generated by CoffeeScript 1.7.1
(function() {
  var curl, exec, invoke;

  exec = require("./exec");

  curl = exports;

  curl.get = function(url, headers) {
    if (headers == null) {
      headers = {};
    }
    return invoke("GET", url, headers);
  };

  curl.post = function(url, data, headers) {
    if (headers == null) {
      headers = {};
    }
    return invoke("POST", url, headers, data);
  };

  curl.put = function(url, data, headers) {
    if (headers == null) {
      headers = {};
    }
    return invoke("PUT", url, headers, data);
  };

  curl["delete"] = function(url, headers) {
    if (headers == null) {
      headers = {};
    }
    return invoke("DELETE", url, headers);
  };

  invoke = function(method, url, headers, data) {
    var args, key, val;
    args = ["curl", url];
    if (method !== "GET") {
      push("-X");
      push(method);
    }
    for (key in headers) {
      val = headers[key];
      args.push("-H");
      args.push("" + key + ": " + val);
    }
    if (data != null) {
      push("-d");
      push("" + data);
    }
    return exec(args);
  };

}).call(this);
