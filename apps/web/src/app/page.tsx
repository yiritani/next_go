'use client';
import React, { useState } from 'react';
import axios from "axios";

export default function Page(): JSX.Element {
  const [response, setResponse] = useState('');

  function apiFetch():void {
    axios.get('http://localhost:8080/ping')
      .then((res) => {
        setResponse(res.data.message);
      })
      .catch((err) => {
        console.error(err);
      });
  }

  return (
      <div className='flex'>
        <form className="flex flex-col items-center">
          <button className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" onClick={apiFetch} type="button">
            Submit
          </button>
          {response ? <p className="text-center mt-4">{response}</p> : null}
        </form>
      </div>
  );
}
