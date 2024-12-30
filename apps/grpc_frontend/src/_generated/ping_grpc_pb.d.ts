// package: file
// file: ping.proto

/* tslint:disable */
/* eslint-disable */

import * as grpc from "@grpc/grpc-js";
import * as ping_pb from "./ping_pb";

interface IPingServiceService extends grpc.ServiceDefinition<grpc.UntypedServiceImplementation> {
    ping: IPingServiceService_IPing;
}

interface IPingServiceService_IPing extends grpc.MethodDefinition<ping_pb.PingRequest, ping_pb.PingResponse> {
    path: "/file.PingService/Ping";
    requestStream: false;
    responseStream: false;
    requestSerialize: grpc.serialize<ping_pb.PingRequest>;
    requestDeserialize: grpc.deserialize<ping_pb.PingRequest>;
    responseSerialize: grpc.serialize<ping_pb.PingResponse>;
    responseDeserialize: grpc.deserialize<ping_pb.PingResponse>;
}

export const PingServiceService: IPingServiceService;

export interface IPingServiceServer extends grpc.UntypedServiceImplementation {
    ping: grpc.handleUnaryCall<ping_pb.PingRequest, ping_pb.PingResponse>;
}

export interface IPingServiceClient {
    ping(request: ping_pb.PingRequest, callback: (error: grpc.ServiceError | null, response: ping_pb.PingResponse) => void): grpc.ClientUnaryCall;
    ping(request: ping_pb.PingRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: ping_pb.PingResponse) => void): grpc.ClientUnaryCall;
    ping(request: ping_pb.PingRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: ping_pb.PingResponse) => void): grpc.ClientUnaryCall;
}

export class PingServiceClient extends grpc.Client implements IPingServiceClient {
    constructor(address: string, credentials: grpc.ChannelCredentials, options?: Partial<grpc.ClientOptions>);
    public ping(request: ping_pb.PingRequest, callback: (error: grpc.ServiceError | null, response: ping_pb.PingResponse) => void): grpc.ClientUnaryCall;
    public ping(request: ping_pb.PingRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: ping_pb.PingResponse) => void): grpc.ClientUnaryCall;
    public ping(request: ping_pb.PingRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: ping_pb.PingResponse) => void): grpc.ClientUnaryCall;
}
