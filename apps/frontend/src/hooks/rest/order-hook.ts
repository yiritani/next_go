import { Order } from '@/types/order';

export const orderFetcher = (url: string, user_id: number): Promise<Order[]> =>
  fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      user_id: user_id,
    }),
  })
    .then((res) => res.json())
    .then((data) => data.orders);
