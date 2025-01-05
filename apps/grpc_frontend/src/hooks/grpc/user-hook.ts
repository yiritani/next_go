import { createClient } from '@connectrpc/connect';
import { UserService } from '@/_generated/user_pb';
import { transport } from '@/lib/connect_client';

const client = createClient(UserService, transport);

export const userFetcher = async () => {
  const response = await client.listUsers({});
  return response.users;
};
