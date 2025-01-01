import { createClient } from '@connectrpc/connect';
import { OrdersService } from '@/_generated/order_pb';
import { transport } from '@/lib/connect_client';

const client = createClient(OrdersService, transport);

export async function* orderFetcher(userId: bigint) {
  for await (const response of client.listOrders({ userId: userId })) {
    yield response.Order;
  }
}
