import {useEffect, useState} from "react";

type User = {
  userId: number;
  username: string;
  email: string;
};

export default function Home() {
  const [users, setUsers] = useState<User[]>([]);

  useEffect(() => {
    const fetchUsers = async () => {
      const response = await fetch("/api/user");
      const data = await response.json();
      setUsers(data.usersList);
    }
    fetchUsers();
  }, []);

  return (
    <div>
      <h1>ユーザ一覧</h1>
      <ul>
        {users.map((user) => (
          <li key={user.userId}>
            {user.username} ({user.email})
          </li>
        ))}
      </ul>
    </div>
  );
}
