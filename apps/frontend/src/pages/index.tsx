import Grpc from '@/pages/grpc';
import Rest from '@/pages/rest';

export default function Home() {
  return (
    <div className="flex h-screen">
      <div className="flex-1">
        <Rest />
      </div>
      <div className="w-[1px] bg-gray-400"></div>
      <div className="flex-1">
        <Grpc />
      </div>
    </div>
  );
}
