import { Ping } from '@/pages/components/ping';
import { Users } from '@/pages/components/users';
import { Orders } from '@/pages/components/orders';
import { useState } from 'react';
import { User } from '@/types/user';
import useSWR from 'swr';
import { userFetcher } from '@/hooks/user-hook';

export default function Home() {
  const [users, setUsers] = useState<User[]>([]);
  const { data, error } = useSWR<User[]>(
    `${process.env.NEXT_PUBLIC_API_URL}/api/v1/user/list`,
    userFetcher,
  );
  if (data && users.length === 0) {
    setUsers(data);
  }

  return (
    <div className="flex flex-col h-screen">
      {error && <p className="text-red-500 text-center">Error loading data</p>}
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
  );
}
