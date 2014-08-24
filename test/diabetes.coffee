chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'diabetes', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/diabetes')(@robot)

  it 'registers a respond listener for "estimate a1c"', ->
    expect(@robot.respond).to.have.been.calledWith(/estimate a1c (from average )?(.*)/i)

  it 'registers a hear listener for glucose readings', ->
    expect(@robot.hear).to.have.been.calledWith(/^(\d{2,3}|\d{1,2}\.\d)$/)
