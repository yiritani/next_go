import { useEffect, useState } from 'react';
import { z } from 'zod';
import { Controller, useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { User } from '@/_generated/user_pb';
import { orderFetcher } from '@/hooks/order-hook';
import { Order } from '@/_generated/order_pb';

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
  console.log('selectedUserId', selectedUserId);

  const [orders, setOrders] = useState<Order[]>([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    const fetchOrders = async () => {
      try {
        const fetchedOrders: Order[] = [];
        for await (const order of orderFetcher(BigInt(selectedUserId))) {
          if (!order) {
            break;
          }
          fetchedOrders.push(order);
          setOrders([...fetchedOrders]);
        }
      } catch (err) {
        console.error(err);
      } finally {
        setLoading(false);
      }
    };

    fetchOrders();
  }, [selectedUserId]);

  return (
    <>
      <div className="container mx-auto px-4">
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
                  <option key={user.userId} value={Number(user.userId)}>
                    {user.username}
                  </option>
                ))}
            </select>
          )}
        />
        <h1 className="text-2xl font-bold mb-4 text-left">User Data</h1>
        {loading && <p className="text-gray-500 text-center">Loading...</p>}
        {orders.length > 0 ? (
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
                {orders &&
                  orders.map((order) => (
                    <tr key={order.orderId} className="hover:bg-gray-100">
                      <td className="border border-gray-300 px-4 py-2 text-center">
                        {order.userId}
                      </td>
                      <td className="border border-gray-300 px-4 py-2 text-center">
                        {order.username}
                      </td>
                      <td className="border border-gray-300 px-4 py-2 text-center">
                        {order.productId}
                      </td>
                      <td className="border border-gray-300 px-4 py-2 text-center">
                        {order.quantity}
                      </td>
                      <td className="border border-gray-300 px-4 py-2 text-center">
                        {order.orderDate}
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
      {/*<div className={'pr-6'}>*/}
      {/*  <AddOrder userId={selectedUserId} />*/}
      {/*</div>*/}
    </>
  );
};

export default Orders;
