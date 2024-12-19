import Image from "next/image";
import { Geist, Geist_Mono } from "next/font/google";
import {useState} from "react";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export default function Home() {
  const [fetchedData, setFetchedData] = useState(null);
  const fetchPing = async () => {
    const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/ping`);
    const data = await res.json();
    console.log(data);
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
