import { useState } from 'react';
import { createClient } from '@connectrpc/connect';
import { PingService } from '@/_generated/ping_pb';
import { transport } from '@/lib/connect_client';

const Ping = () => {
  const [fetchedData, setFetchedData] = useState<string>('not yet fetched');
  const client = createClient(PingService, transport);
  const fetch = async () => {
    const data = await client.ping({});
    setFetchedData(data.message);
  };

  return (
    <div>
      <div className="flex space-x-3">
        <button
          onClick={fetch}
          className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        >
          Fetch Data
        </button>
        <button
          onClick={() => setFetchedData('reset')}
          className="bg-red-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        >
          Reset
        </button>
      </div>
      <div>{fetchedData ? <p>{fetchedData}</p> : <p>No data</p>}</div>
    </div>
  );
};

export default Ping;
