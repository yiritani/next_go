import {useState} from "react";


export default function Home() {
  const [data, setData] = useState<string>();
  const apiFetch = async () => {
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/ping`);
    const data = await response.json();
    setData(data.message);
  }
  return (
    <>
      <div className="relative flex place-items-center before:absolute before:h-[300px] before:w-full sm:before:w-[480px] before:-translate-x-1/2 before:rounded-full before:bg-gradient-radial before:from-white before:to-transparent before:blur-2xl before:content-[''] after:absolute after:-z-20 after:h-[180px] after:w-full sm:after:w-[240px] after:translate-x-1/3 after:bg-gradient-conic after:from-sky-200 after:via-blue-200 after:blur-2xl after:content-[''] before:dark:bg-gradient-to-br before:dark:from-transparent before:dark:to-blue-700/10 after:dark:from-sky-900 after:dark:via-[#0141ff]/40 before:lg:h-[360px]">
        <button
          className="relative z-10 flex items-center justify-center w-24 h-24 rounded-full bg-gradient-to-br from-sky-500 to-blue-500/80 text-white shadow-lg dark:from-sky-900 dark:to-blue-900/80 dark:text-white"
          onClick={apiFetch}
        >
          <span className="text-4xl">🚀</span>
        </button>
      </div>
      {data && <p className="absolute z-10 text-2xl font-semibold text-black dark:text-white">{data}</p>}
    </>
  );
}
