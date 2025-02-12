import { PhyHubClient, connectPhyClient } from '@phygrid/hub-client';
import { Settings } from './schema';

const client: PhyHubClient = await connectPhyClient();
const settings = await client.getEdgeSettings() as Settings;

let counter = 0;
setInterval(() => {
  counter += + 1;
  console.log('Hello, world!', counter);
  console.log('Settings:', JSON.stringify(settings, null, 2));
}, 3000);
