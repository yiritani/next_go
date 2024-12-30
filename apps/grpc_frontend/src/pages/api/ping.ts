// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
import type { NextApiRequest, NextApiResponse } from "next";
import * as grpc from '@grpc/grpc-js';
import {PingServiceClient} from "@/_generated/ping_grpc_pb";
import {PingRequest} from "@/_generated/ping_pb";

export default function handler(
  req: NextApiRequest,
  res: NextApiResponse,
) {
  const client = new PingServiceClient('host.docker.internal:50051', grpc.credentials.createInsecure());

  const request = new PingRequest();
  const metadata = new grpc.Metadata();

  client.ping(request, metadata, (err, response) => {
    if (err) {
      res.status(500).json({ message: err.message });
    } else {
      res.status(200).json({ message: response.getMessage() });
    }
  });
}
