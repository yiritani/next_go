// GENERATED CODE -- DO NOT EDIT!

'use strict';
var grpc = require('@grpc/grpc-js');
var ping_pb = require('./ping_pb.js');

function serialize_file_PingRequest(arg) {
  if (!(arg instanceof ping_pb.PingRequest)) {
    throw new Error('Expected argument of type file.PingRequest');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_file_PingRequest(buffer_arg) {
  return ping_pb.PingRequest.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_file_PingResponse(arg) {
  if (!(arg instanceof ping_pb.PingResponse)) {
    throw new Error('Expected argument of type file.PingResponse');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_file_PingResponse(buffer_arg) {
  return ping_pb.PingResponse.deserializeBinary(new Uint8Array(buffer_arg));
}


var PingServiceService = exports.PingServiceService = {
  ping: {
    path: '/file.PingService/Ping',
    requestStream: false,
    responseStream: false,
    requestType: ping_pb.PingRequest,
    responseType: ping_pb.PingResponse,
    requestSerialize: serialize_file_PingRequest,
    requestDeserialize: deserialize_file_PingRequest,
    responseSerialize: serialize_file_PingResponse,
    responseDeserialize: deserialize_file_PingResponse,
  },
};

exports.PingServiceClient = grpc.makeGenericClientConstructor(PingServiceService);
