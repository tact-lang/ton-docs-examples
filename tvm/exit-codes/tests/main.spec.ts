import { Blockchain } from '@ton/sandbox';
import { toNano } from '@ton/core';
import '@ton/test-utils';
import { compile } from '@ton/blueprint';
import { SimpleContract, simpleContractConfigToCell } from '../wrappers/main';

describe('Exit codes', () => {
    const computeExitCodes = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, -14];

    const actionExitCodes = [33, 34];

    it.each([...computeExitCodes, ...actionExitCodes])(`should return exit code %s`, async (exitCode) => {
        const blockchain = await Blockchain.create();
        const deployer = await blockchain.treasury('deployer');
        const code = await compile(`${exitCode}`);
        const contract = blockchain.openContract(
            SimpleContract.createFromInit({ code, data: simpleContractConfigToCell({}) }, 0),
        );

        const result = await contract.sendDeploy(deployer.getSender(), toNano('10'));

        if (actionExitCodes.includes(exitCode)) {
            expect(result.transactions).toHaveTransaction({
                to: contract.address,
                deploy: true,
                success: false,
                actionResultCode: exitCode,
            });
        } else if (exitCode === -14) {
            expect(result.transactions).toHaveTransaction({
                to: contract.address,
                deploy: true,
                success: false,
                exitCode: -14,
            });
        } else {
            expect(result.transactions).toHaveTransaction({
                to: contract.address,
                deploy: true,
                success: true,
            });
        }
    });
});
