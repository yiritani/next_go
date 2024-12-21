import {useState} from "react";
import {GoogleAuth} from "google-auth-library";

export default function Home() {

  const [fetchedData, setFetchedData] = useState(null);
  const fetchPing = async () => {
    console.log('%o', process.env.NEXT_PUBLIC_API_URL);
    // const backendUrl = process.env.NEXT_PUBLIC_API_URL;
    const backendUrl = `https://next-go-cloudrun-backend-1063239685310.us-central1.run.app`;
    // const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/ping`);

    const auth = new GoogleAuth();
    const client = await auth.getIdTokenClient(backendUrl!);

    const res = await client.request({method: "GET", url: `${backendUrl}/ping`});
    console.log('%o', res);
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
      <div className={`font-sans text-xl`}>
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
