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

  it 'registers a hear listener for mmol/L', ->
    expect(@robot.hear).to.have.been.calledWith(/^(\d{1,2}\.\d)$/)

  it 'registers a hear listener for mg/dL', ->
    expect(@robot.hear).to.have.been.calledWith(/^(\d{2,3})$/)
