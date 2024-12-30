// GENERATED CODE -- DO NOT EDIT!

'use strict';
var grpc = require('@grpc/grpc-js');
var file_pb = require('./file_pb.js');

function serialize_file_ListFilesRequest(arg) {
  if (!(arg instanceof file_pb.ListFilesRequest)) {
    throw new Error('Expected argument of type file.ListFilesRequest');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_file_ListFilesRequest(buffer_arg) {
  return file_pb.ListFilesRequest.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_file_ListFilesResponse(arg) {
  if (!(arg instanceof file_pb.ListFilesResponse)) {
    throw new Error('Expected argument of type file.ListFilesResponse');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_file_ListFilesResponse(buffer_arg) {
  return file_pb.ListFilesResponse.deserializeBinary(new Uint8Array(buffer_arg));
}


var FileServiceService = exports.FileServiceService = {
  listFiles: {
    path: '/file.FileService/ListFiles',
    requestStream: false,
    responseStream: false,
    requestType: file_pb.ListFilesRequest,
    responseType: file_pb.ListFilesResponse,
    requestSerialize: serialize_file_ListFilesRequest,
    requestDeserialize: deserialize_file_ListFilesRequest,
    responseSerialize: serialize_file_ListFilesResponse,
    responseDeserialize: deserialize_file_ListFilesResponse,
  },
};

exports.FileServiceClient = grpc.makeGenericClientConstructor(FileServiceService);
