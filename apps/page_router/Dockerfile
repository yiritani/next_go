FROM node:22.11.0-alpine AS base

RUN  apk add --no-cache libc6-compat && \
     yarn global add turbo@1.13.4 pnpm@8.9.0 \
WORKDIR /app

FROM base AS builder-app
COPY . .
RUN turbo prune page_router --docker

FROM base AS installer-app

COPY .gitignore .gitignore
COPY --from=builder-app /app/out/json/ .
COPY --from=builder-app /app/out/pnpm-lock.yaml ./pnpm-lock.yaml
RUN pnpm i

COPY --from=builder-app /app/out/full/ .
RUN pnpm turbo run build --filter=page_router

# Add lockfile and package.json's of isolated subworkspace
FROM base AS runner
RUN apk update
WORKDIR /app
COPY . .

# First install the dependencies (as they change less often)
COPY --from=builder /app/out/json/ .
COPY --from=builder /app/out/pnpm-lock.yaml ./pnpm-lock.yaml
RUN yarn global add pnpm@8.9.0 && pnpm i

# Build the project and its dependencies
COPY --from=builder /app/out/full/ .
#COPY turbo.json turbo.json
COPY --from=builder turbo.json turbo.json

CMD pnpm turbo dev --filter=page_router
