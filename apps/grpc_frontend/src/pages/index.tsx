import Ping from "@/components/ping";

export default function Home() {
  return (
    <>
      <div className="flex flex-col h-screen">
        <div className="flex-2 bg-red-200 flex items-start justify-start pl-10 pt-10">
          <Ping/>
        </div>
        {/*<div className="flex-2 bg-green-200 flex items-start justify-start pl-10 pt-10">*/}
        {/*  <Users users={users}/>*/}
        {/*</div>*/}
        {/*<div className="flex-1 bg-blue-200 flex items-start justify-start pl-10 pt-10">*/}
        {/*  <Orders users={users}/>*/}
        {/*</div>*/}
      </div>
    </>
  );
}
