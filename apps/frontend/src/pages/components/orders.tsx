import useSWR from "swr";
import {useEffect, useState} from "react";
import {orderFetcher} from "@/hooks/order-hook";
import {Order} from "@/types/order";
import {User} from "@/types/user";
import {z} from "zod";
import {Controller, useForm} from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";

type Props = {
  users: User[];
}

const schema = z.object({
  userId: z.number(),
});
type FormValues = z.infer<typeof schema>;

export const Orders = (props: Props) => {
  const {
    control,
    watch,
  } = useForm<FormValues>({
    mode: "onBlur",
    resolver: zodResolver(schema),
    defaultValues: {
      userId: 1,
    }
  });

  const selectedUserId = watch("userId");

  const [fetchedData, setFetchedData] = useState<Order[]>([]);
  const { data, error } = useSWR<Order[]>(
    selectedUserId
      ? `${process.env.NEXT_PUBLIC_API_URL}/api/v1/order/user/${selectedUserId}`
      : null,
    orderFetcher
  );

  const register = async () => {
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/api/v1/order`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        user_id: selectedUserId,
        product_id: 1,
        quantity: 1,
      }),
    })
  }

  useEffect(() => {
    if (data) {
      setFetchedData(data);
    }
  }, [data]);

  return (
    <>
      <div className="container mx-auto px-4">
        <Controller
          control={control}
          name={"userId"}
          render={({ field }) => (
            <select
              {...field}
              className="border border-gray-300 rounded-md p-2"
            >
              {props.users.map((user) => (
                <option key={user.user_id} value={user.user_id}>
                  {user.username}
                </option>
              ))}
            </select>
          )}
        />
        <h1 className="text-2xl font-bold mb-4 text-left">User Data</h1>
        {error && <p className="text-red-500 text-left">Error loading data</p>}
        {fetchedData.length > 0 ? (
          <div className="max-w-screen-md ml-0">
            <table className="table-auto w-full border-collapse border border-gray-300">
              <thead>
              <tr className="bg-gray-200">
                <th className="border border-gray-300 px-4 py-2">User ID</th>
                <th className="border border-gray-300 px-4 py-2">Username</th>
                <th className="border border-gray-300 px-4 py-2">Product ID</th>
                <th className="border border-gray-300 px-4 py-2">Quantity</th>
                <th className="border border-gray-300 px-4 py-2">Order Date</th>
              </tr>
              </thead>
              <tbody>
              {fetchedData.map((user) => (
                <tr key={user.product_id} className="hover:bg-gray-100">
                  <td className="border border-gray-300 px-4 py-2 text-center">
                    {user.user_id}
                  </td>
                  <td className="border border-gray-300 px-4 py-2 text-center">
                    {user.username}
                  </td>
                  <td className="border border-gray-300 px-4 py-2 text-center">
                    {user.product_id}
                  </td>
                  <td className="border border-gray-300 px-4 py-2 text-center">
                    {user.quantity}
                  </td>
                  <td className="border border-gray-300 px-4 py-2 text-center">
                    {user.order_date}
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
      <form>
        <div>
          <input name={"userId"} />
          <button onClick={register}>Register</button>
        </div>
      </form>
    </>
  );
};
