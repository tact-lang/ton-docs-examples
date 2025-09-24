import { Address } from '@ton/core';
import { FirstContract } from '../wrappers/FirstContract';
import { NetworkProvider } from '@ton/blueprint';

const contractAddress = Address.parse('kQBcFcZRColf5i0cZX_uX3eWBr9QlOp1Wb9Xpy8Iwkyo1wAZ');

export async function run(provider: NetworkProvider) {
    const firstContract = provider.open(new FirstContract(contractAddress));
    const counter = await firstContract.getCounter();
    console.log('Counter: ', counter);
}