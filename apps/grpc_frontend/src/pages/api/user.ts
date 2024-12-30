// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
import type { NextApiRequest, NextApiResponse } from "next";
import {UsersServiceClient} from "@/_generated/user_grpc_pb";
import {ListUsersRequest} from "@/_generated/user_pb";
import * as grpc from '@grpc/grpc-js';

export default function handler(
  req: NextApiRequest,
  res: NextApiResponse,
) {
  const client = new UsersServiceClient('host.docker.internal:50051', grpc.credentials.createInsecure());

  const request = new ListUsersRequest();
  const metadata = new grpc.Metadata();

  client.listUsers(request, metadata, (err, response) => {
    if (err) {
      res.status(500).json({ error: err.message });
    } else {
      res.status(200).json(response.toObject());
    }
  });
}
