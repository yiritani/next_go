FROM node:18.20.2-alpine AS base

# This Dockerfile is copy-pasted into our main docs at /docs/handbook/deploying-with-docker.
# Make sure you update both files!
COPY . .

FROM base AS builder
# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk add --no-cache libc6-compat
RUN apk update
# Set working directory
WORKDIR /app
RUN yarn global add turbo@2.0.6
COPY . .
RUN turbo prune page_router --docker

# Add lockfile and package.json's of isolated subworkspace
FROM base AS runner
RUN apk add --no-cache libc6-compat bash
RUN apk update
WORKDIR /app
COPY . .

# First install the dependencies (as they change less often)
COPY .gitignore .gitignore
COPY --from=builder /app/out/json/ .
COPY --from=builder /app/out/pnpm-lock.yaml ./pnpm-lock.yaml
RUN yarn global add pnpm@8.9.0 && pnpm i

# Build the project and its dependencies
COPY --from=builder /app/out/full/ .
COPY turbo.json turbo.json

CMD pnpm turbo dev --filter=page_router
