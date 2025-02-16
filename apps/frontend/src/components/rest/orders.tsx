import { useEffect, useState, useCallback } from 'react';
import { Order } from '@/types/order';
import { User } from '@/types/user';
import { z } from 'zod';
import { Controller, useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import AddOrder from '@/components/rest/form/addOrder';

type Props = {
  users: User[];
};

const schema = z.object({
  userId: z.number(),
});
type FormValues = z.infer<typeof schema>;

const Orders = (props: Props) => {
  const { control, watch } = useForm<FormValues>({
    mode: 'onBlur',
    resolver: zodResolver(schema),
    defaultValues: {
      userId: 1,
    },
  });
  const selectedUserId = watch('userId');

  const [streamedOrders, setStreamedOrders] = useState<Order[]>([]);
  const [isStreaming, setIsStreaming] = useState(false);

  const reconnectStream = useCallback(async () => {
    if (!selectedUserId) return;

    setStreamedOrders([]);

    const res = await fetch(
      `${process.env.NEXT_PUBLIC_API_URL_GRPC}/api.v1.order.OrdersService/ListOrders`,
      {
        method: 'POST',
        body: JSON.stringify({ user_id: selectedUserId }),
      },
    );

    const data = await res.json();
    setStreamedOrders(data.orders);

    setIsStreaming(true);

    return () => {
      setIsStreaming(false);
    };
  }, [selectedUserId]);

  useEffect(() => {
    reconnectStream();
  }, [selectedUserId, reconnectStream]);

  return (
    <>
      <div className="container mx-auto px-4">
        <div className={'flex justify-between'}>
          <Controller
            control={control}
            name={'userId'}
            render={({ field }) => (
              <select
                {...field}
                className="border border-gray-300 rounded-md p-2"
              >
                {props.users &&
                  props.users.map((user) => (
                    <option key={user.user_id} value={user.user_id}>
                      {user.username}
                    </option>
                  ))}
              </select>
            )}
          />
          <div className={'pr-6'}>
            <AddOrder
              userId={selectedUserId}
              onOrderCreated={reconnectStream}
            />
          </div>
        </div>
        <h1 className="text-2xl font-bold mb-4 text-left">User Data</h1>
        <p>streamで1秒ごとに取得{isStreaming ?? ' 取得中'}</p>
        {streamedOrders.length > 0 ? (
          <div className="max-w-screen-md ml-0">
            <table className="table-auto w-full border-collapse border border-gray-300">
              <thead>
                <tr className="bg-gray-200">
                  <th className="border border-gray-300 px-4 py-2">User ID</th>
                  <th className="border border-gray-300 px-4 py-2">Username</th>
                  <th className="border border-gray-300 px-4 py-2">
                    Product ID
                  </th>
                  <th className="border border-gray-300 px-4 py-2">Quantity</th>
                  <th className="border border-gray-300 px-4 py-2">
                    Order Date
                  </th>
                </tr>
              </thead>
              <tbody>
                {streamedOrders &&
                  streamedOrders.map((order) => (
                    <tr key={order.order_id} className="hover:bg-gray-100">
                      <td className="border border-gray-300 px-4 py-2 text-center">
                        {order.user_id}
                      </td>
                      <td className="border border-gray-300 px-4 py-2 text-center">
                        {order.username}
                      </td>
                      <td className="border border-gray-300 px-4 py-2 text-center">
                        {order.product_id}
                      </td>
                      <td className="border border-gray-300 px-4 py-2 text-center">
                        {order.quantity}
                      </td>
                      <td className="border border-gray-300 px-4 py-2 text-center">
                        {order.order_date}
                      </td>
                    </tr>
                  ))}
              </tbody>
            </table>
          </div>
        ) : (
          <p className="text-gray-500 text-center">No data available</p>
        )}
      </div>
    </>
  );
};

export default Orders;
