sinon = require "sinon"

{ TwerpTest } = require "twerp"
{ V1 }        = require "../axle"

class exports.AxleTest extends TwerpTest
  setup: ( done ) ->
    @axle = new V1 "localhost", 3001
    done 1

  # Return meta data
  getMetaData: ( status_code = 200 ) ->
    meta =
      version:     1
      status_code: status_code
    return meta

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

    @axle.getApis {}, ( err, res ) =>
      @isArray res.results
      @equal res.results[0], "api1"
      done 2

  testGetApiStats: ( done ) ->
    # Stub out the getter
    stub = sinon.stub @axle, "getter", ( path, cb ) =>
      data =
        meta:    @getMetaData 200
        results: {}
      cb null, data

    @axle.getApiStats "testapi", ( err, res ) =>
      @isNull    err
      @isNotNull res.results
      done 2

  testGetKeyHits: ( done ) ->
    # Stub out the getter
    stub = sinon.stub @axle, "getter", ( path, cb ) =>
      data =
        meta:    @getMetaData 200
        results: {}
      cb null, data

    @axle.getKeyHits "1234", ( err, res ) =>
      @isNull    err
      @isNotNull res.results
      done 2

  testGetRealTimeKeyHits: ( done ) ->
    # Stub out the getter
    stub = sinon.stub @axle, "getter", ( path, cb ) =>
      data =
        meta:    @getMetaData 200
        results: {}
      cb null, data

    @axle.getRealTimeKeyHits "1234", ( err, res ) =>
      @isNull    err
      @isNotNull res.results
      done 2

  testGetKeyStats: ( done ) ->
    # Stub out the getter
    stub = sinon.stub @axle, "getter", ( path, cb ) =>
      data =
        meta:    @getMetaData 200
        results: {}
      cb null, data

    @axle.getKeyStats "1234", ( err, res ) =>
      @isNull    err
      @isNotNull res.results
      done 2

  testGetKeyStatsError: ( done ) ->
    # Stub out the getter
    stub = sinon.stub @axle, "getter", ( path, cb ) =>
      error =
        status: 404,
        body:   {}
      cb error, null

    @axle.getKeyStats "54321", ( err, res ) =>
      @isObject err
      @isNotNull err
      done 2

  testCreateKey: ( done ) ->
    # Stub out the getter
    stub = sinon.stub @axle, "poster", ( path, params, cb ) =>
      data =
        meta:    @getMetaData 200
        results:
          forApi:    "testapi",
          qpd:       172800,
          qps:       2,
          createdAt: 1356799384205

      cb null, data

    @axle.createKey "123456", "testapi", {}, ( err, res ) =>
      @isObject res.results
      done 1

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
