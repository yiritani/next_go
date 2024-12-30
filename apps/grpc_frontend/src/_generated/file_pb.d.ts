// package: file
// file: file.proto

/* tslint:disable */
/* eslint-disable */

import * as jspb from 'google-protobuf';

export class ListFilesRequest extends jspb.Message {
  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): ListFilesRequest.AsObject;
  static toObject(
    includeInstance: boolean,
    msg: ListFilesRequest,
  ): ListFilesRequest.AsObject;
  static extensions: { [key: number]: jspb.ExtensionFieldInfo<jspb.Message> };
  static extensionsBinary: {
    [key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>;
  };
  static serializeBinaryToWriter(
    message: ListFilesRequest,
    writer: jspb.BinaryWriter,
  ): void;
  static deserializeBinary(bytes: Uint8Array): ListFilesRequest;
  static deserializeBinaryFromReader(
    message: ListFilesRequest,
    reader: jspb.BinaryReader,
  ): ListFilesRequest;
}

export namespace ListFilesRequest {
  export type AsObject = {};
}

export class ListFilesResponse extends jspb.Message {
  clearFilenamesList(): void;
  getFilenamesList(): Array<string>;
  setFilenamesList(value: Array<string>): ListFilesResponse;
  addFilenames(value: string, index?: number): string;

  serializeBinary(): Uint8Array;
  toObject(includeInstance?: boolean): ListFilesResponse.AsObject;
  static toObject(
    includeInstance: boolean,
    msg: ListFilesResponse,
  ): ListFilesResponse.AsObject;
  static extensions: { [key: number]: jspb.ExtensionFieldInfo<jspb.Message> };
  static extensionsBinary: {
    [key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>;
  };
  static serializeBinaryToWriter(
    message: ListFilesResponse,
    writer: jspb.BinaryWriter,
  ): void;
  static deserializeBinary(bytes: Uint8Array): ListFilesResponse;
  static deserializeBinaryFromReader(
    message: ListFilesResponse,
    reader: jspb.BinaryReader,
  ): ListFilesResponse;
}

export namespace ListFilesResponse {
  export type AsObject = {
    filenamesList: Array<string>;
  };
}
