import { useState } from 'react';

const Ping = () => {
  const [fetchedData, setFetchedData] = useState(null);
  const fetchPing = async () => {
    const res = await fetch(
      `${process.env.NEXT_PUBLIC_API_URL_GRPC}/api.v1.ping.PingService/Ping`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ message: 'Ping' }),
      },
    );
    const data = await res.json();
    setFetchedData(data.message);
  };

  return (
    <div>
      <div className="flex space-x-3">
        <button
          onClick={fetchPing}
          className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded"
        >
          Fetch Data
        </button>
        <button
          onClick={() => setFetchedData(null)}
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
