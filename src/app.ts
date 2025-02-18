import { PhyHubClient, connectPhyClient } from '@phygrid/hub-client';
import { Settings } from './schema';

const client: PhyHubClient = await connectPhyClient();
const instance = await client.getInstance();
const settings = await client.getSettings() as Settings;

let counter = 0;
setInterval(() => {
  counter += + 1;
  console.log('Hello, world!', counter);
  console.log('Settings:', JSON.stringify(settings, null, 2));
}, 3000);

instance.on('message', (message) => {
  console.log('Message:', message);
});
