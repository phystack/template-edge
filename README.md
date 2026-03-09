# template-edge

Starter template for scaffolding new Node.js edge modules on the Phystack platform.

## Overview

This repository is a project template used by `@phystack/cli` to scaffold new edge modules. Edge modules run as Docker containers on Phystack IoT devices (barcode scanners, thermal printers, kiosks, etc.) and communicate with the platform through `@phystack/hub-client`.

This template does not deploy anywhere on its own.

## Tech Stack

| Layer | Technology |
|-------|------------|
| Runtime | Node.js 20 |
| Language | TypeScript 4.9 |
| Platform client | @phystack/hub-client |
| Schema generation | @phystack/ts-schema |
| Container | Docker (node:20-slim) |

## Prerequisites

- Node.js 20+ (see `.nvmrc`)
- Yarn 1.x
- Docker (for container builds)
- `@phystack/cli` installed globally (`npm i -g @phystack/cli`)

## Getting Started

After scaffolding a new module with the CLI, install dependencies and start the dev build:

```bash
yarn install
yarn devbuild
```

## Project Structure

```
src/
  app.ts           # Entry point -- connects to PhyHub, reads settings, listens for messages
  schema.ts        # TypeScript type for console-managed settings
Dockerfile         # Production container image
settings.json     # Docker HostConfig defaults for the edge device
tsconfig.json     # TypeScript compiler configuration
meta/              # Device image and metadata for the app listing
```

## Usage

`@phystack/cli` copies this template when creating a new edge module:

```bash
phy app create --type module
```

The scaffolded project includes:

- **`src/app.ts`** -- a minimal entry point that connects to PhyHub, reads settings, and listens for incoming messages.
- **`src/schema.ts`** -- a TypeScript type exported as `Settings`. The CLI generates a JSON schema from this file so the Phystack console can render a settings form.
- **`settings.json`** -- default Docker container configuration (network mode, restart policy, resource limits).

### Build and Publish Scripts

| Script | Description |
|--------|-------------|
| `yarn devbuild` | Compile TypeScript and generate the settings schema |
| `yarn build` | Dev build + `phy app build` to package the container |
| `yarn pub` | Publish the built app to the Phystack registry |
| `yarn deploy` | Deploy the app to target devices |

## Template Variables

| Placeholder | Replaced With |
|-------------|---------------|
| `{{applicationName}}` | Name provided during `phy app create` |
| `{{author}}` | Author from CLI profile or prompt |

## Related Documentation

- [@phystack/hub-client](https://github.com/phystack/hub-client) -- device communication SDK
- [@phystack/cli](https://github.com/phystack/cli) -- CLI that consumes this template
