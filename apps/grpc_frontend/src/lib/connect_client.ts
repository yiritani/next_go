import { createConnectTransport } from '@connectrpc/connect-web';

export const transport = createConnectTransport({
  baseUrl: process.env.NEXT_PUBLIC_BACKEND_URL || 'env not set',
});
