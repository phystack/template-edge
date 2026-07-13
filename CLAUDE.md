# CLAUDE.md — template-edge

Starter template for PhyStack **EDGE** apps: containerized apps that run on
PhyOS devices and talk to the platform through `@phystack/hub-client` (an
Edge twin). Scaffolded by `phy app init <name> --type edge`.

## Commands (bun-only — no npm/yarn scripts)

| Command | What it runs |
|---|---|
| `bun install` | Install dependencies |
| `bun run dev` | `phy-simulator run . --dev-command 'bun src/app.ts'` — twin on the running simulator + the app connected to it |
| `bun run start` | `bun src/app.ts` — run the app directly |
| `bun run build` | `tsc` typecheck + compile `src/schema.ts` to `build/schema.json` + `build/meta-schema.json` |
| `bun run typecheck` | `tsc --noEmit` |
| `bun run pub` | `bun run build && phy app build create $npm_package_name --dir . --push --publish` |

## Dev loop

- Install the standalone simulator once (`npm i -g @phystack/device-simulator`,
  provides the `phy-simulator` binary) and start it in a separate terminal:
  `phy-simulator start` (simulated device on `:55000`). Then `bun run dev`
  creates a twin on it and runs the app connected to it — `run` requires the
  server to already be running.
- The `predev` hook generates `src/settings/index.json` from the schema
  defaults — a local-dev bootstrap only; delete it to regenerate after
  schema changes. In production, settings arrive on the Edge twin's desired
  properties.

## Schema pipeline

`src/schema.ts` (TypeScript type + JSDoc annotations) → `bunx ts-schema` →
`build/schema.json` (validation) + `build/meta-schema.json` (Console UI
hints). The Console renders the installation-settings form from these.

## Publish flow (new `phy` CLI grammar)

```bash
phy login
phy app create <name> --type edge   # register in your tenant (once)
phy registry login docker.io        # container registry credentials (once)
bun run pub                         # build + push image, submit + publish build
```

The image ref is derived from your registry login and the pull credential is
attached to the build automatically. The legacy `@phystack/cli` (Node) does
not work with this template — use the Rust `phy` CLI only.

## Layout

| Path | Purpose |
|---|---|
| `src/app.ts` | Entrypoint — hub-client connection, settings handling, twin messaging |
| `src/schema.ts` | Installation-settings schema source |
| `settings.json` | Docker `createOptions` (HostConfig) attached to the build |
| `Dockerfile` | `oven/bun` image running the TypeScript source directly |
| `scripts/init-settings.js` | Generates local dev settings from schema defaults |

## Gotchas

- `application-type` in package.json must stay `edge` — the CLI validates it
  on `phy app build create` (and `--push` is rejected for non-edge apps).
- The package.json `name` is the app name used by `pub`
  (`$npm_package_name`); `phy app init` patches it on scaffold.
- Edge builds require `--push`: the device pulls a container image, so a
  build without a pushed image cannot deploy.
