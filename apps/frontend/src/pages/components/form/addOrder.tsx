import { z } from 'zod';
import { SubmitHandler, useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import axios from 'axios';

const postSchema = z.object({
  ProductID: z.preprocess(
    (val) => (typeof val === 'string' ? parseInt(val, 10) : val),
    z.number().positive().int(),
  ),
});
type IFormValues = z.infer<typeof postSchema>;

type Props = {
  userId: number;
};

export const AddOrder = (props: Props) => {
  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<IFormValues>({
    mode: 'onBlur',
    resolver: zodResolver(postSchema),
  });

  const onSubmit: SubmitHandler<IFormValues> = async (data) => {
    const postData = {
      ...data,
      UserID: props.userId,
      Quantity: 1,
      ProductID: data.ProductID,
      OrderDate: new Date().toISOString().split('T')[0],
    };
    console.log('postData', postData);

    try {
      const res = await axios.post(
        `${process.env.NEXT_PUBLIC_API_URL}/api/v1/order/create`,
        postData,
      );
      console.log('Order created successfully:', res.data);
    } catch (err) {
      console.error('Error creating order:', err);
    }
  };

  return (
    <div>
      {errors.ProductID && (
        <p className="text-red-500">Product ID must be a positive integer</p>
      )}
      <form onSubmit={handleSubmit(onSubmit)}>
        <input
          {...register('ProductID')}
          placeholder="Product ID"
          className="border border-gray-300 rounded-md p-2 mb-2"
        />
        <button
          type="submit"
          className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        >
          Register
        </button>
      </form>
    </div>
  );
};
