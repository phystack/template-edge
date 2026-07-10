# template-edge

Starter template for PhyStack **EDGE** apps — containerized apps running on
PhyOS devices. Scaffolded by the PhyStack CLI (`phy app init --type edge`)
or usable directly.

## Getting started

```bash
# Scaffold via the PhyStack CLI
phy app init my-edge-app --type edge

# Or work directly from this template
bun install
bun run build
```

## Local development (simulator)

```bash
npm i -g @phystack/device-simulator   # once
phy-simulator start                   # terminal 1: local device on :55000
bun run dev                           # terminal 2: run the app inside it
```

Settings for local runs are generated into `src/settings/index.json` from the
schema defaults (`bun run dev` does this automatically; delete the file to
regenerate).

## Flow

```bash
# 1. Edit src/schema.ts (installation settings) and src/app.ts (device logic)
# 2. Local build: typecheck + compile the settings schema to build/
bun run build

# 3. Register the app in your tenant (once)
phy app create my-edge-app --type edge

# 4. Log in to your container registry (once)
phy registry login docker.io

# 5. Build + push the image, submit and publish the build
bun run pub
```

`pub` runs `phy app build create $npm_package_name --dir . --push --publish` —
the image ref is derived from your registry login, the pull credential is
attached automatically, and the build is published as soon as it processes.

## Layout

| Path | Purpose |
|------|---------|
| `src/app.ts` | App entrypoint (hub-client connection, settings, twin messaging) |
| `src/schema.ts` | Installation-settings schema (TypeScript → JSON Schema) |
| `settings.json` | Docker `createOptions` attached to the build |
| `Dockerfile` | Bun runtime image running the TypeScript source directly |
| `scripts/init-settings.js` | Generates local dev settings from schema defaults |
