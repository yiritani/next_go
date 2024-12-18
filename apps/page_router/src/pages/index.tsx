import React, { useEffect, useState } from "react";
import TextField from "@mui/material/TextField";
import Button from "@mui/material/Button";
import { useRouter } from "next/router";
import { GetStaticProps } from "next";
import axios from "axios";
import Table from "@mui/material/Table";
import TableBody from "@mui/material/TableBody";
import TableCell from "@mui/material/TableCell";
import TableContainer from "@mui/material/TableContainer";
import TableHead from "@mui/material/TableHead";
import TableRow from "@mui/material/TableRow";
import Paper from "@mui/material/Paper";
import { System } from "@/type/system";

export default function Home() {
  const router = useRouter();

  const [data, setData] = useState<string>();
  const [systems, setSystems] = useState<System[]>([]);
  const apiFetch = async () => {
    const response = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/ping`);
    const data = await response.json();
    setData(data.message);
  };

  // const systemFetch = async (limit: number, offset: number) => {
  //   const response = await fetch(
  //     `${process.env.NEXT_PUBLIC_API_URL}/list-systems?limit=${limit}&offset=${offset}`,
  //   );
  //   const data = await response.json();
  //   setSystems(data);
  // };
  //
  // useEffect(() => {
  //   systemFetch(10, 0);
  // }, []);

  const systemPage = (systemId: string) => {
    router.push(`systems/${systemId}`);
  };

  return (
    <>
      <div className="p-8">
        <div className="flex">
          <div className="relative flex place-items-center before:absolute before:h-[300px] before:w-full sm:before:w-[480px] before:-translate-x-1/2 before:rounded-full before:bg-gradient-radial before:from-white before:to-transparent before:blur-2xl before:content-[''] after:absolute after:-z-20 after:h-[180px] after:w-full sm:after:w-[240px] after:translate-x-1/3 after:bg-gradient-conic after:from-sky-200 after:via-blue-200 after:blur-2xl after:content-[''] before:dark:bg-gradient-to-br before:dark:from-transparent before:dark:to-blue-700/10 after:dark:from-sky-900 after:dark:via-[#0141ff]/40 before:lg:h-[360px]">
            <Button
              className="relative z-10 flex items-center justify-center w-24 h-24 rounded-full bg-gradient-to-br from-sky-500 to-blue-500/80 text-white shadow-lg dark:from-sky-900 dark:to-blue-900/80 dark:text-white"
              onClick={apiFetch}
            >
              <span className="text-4xl">🚀</span>
            </Button>
          </div>
          {data && (
            <div>
              <p className="absolute z-10 text-2xl font-semibold text-black dark:text-white">
                {data}
              </p>
            </div>
          )}
        </div>

        <div className="flex items-center">
          {systems.length > 0 && (
            <TableContainer component={Paper}>
              <Table sx={{ minWidth: 650 }} aria-label="simple table">
                <TableHead>
                  <TableRow>
                    <TableCell>SystemName</TableCell>
                    <TableCell>ID&nbsp;(g)</TableCell>
                  </TableRow>
                </TableHead>
                <TableBody>
                  {systems.map((row) => (
                    <TableRow
                      key={row.ID}
                      sx={{ "&:last-child td, &:last-child th": { border: 0 } }}
                    >
                      <TableCell component="th" scope="row">
                        {row.SystemName}
                      </TableCell>
                      <TableCell onClick={() => systemPage(row.ID)}>
                        {row.ID}
                      </TableCell>
                    </TableRow>
                  ))}
                </TableBody>
              </Table>
            </TableContainer>
          )}
        </div>
      </div>
    </>
  );
}
