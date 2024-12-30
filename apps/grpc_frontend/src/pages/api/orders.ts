import { NextApiRequest, NextApiResponse } from 'next';
import { OrdersServiceClient } from '@/_generated/order_grpc_pb';
import { ListOrdersRequest } from '@/_generated/order_pb';
import * as grpc from '@grpc/grpc-js';

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse,
) {
  console.log('Request orders query:', req.query);
  const client = new OrdersServiceClient(
    'host.docker.internal:50051',
    grpc.credentials.createInsecure(),
  );

  const userId = req.query.userId || 0; // クエリから userId を取得
  const request = new ListOrdersRequest();
  request.setUserId(Number(userId));

  // SSE 用のヘッダーを設定
  res.setHeader('Content-Type', 'text/event-stream');
  res.setHeader('Cache-Control', 'no-cache');
  res.setHeader('Connection', 'keep-alive');

  // ストリーミングレスポンス
  const stream = client.listOrders(request);

  stream.on('data', (response) => {
    console.log('response orders', response.toObject());
    const chunk = `data: ${JSON.stringify(response.toObject())}\n\n`;
    res.write(chunk);
  });

  stream.on('error', (err) => {
    console.error('Stream error:', err);
    const errorChunk = `event: error\ndata: ${JSON.stringify({
      error: err.message,
    })}\n\n`;
    res.write(errorChunk);
    res.end();
  });

  stream.on('end', () => {
    console.log('Stream ended');
    res.end(); // ストリーム終了
  });

  req.on('close', () => {
    console.log('Connection closed by client');
    res.end();
  });
}
