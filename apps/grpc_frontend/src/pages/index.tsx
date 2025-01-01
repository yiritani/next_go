import { createClient } from '@connectrpc/connect';
import { createConnectTransport } from '@connectrpc/connect-web';
import { PingService } from '@/_generated/ping_pb';

const transport = createConnectTransport({
  baseUrl: 'http://localhost:8082',
});
const client = createClient(PingService, transport);

export default function Home() {
  const userFetcher = async () => {
    const data = await client.ping({}).then((res) => {
      console.log(res);
    });
    console.log(data);
  };

  return (
    <>
      <div className="flex space-x-3 bg-red-200">
        <h1>
          Welcome to the{' '}
          <span className="text-red-600">
            <b>gRPC</b>
          </span>
        </h1>
      </div>
      <div className="flex flex-col h-screen">
        {/*{error && (*/}
        {/*  <p className="text-red-500 text-center">Error loading data</p>*/}
        {/*)}*/}
        <div className="flex-2 bg-red-200 flex items-start justify-start pl-10 pt-10">
          {/*<Ping />*/}
          <button onClick={userFetcher}>Fetch</button>
        </div>
        {/*<div className="flex-2 bg-green-200 flex items-start justify-start pl-10 pt-10">*/}
        {/*  <Users users={users} />*/}
        {/*</div>*/}
        {/*<div className="flex-1 bg-blue-200 flex items-start justify-start pl-10 pt-10">*/}
        {/*  <Orders users={users} />*/}
        {/*</div>*/}
      </div>
    </>
  );
}
