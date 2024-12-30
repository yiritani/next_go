// package: file
// file: order.proto

/* tslint:disable */
/* eslint-disable */

import * as grpc from '@grpc/grpc-js';
import * as order_pb from './order_pb';

interface IOrdersServiceService
  extends grpc.ServiceDefinition<grpc.UntypedServiceImplementation> {
  listOrders: IOrdersServiceService_IListOrders;
}

interface IOrdersServiceService_IListOrders
  extends grpc.MethodDefinition<
    order_pb.ListOrdersRequest,
    order_pb.ListOrdersResponse
  > {
  path: '/file.OrdersService/ListOrders';
  requestStream: false;
  responseStream: true;
  requestSerialize: grpc.serialize<order_pb.ListOrdersRequest>;
  requestDeserialize: grpc.deserialize<order_pb.ListOrdersRequest>;
  responseSerialize: grpc.serialize<order_pb.ListOrdersResponse>;
  responseDeserialize: grpc.deserialize<order_pb.ListOrdersResponse>;
}

export const OrdersServiceService: IOrdersServiceService;

export interface IOrdersServiceServer
  extends grpc.UntypedServiceImplementation {
  listOrders: grpc.handleServerStreamingCall<
    order_pb.ListOrdersRequest,
    order_pb.ListOrdersResponse
  >;
}

export interface IOrdersServiceClient {
  listOrders(
    request: order_pb.ListOrdersRequest,
    options?: Partial<grpc.CallOptions>,
  ): grpc.ClientReadableStream<order_pb.ListOrdersResponse>;
  listOrders(
    request: order_pb.ListOrdersRequest,
    metadata?: grpc.Metadata,
    options?: Partial<grpc.CallOptions>,
  ): grpc.ClientReadableStream<order_pb.ListOrdersResponse>;
}

export class OrdersServiceClient
  extends grpc.Client
  implements IOrdersServiceClient
{
  constructor(
    address: string,
    credentials: grpc.ChannelCredentials,
    options?: Partial<grpc.ClientOptions>,
  );
  public listOrders(
    request: order_pb.ListOrdersRequest,
    options?: Partial<grpc.CallOptions>,
  ): grpc.ClientReadableStream<order_pb.ListOrdersResponse>;
  public listOrders(
    request: order_pb.ListOrdersRequest,
    metadata?: grpc.Metadata,
    options?: Partial<grpc.CallOptions>,
  ): grpc.ClientReadableStream<order_pb.ListOrdersResponse>;
}
