// package: file
// file: order.proto

/* tslint:disable */
/* eslint-disable */

import * as jspb from "google-protobuf";

export class Order extends jspb.Message { 
    getUserId(): number;
    setUserId(value: number): Order;
    getOrderId(): number;
    setOrderId(value: number): Order;
    getUsername(): string;
    setUsername(value: string): Order;
    getProductId(): number;
    setProductId(value: number): Order;
    getQuantity(): number;
    setQuantity(value: number): Order;
    getOrderDate(): string;
    setOrderDate(value: string): Order;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): Order.AsObject;
    static toObject(includeInstance: boolean, msg: Order): Order.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: Order, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): Order;
    static deserializeBinaryFromReader(message: Order, reader: jspb.BinaryReader): Order;
}

export namespace Order {
    export type AsObject = {
        userId: number,
        orderId: number,
        username: string,
        productId: number,
        quantity: number,
        orderDate: string,
    }
}

export class ListOrdersRequest extends jspb.Message { 
    getUserId(): number;
    setUserId(value: number): ListOrdersRequest;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): ListOrdersRequest.AsObject;
    static toObject(includeInstance: boolean, msg: ListOrdersRequest): ListOrdersRequest.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: ListOrdersRequest, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): ListOrdersRequest;
    static deserializeBinaryFromReader(message: ListOrdersRequest, reader: jspb.BinaryReader): ListOrdersRequest;
}

export namespace ListOrdersRequest {
    export type AsObject = {
        userId: number,
    }
}

export class ListOrdersResponse extends jspb.Message { 
    clearOrdersList(): void;
    getOrdersList(): Array<Order>;
    setOrdersList(value: Array<Order>): ListOrdersResponse;
    addOrders(value?: Order, index?: number): Order;

    serializeBinary(): Uint8Array;
    toObject(includeInstance?: boolean): ListOrdersResponse.AsObject;
    static toObject(includeInstance: boolean, msg: ListOrdersResponse): ListOrdersResponse.AsObject;
    static extensions: {[key: number]: jspb.ExtensionFieldInfo<jspb.Message>};
    static extensionsBinary: {[key: number]: jspb.ExtensionFieldBinaryInfo<jspb.Message>};
    static serializeBinaryToWriter(message: ListOrdersResponse, writer: jspb.BinaryWriter): void;
    static deserializeBinary(bytes: Uint8Array): ListOrdersResponse;
    static deserializeBinaryFromReader(message: ListOrdersResponse, reader: jspb.BinaryReader): ListOrdersResponse;
}

export namespace ListOrdersResponse {
    export type AsObject = {
        ordersList: Array<Order.AsObject>,
    }
}
