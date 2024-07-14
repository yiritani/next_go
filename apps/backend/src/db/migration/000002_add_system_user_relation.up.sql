CREATE TYPE "system_role" AS ENUM ('pmo_owner', 'pmo_user', 'pjmo_owner', 'pjmo_user', 'vendor_pmo_owner', 'vendor_pmo_user', 'vendor_pjmo_owner', 'vendor_pjmo_user');

CREATE TABLE "systemUserRelation" (
  "system_id" UUID,
  "user_id" UUID,
  "system_role" system_role NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

ALTER TABLE "systemUserRelation" ADD CONSTRAINT "systemUserRelation_system_id_fkey" FOREIGN KEY ("system_id") REFERENCES "system" ("id") ON DELETE CASCADE;
