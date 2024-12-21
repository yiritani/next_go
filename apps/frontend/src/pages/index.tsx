import {useState} from "react";
import {AnyAuthClient, GoogleAuth} from "google-auth-library";

type Props = {
  client: AnyAuthClient;
}

export default function Home({client}: Props) {

  const [fetchedData, setFetchedData] = useState<string>('');
  const fetchPing = async () => {
    console.log('%o', process.env.NEXT_PUBLIC_API_URL);
    // const backendUrl = process.env.NEXT_PUBLIC_API_URL;
    const backendUrl = `http://localhost:8080`;
    const res = await client.request({method: "GET", url: `${backendUrl}/ping`});
    console.log('resres', res);
    setFetchedData('a');
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
        onClick={() => setFetchedData('')}
        className={`bg-red-500 text-white px-4 py-2 rounded-md`}
      >
        <div>
          reset
        </div>
      </button>
    </div>
  );
}

export const getServerSideProps = async () => {
  const auth = new GoogleAuth({
    scopes: 'https://www.googleapis.com/auth/cloud-platform'
  });
  const client = await auth.getClient();
  const backendUrl = `https://next-go-cloudrun-backend-1063239685310.us-central1.run.app`;
  const res = await client.request({method: "GET", url: `${backendUrl}/ping`});
  console.log(res);
  return {
    props: {
    }
  }
}