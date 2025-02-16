import { User } from '@/types/user';

export const userFetcher = (url: string): Promise<User[]> =>
  fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ }),
  })
    .then((res) => res.json())
    .then((data) => data.users);
