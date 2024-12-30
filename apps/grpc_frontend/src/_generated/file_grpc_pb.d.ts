// package: file
// file: file.proto

/* tslint:disable */
/* eslint-disable */

import * as grpc from "@grpc/grpc-js";
import * as file_pb from "./file_pb";

interface IFileServiceService extends grpc.ServiceDefinition<grpc.UntypedServiceImplementation> {
    listFiles: IFileServiceService_IListFiles;
}

interface IFileServiceService_IListFiles extends grpc.MethodDefinition<file_pb.ListFilesRequest, file_pb.ListFilesResponse> {
    path: "/file.FileService/ListFiles";
    requestStream: false;
    responseStream: false;
    requestSerialize: grpc.serialize<file_pb.ListFilesRequest>;
    requestDeserialize: grpc.deserialize<file_pb.ListFilesRequest>;
    responseSerialize: grpc.serialize<file_pb.ListFilesResponse>;
    responseDeserialize: grpc.deserialize<file_pb.ListFilesResponse>;
}

export const FileServiceService: IFileServiceService;

export interface IFileServiceServer extends grpc.UntypedServiceImplementation {
    listFiles: grpc.handleUnaryCall<file_pb.ListFilesRequest, file_pb.ListFilesResponse>;
}

export interface IFileServiceClient {
    listFiles(request: file_pb.ListFilesRequest, callback: (error: grpc.ServiceError | null, response: file_pb.ListFilesResponse) => void): grpc.ClientUnaryCall;
    listFiles(request: file_pb.ListFilesRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: file_pb.ListFilesResponse) => void): grpc.ClientUnaryCall;
    listFiles(request: file_pb.ListFilesRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: file_pb.ListFilesResponse) => void): grpc.ClientUnaryCall;
}

export class FileServiceClient extends grpc.Client implements IFileServiceClient {
    constructor(address: string, credentials: grpc.ChannelCredentials, options?: Partial<grpc.ClientOptions>);
    public listFiles(request: file_pb.ListFilesRequest, callback: (error: grpc.ServiceError | null, response: file_pb.ListFilesResponse) => void): grpc.ClientUnaryCall;
    public listFiles(request: file_pb.ListFilesRequest, metadata: grpc.Metadata, callback: (error: grpc.ServiceError | null, response: file_pb.ListFilesResponse) => void): grpc.ClientUnaryCall;
    public listFiles(request: file_pb.ListFilesRequest, metadata: grpc.Metadata, options: Partial<grpc.CallOptions>, callback: (error: grpc.ServiceError | null, response: file_pb.ListFilesResponse) => void): grpc.ClientUnaryCall;
}
