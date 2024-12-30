import { User } from '@/types/user';

export const userFetcher = (url: string): Promise<User[]> =>
  fetch(url)
    .then((res) => res.json())
    .then((data) => data.usersList);
