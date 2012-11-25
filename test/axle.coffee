sinon = require "sinon"

{ TwerpTest } = require "twerp"
{ V1 }        = require "../axle"

class exports.AxleTest extends TwerpTest
  setup: ( done ) ->
    @axle = new V1 "localhost"
    done 1

  # Return meta data
  getMetaData: ( status_code = 200 ) ->
    meta =
      version:     1
      status_code: status_code
    return meta

  testSomethingSimple: ( done ) ->
    @ok 1
    done 1

  testGetKeysByApi: ( done ) ->
    # Stub out the getter
    stub = sinon.stub @axle, "getter", ( path, cb ) =>
      data =
        meta:    @getMetaData 200
        results: ["key1", "key2"]
      cb null, data

    @axle.getKeysByApi "facebook", {}, ( err, res ) =>
      @isArray res.results
      @equal res.results[0], "key1"
      done 2

  testGetApis: ( done ) ->
    # Stub out the getter
    stub = sinon.stub @axle, "getter", ( path, cb ) =>
      data =
        meta:    @getMetaData 200
        results: ["api1", "api2"]
      cb null, data

    @axle.getKeysByApi "facebook", {}, ( err, res ) =>
      @isArray res.results
      @equal res.results[0], "api1"
      done 2

  testCreateApi: ( done ) ->
    # Stub out the getter
    stub = sinon.stub @axle, "poster", ( path, params, cb ) =>
      data =
        meta:    @getMetaData 200
        results:
          endPoint: "test.com"
          globalCache: 0
          apiFormat: "json"
          endPointTimeout: 2
          endPointMaxRedirects: 2
          createdAt: 1353840301840

      cb null, data

    @axle.createApi "Stu_test", "test.com", {}, ( err, res ) =>
      @isObject res.results
      @equal res.results.endPoint, "test.com"
      done 2
