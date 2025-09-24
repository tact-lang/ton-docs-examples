import { toNano } from '@ton/core';
import { FirstContract } from '../wrappers/FirstContract';
import { compile, NetworkProvider } from '@ton/blueprint';

export async function run(provider: NetworkProvider) {
    const firstContract = provider.open(
        FirstContract.createFromConfig(
            { counter: Math.floor(Math.random() * 10000000) },
            await compile('FirstContract')
        )
    );

    await firstContract.sendDeploy(provider.sender(), toNano('0.05'));

    await provider.waitForDeploy(firstContract.address);
}