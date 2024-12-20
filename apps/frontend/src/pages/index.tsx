import {useState} from "react";

export default function Home() {
  const [fetchedData, setFetchedData] = useState(null);
  const fetchPing = async () => {
    console.log('%o', process.env.NEXT_PUBLIC_API_URL);
    const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/ping`);
    // const res = await fetch(`https://next-go-backend-1063239685310.us-central1.run.app/ping`);
    const data = await res.json();
    setFetchedData(data.message);
  }

  return (
    <div
      className={`flex flex-col items-center justify-center min-h-screen`}
    >
      <button
        onClick={fetchPing}
        className={`bg-blue-500 text-white px-4 py-2 rounded-md`}
      >
        <div>
          click
        </div>
      </button>
      <div
        className={`font-sans text-xl`}
      >
        {fetchedData ? fetchedData : "no data"}
      </div>
      <button
        onClick={() => setFetchedData(null)}
        className={`bg-red-500 text-white px-4 py-2 rounded-md`}
      >
        <div>
          reset
        </div>
      </button>
    </div>
  );
}
