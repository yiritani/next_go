// GENERATED CODE -- DO NOT EDIT!

'use strict';
var grpc = require('@grpc/grpc-js');
var order_pb = require('./order_pb.js');

function serialize_file_ListOrdersRequest(arg) {
  if (!(arg instanceof order_pb.ListOrdersRequest)) {
    throw new Error('Expected argument of type file.ListOrdersRequest');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_file_ListOrdersRequest(buffer_arg) {
  return order_pb.ListOrdersRequest.deserializeBinary(new Uint8Array(buffer_arg));
}

function serialize_file_ListOrdersResponse(arg) {
  if (!(arg instanceof order_pb.ListOrdersResponse)) {
    throw new Error('Expected argument of type file.ListOrdersResponse');
  }
  return Buffer.from(arg.serializeBinary());
}

function deserialize_file_ListOrdersResponse(buffer_arg) {
  return order_pb.ListOrdersResponse.deserializeBinary(new Uint8Array(buffer_arg));
}


var OrdersServiceService = exports.OrdersServiceService = {
  listOrders: {
    path: '/file.OrdersService/ListOrders',
    requestStream: false,
    responseStream: true,
    requestType: order_pb.ListOrdersRequest,
    responseType: order_pb.ListOrdersResponse,
    requestSerialize: serialize_file_ListOrdersRequest,
    requestDeserialize: deserialize_file_ListOrdersRequest,
    responseSerialize: serialize_file_ListOrdersResponse,
    responseDeserialize: deserialize_file_ListOrdersResponse,
  },
};

exports.OrdersServiceClient = grpc.makeGenericClientConstructor(OrdersServiceService);
