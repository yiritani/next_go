import { z } from 'zod';
import { SubmitHandler, useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import axios from 'axios';
import { useState, useEffect } from 'react';

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

const AddOrder = (props: Props) => {
  // 成功メッセージの表示状態を管理
  const [showSuccess, setShowSuccess] = useState(false);

  const {
    register,
    handleSubmit,
    formState: { errors },
  } = useForm<IFormValues>({
    mode: 'onBlur',
    resolver: zodResolver(postSchema),
  });

  useEffect(() => {
    let timer: ReturnType<typeof setTimeout>;
    if (showSuccess) {
      timer = setTimeout(() => {
        setShowSuccess(false);
      }, 3000);
    }
    return () => clearTimeout(timer);
  }, [showSuccess]);

  const onSubmit: SubmitHandler<IFormValues> = async (data) => {
    const postData = {
      ...data,
      UserID: Number(props.userId),
      Quantity: 1,
      ProductID: data.ProductID,
      OrderDate: new Date().toISOString().split('T')[0],
    };

    try {
      const res = await axios.post(
        `${process.env.NEXT_PUBLIC_API_URL}/api/v1/order/create`,
        postData,
      );
      if (res.status === 201) {
        setShowSuccess(true);
      }
      console.log('Order created successfully:', res.data);
    } catch (err) {
      console.error('Error creating order:', err);
    }
  };

  return (
    <div className="relative">
      <div
        className={`
          transition-opacity duration-500 
          fixed top-4 left-1/2 transform -translate-x-1/2 
          bg-green-500 text-white font-bold py-2 px-4 rounded shadow
          ${showSuccess ? 'opacity-100' : 'opacity-0 pointer-events-none'}
        `}
      >
        POST request successful
      </div>
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

export default AddOrder;
