import {PropsWithChildren, useState} from "react";
import { ApolloProvider } from "@apollo/client";
import {apolloClient} from "../apollo/apolloClient";

export const WithApollo = ({children}: PropsWithChildren) => {
  return (
    <ApolloProvider client={apolloClient}>
      {children}
    </ApolloProvider>
  );
}