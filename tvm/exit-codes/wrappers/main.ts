import { Address, beginCell, Cell, Contract, contractAddress, ContractProvider, Sender, SendMode } from '@ton/core';

export type SimpleContractConfig = {};

export function simpleContractConfigToCell(config: SimpleContractConfig): Cell {
    return beginCell().endCell();
}

export class SimpleContract implements Contract {
    constructor(
        readonly address: Address,
        readonly init?: { code: Cell; data: Cell },
    ) {}

    static createFromAddress(address: Address) {
        return new SimpleContract(address);
    }

    static createFromInit(init: { code: Cell; data: Cell }, workchain = 0) {
        return new SimpleContract(contractAddress(workchain, init), init);
    }

    static createFromConfig(config: SimpleContractConfig, code: Cell, workchain = 0) {
        const data = simpleContractConfigToCell(config);
        const init = { code, data };
        return new SimpleContract(contractAddress(workchain, init), init);
    }

    async sendDeploy(provider: ContractProvider, via: Sender, value: bigint) {
        await provider.internal(via, {
            value,
            sendMode: SendMode.PAY_GAS_SEPARATELY,
            body: beginCell().endCell(),
        });
    }
}
