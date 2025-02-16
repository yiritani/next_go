// @generated by protoc-gen-es v2.2.3 with parameter "target=ts"
// @generated from file proto/v1/ping.proto (package api.v1.ping, syntax proto3)
/* eslint-disable */

import type { GenFile, GenMessage, GenService } from "@bufbuild/protobuf/codegenv1";
import { fileDesc, messageDesc, serviceDesc } from "@bufbuild/protobuf/codegenv1";
import { file_google_api_annotations } from "../../google/api/annotations_pb";
import type { Message } from "@bufbuild/protobuf";

/**
 * Describes the file proto/v1/ping.proto.
 */
export const file_proto_v1_ping: GenFile = /*@__PURE__*/
  fileDesc("ChNwcm90by92MS9waW5nLnByb3RvEgthcGkudjEucGluZyIeCgtQaW5nUmVxdWVzdBIPCgdtZXNzYWdlGAEgASgJIh8KDFBpbmdSZXNwb25zZRIPCgdtZXNzYWdlGAEgASgJMucBCgtQaW5nU2VydmljZRJlCgRQaW5nEhguYXBpLnYxLnBpbmcuUGluZ1JlcXVlc3QaGS5hcGkudjEucGluZy5QaW5nUmVzcG9uc2UiKILT5JMCIjoBKiIdL2FwaS52MS5waW5nLlBpbmdTZXJ2aWNlL1BpbmcScQoKUGluZ1NhbXBsZRIYLmFwaS52MS5waW5nLlBpbmdSZXF1ZXN0GhkuYXBpLnYxLnBpbmcuUGluZ1Jlc3BvbnNlIi6C0+STAig6ASoiIy9hcGkudjEucGluZy5QaW5nU2VydmljZS9QaW5nU2FtcGxlQi9aLWdycGNfYmFja2VuZC9zcmMvX2dlbmVyYXRlZC9wcm90by92MTtwcm90b192MWIGcHJvdG8z", [file_google_api_annotations]);

/**
 * @generated from message api.v1.ping.PingRequest
 */
export type PingRequest = Message<"api.v1.ping.PingRequest"> & {
  /**
   * @generated from field: string message = 1;
   */
  message: string;
};

/**
 * Describes the message api.v1.ping.PingRequest.
 * Use `create(PingRequestSchema)` to create a new message.
 */
export const PingRequestSchema: GenMessage<PingRequest> = /*@__PURE__*/
  messageDesc(file_proto_v1_ping, 0);

/**
 * @generated from message api.v1.ping.PingResponse
 */
export type PingResponse = Message<"api.v1.ping.PingResponse"> & {
  /**
   * @generated from field: string message = 1;
   */
  message: string;
};

/**
 * Describes the message api.v1.ping.PingResponse.
 * Use `create(PingResponseSchema)` to create a new message.
 */
export const PingResponseSchema: GenMessage<PingResponse> = /*@__PURE__*/
  messageDesc(file_proto_v1_ping, 1);

/**
 * @generated from service api.v1.ping.PingService
 */
export const PingService: GenService<{
  /**
   * @generated from rpc api.v1.ping.PingService.Ping
   */
  ping: {
    methodKind: "unary";
    input: typeof PingRequestSchema;
    output: typeof PingResponseSchema;
  },
  /**
   * @generated from rpc api.v1.ping.PingService.PingSample
   */
  pingSample: {
    methodKind: "unary";
    input: typeof PingRequestSchema;
    output: typeof PingResponseSchema;
  },
}> = /*@__PURE__*/
  serviceDesc(file_proto_v1_ping, 0);

