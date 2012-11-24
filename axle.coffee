# A wrapper library for interfacing with the API Axle API
http = require "http"
_    = require "underscore"

class Axle
  getter: ( path, callback ) ->
    unless @domain?
      throw new Error "No domain set."

    headers =
      "Host":           @domain,
      "User-Agent":     "axle-node HTTP client",
      "Content-Length": "0"

    options =
      hostname: @domain
      port:     @port
      path:     @path( path )
      headers:  headers

    console.log options

    req = http.request options, ( res ) ->
      res.setEncoding( "utf8" )

      body = [ ]
      res.on "data", ( chunk ) -> body.push( chunk )

      res.on "end", () ->
        body_str = body.join ""

        if res.statusCode is not 200
          error_details =
            status: res.statusCode,
            body:   body_str

          callback error_details, null

        callback null, JSON.parse body_str

    req.end()

class exports.V1 extends Axle
  constructor: ( @domain, @port=3000 ) ->
    @path_prefix = "/v1"

  path: ( extra ) ->
    @path_prefix + extra

  getKeysByApi: ( api, options, cb ) ->
    defaults =
      start: 0
      limit: 10

    params = _.extend defaults, options

    endpoint = "/api/#{api}/keys/#{params.start}/#{params.limit}"
    @getter endpoint, cb

  getApis: ( options, cb ) ->
    defaults =
      start:   0
      limit:   10
      resolve: false

    params = _.extend defaults, options

    endpoint = "/api/list/#{params.start}/#{params.limit}?resolve=#{params.resolve}"
    @getter endpoint, cb
