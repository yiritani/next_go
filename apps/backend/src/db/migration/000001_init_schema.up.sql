-- Active: 1720083798212@@127.0.0.1@5432@postgres@public
CREATE TABLE "system" (
  "id" UUID PRIMARY KEY DEFAULT (gen_random_uuid()),
  "system_name" VARCHAR(255) NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "user" (
  "id" UUID PRIMARY KEY DEFAULT (gen_random_uuid()),
  "name" VARCHAR(255) NOT NULL,
  "email" VARCHAR(255) NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT (now())
);
