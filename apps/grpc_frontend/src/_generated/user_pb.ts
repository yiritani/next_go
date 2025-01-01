// @generated by protoc-gen-es v2.2.3 with parameter "target=ts"
// @generated from file user.proto (package grpc_backend.v1, syntax proto3)
/* eslint-disable */

import type { GenFile, GenMessage, GenService } from "@bufbuild/protobuf/codegenv1";
import { fileDesc, messageDesc, serviceDesc } from "@bufbuild/protobuf/codegenv1";
import type { Message } from "@bufbuild/protobuf";

/**
 * Describes the file user.proto.
 */
export const file_user: GenFile = /*@__PURE__*/
  fileDesc("Cgp1c2VyLnByb3RvEg9ncnBjX2JhY2tlbmQudjEiOAoEVXNlchIPCgd1c2VyX2lkGAEgASgDEhAKCHVzZXJuYW1lGAIgASgJEg0KBWVtYWlsGAMgASgJIhEKD0xpc3RVc2VyUmVxdWVzdCI4ChBMaXN0VXNlclJlc3BvbnNlEiQKBXVzZXJzGAEgAygLMhUuZ3JwY19iYWNrZW5kLnYxLlVzZXIyXwoLVXNlclNlcnZpY2USUAoJTGlzdFVzZXJzEiAuZ3JwY19iYWNrZW5kLnYxLkxpc3RVc2VyUmVxdWVzdBohLmdycGNfYmFja2VuZC52MS5MaXN0VXNlclJlc3BvbnNlQiNaIWdycGNfYmFja2VuZC9zcmMvX2dlbmVyYXRlZC9wcm90b2IGcHJvdG8z");

/**
 * @generated from message grpc_backend.v1.User
 */
export type User = Message<"grpc_backend.v1.User"> & {
  /**
   * @generated from field: int64 user_id = 1;
   */
  userId: bigint;

  /**
   * @generated from field: string username = 2;
   */
  username: string;

  /**
   * @generated from field: string email = 3;
   */
  email: string;
};

/**
 * Describes the message grpc_backend.v1.User.
 * Use `create(UserSchema)` to create a new message.
 */
export const UserSchema: GenMessage<User> = /*@__PURE__*/
  messageDesc(file_user, 0);

/**
 * @generated from message grpc_backend.v1.ListUserRequest
 */
export type ListUserRequest = Message<"grpc_backend.v1.ListUserRequest"> & {
};

/**
 * Describes the message grpc_backend.v1.ListUserRequest.
 * Use `create(ListUserRequestSchema)` to create a new message.
 */
export const ListUserRequestSchema: GenMessage<ListUserRequest> = /*@__PURE__*/
  messageDesc(file_user, 1);

/**
 * @generated from message grpc_backend.v1.ListUserResponse
 */
export type ListUserResponse = Message<"grpc_backend.v1.ListUserResponse"> & {
  /**
   * @generated from field: repeated grpc_backend.v1.User users = 1;
   */
  users: User[];
};

/**
 * Describes the message grpc_backend.v1.ListUserResponse.
 * Use `create(ListUserResponseSchema)` to create a new message.
 */
export const ListUserResponseSchema: GenMessage<ListUserResponse> = /*@__PURE__*/
  messageDesc(file_user, 2);

/**
 * @generated from service grpc_backend.v1.UserService
 */
export const UserService: GenService<{
  /**
   * @generated from rpc grpc_backend.v1.UserService.ListUsers
   */
  listUsers: {
    methodKind: "unary";
    input: typeof ListUserRequestSchema;
    output: typeof ListUserResponseSchema;
  },
}> = /*@__PURE__*/
  serviceDesc(file_user, 0);
