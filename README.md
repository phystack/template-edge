# template-edge

Starter template for scaffolding new Node.js edge modules on the PhyStack platform.

## Overview

This repository is a project template used by `@phystack/cli` to scaffold new edge apps. Edge apps run on PhyStack-connected devices without a graphical user interface, executing locally as Docker containers to provide compute power and logic at the edge.

This template does not deploy anywhere on its own.

## Tech Stack

| Layer | Technology |
|-------|------------|
| Runtime | Node.js 24 |
| Language | TypeScript 5.9 |
| Platform client | @phystack/hub-client |
| Schema generation | @phystack/ts-schema |
| Container | Docker (node:24-slim) |

## Prerequisites

- Node.js 24+ (see `.nvmrc`)
- Yarn 1.x
- Docker (for container builds)
- `@phystack/cli` installed globally (`npm i -g @phystack/cli`)

## Getting Started

This template is used automatically when you create a new edge app with the CLI:

```bash
phy app create
```

Select **Edge Application (Node.js)** when prompted. The CLI will scaffold a new project from this template, configure your container registry and credentials, and install dependencies.

### Run Locally with the Simulator

Start the simulator server, then launch your app against it:

```bash
phy simulator start
```

```bash
yarn dev
```

This creates a local simulated twin based on your settings from `src/settings/index.json` (generated from `schema.ts` defaults if the file doesn't exist), builds the Docker image, and runs the container connected to the simulator.

### Build and Publish

Build the `.gridapp` package:

```bash
yarn build
```

Publish to your tenant (builds the Docker image, pushes to your registry, and uploads the `.gridapp`):

```bash
yarn pub
```

For the full walkthrough, see the [Build An Edge App](https://build.phystack.com/tutorials/build-your-first-edge-app/) tutorial.

## Project Structure

```
src/
  app.ts              # Entry point -- connects to PhyHub, reads settings, listens for messages
  schema.ts           # TypeScript type for console-managed settings
scripts/
  init-settings.js    # Generates src/settings/index.json from schema defaults
Dockerfile            # Production container image
settings.json         # Docker container configuration (network mode, restart policy, etc.)
tsconfig.json         # TypeScript compiler configuration
meta/                 # Device image and metadata for the app listing
```

## Scripts

| Script | Description |
|--------|-------------|
| `yarn dev` | Run the app locally with the simulator (`phy simulator run .`). Automatically generates settings from schema if missing (via `predev` hook). |
| `yarn start` | Run the compiled app directly (`node dist/app.js`) |
| `yarn devbuild` | Compile TypeScript and generate the JSON settings schema |
| `yarn schema` | Generate JSON schema from `src/schema.ts` |
| `yarn build` | Dev build + `phy app build` to package the `.gridapp` |
| `yarn pub` | Build Docker image, push to registry, and publish the `.gridapp` to your tenant |
| `yarn deploy` | Deploy the app directly to a device in developer mode |
| `yarn desc` | Upload the app description to your tenant |

## Related Documentation

- [Build An Edge App](https://build.phystack.com/tutorials/build-your-first-edge-app/) -- step-by-step tutorial
- [Settings Schemas](https://build.phystack.com/phystack-concepts/settings-schemas/) -- how settings and schemas work
- [Dev Environment Setup](https://build.phystack.com/getting-started/dev-environment-setup/) -- CLI installation and simulator setup
