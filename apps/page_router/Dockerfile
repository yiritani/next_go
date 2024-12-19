FROM node:18-alpine AS base

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

FROM base AS builder
RUN apk add --no-cache libc6-compat
RUN apk update

WORKDIR /app
RUN pnpm add -g turbo
COPY . .
RUN turbo prune page_router --docker

FROM base AS installer
RUN apk add --no-cache libc6-compat
RUN apk update
WORKDIR /app

COPY .gitignore .gitignore
COPY --from=builder /app/out/json/ .
COPY --from=builder /app/out/pnpm-lock.yaml ./
RUN pnpm install

COPY --from=builder /app/out/full/ .
RUN pnpm turbo run build --filter=page_router

FROM base AS runner
WORKDIR /app

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs
USER nextjs

COPY --from=installer /app/apps/page_router/next.config.js .
COPY --from=installer /app/apps/page_router/package.json .

COPY --from=installer --chown=nextjs:nodejs /app/apps/page_router/.next/standalone ./
COPY --from=installer --chown=nextjs:nodejs /app/apps/page_router/.next/static ./apps/page_router/.next/static
COPY --from=installer --chown=nextjs:nodejs /app/apps/page_router/public ./apps/page_router/public

ENV HOSTNAME=0.0.0.0

CMD node apps/page_router/server.js