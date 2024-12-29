import {Order} from "@/types/order";

export const orderFetcher = (url: string): Promise<Order[]> =>
  fetch(url)
    .then((res) => res.json())
    .then((data) => data.orders);
