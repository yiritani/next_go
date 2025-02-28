import useSWR from 'swr';
import { User } from '@/_generated/proto/v1/user_pb';
import { userFetcher } from '@/hooks/grpc/user-hook';
import { useState } from 'react';
import Users from '@/components/grpc/users';
import Orders from '@/components/grpc/orders';
import Ping from '@/components/grpc/ping';

export default function Grpc() {
  const [users, setUsers] = useState<User[]>([]);
  const { data, error } = useSWR('users', userFetcher);
  if (data && users.length === 0) {
    setUsers(data);
  }

  return (
    <>
      <div className="flex space-x-3 bg-red-200">
        <h1>
          Welcome to the{' '}
          <span className="text-red-600">
            <b>gRPC</b>
          </span>
        </h1>
      </div>
      <div className="flex flex-col h-screen">
        {error && (
          <p className="text-red-500 text-center">Error loading data</p>
        )}
        <div className="flex-2 bg-red-200 flex items-start justify-start pl-10 pt-10">
          <Ping />
        </div>
        <div className="flex-2 bg-green-200 flex items-start justify-start pl-10 pt-10">
          <Users users={users} />
        </div>
        <div className="flex-1 bg-blue-200 flex items-start justify-start pl-10 pt-10">
          <Orders users={users} />
        </div>
      </div>
    </>
  );
}
