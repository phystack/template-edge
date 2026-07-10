# PhyStack edge app image — Bun runtime runs the TypeScript source directly.
FROM oven/bun:1-slim

WORKDIR /app

COPY package.json tsconfig.json ./
COPY src ./src

RUN bun install --production

CMD ["bun", "src/app.ts"]
