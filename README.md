# NodeAxle

![TravisCI Status](https://secure.travis-ci.org/stuartquin/node-axle.png?branch=master  )

A client library for API Axle api

## Installation

`npm install node-axle`

## Usage

NodeAxle is designed to support future versions of ApiAxle. The library is
instantiated based on the desired version (V1 at the moment):

`NodeAxle = require( "node-axle" ).V1`

Get all API's managed by ApiAxle

```
    axle = new NodeAxle("localhost", 3001)

    axle.getApis {}, ( err, results ) ->
      for i of results.results
        api = results.results[i]
        console.log api["name"]
```
