import { GetStaticPaths } from "next";
import * as querystring from "node:querystring";

type Props = {
  systemId: string;
};
const systemPage = (props: Props) => {
  const systemId = props.systemId;

  return <div>system page{systemId}</div>;
};

export default systemPage;
