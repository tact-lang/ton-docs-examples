import { beginCell, toNano } from "@ton/core";
import { Blockchain } from "@ton/sandbox";
import "@ton/test-utils";
import { Test } from "./output/sample_Test";
import { findTransaction, flattenTransaction } from "@ton/test-utils";

describe("contract", () => {
    it("should work correctly", async () => {
        const blockchain = await Blockchain.create({ config: "slim" });
        blockchain.verbosity.vmLogs = "vm_logs_full";
        const owner = await blockchain.treasury("deployer");
        const contract = blockchain.openContract(await Test.fromInit());
        const deployRes = await contract.send(owner.getSender(), { value: toNano(0.5), bounce: true }, beginCell().asSlice());
        for(const tx of deployRes.transactions) {
            console.log(flattenTransaction(tx))
        }
    });
});
