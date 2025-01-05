import { createClient } from '@connectrpc/connect';
import { OrdersService } from '@/_generated/order_pb';
import { transport } from '@/lib/connect_client';

const client = createClient(OrdersService, transport);

export async function* orderFetcher(userId: bigint) {
  for await (const response of client.listOrders({ userId: userId })) {
    yield response.Order;
  }
}

export const createOrder = async (
  userId: number,
  productId: number,
  quantity: number,
) => {
  const response = await client.createOrder({
    userId: BigInt(userId),
    productId: BigInt(productId),
    quantity: BigInt(quantity),
  });
  return response.Order;
};
