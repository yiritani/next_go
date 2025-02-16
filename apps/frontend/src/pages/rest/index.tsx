import Ping from '@/components/rest/ping';
import Users from '@/components/rest/users';
import Orders from '@/components/rest/orders';
import { useState } from 'react';
import { User } from '@/types/user';
import useSWR from 'swr';
import { userFetcher } from '@/hooks/rest/user-hook';

export default function Rest() {
  const [users, setUsers] = useState<User[]>([]);
  const { data, error } = useSWR<User[]>(
    `${process.env.NEXT_PUBLIC_API_URL_GRPC}/api.v1.user.UserService/ListUsers`,
    userFetcher,
  );
  if (data && users.length === 0) {
    setUsers(data);
  }

  return (
    <>
      <div className="flex space-x-3 bg-blue-200">
        <h1>
          Welcome to the{' '}
          <span className="text-blue-600">
            <b>REST</b>
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
