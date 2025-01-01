import { createConnectTransport } from '@connectrpc/connect-web';

export const transport = createConnectTransport({
  baseUrl: process.env.NEXT_PUBLIC_API_URL || 'env not set',
});
