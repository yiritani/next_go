import { User } from '@/_generated/user_pb';

type Props = {
  users: User[];
};

const Users = (props: Props) => {
  return (
    <div>
      <div className="flex space-x-3">
        <h1>Use SWR</h1>
      </div>
      <div>
        {props.users &&
          props.users.length > 0 &&
          props.users.map((user) => {
            return (
              <div key={user.userId} className="flex space-x-3">
                <p>{user.userId}</p>
                <p>{user.username}</p>
                <p>{user.email}</p>
              </div>
            );
          })}
      </div>
    </div>
  );
};

export default Users;
