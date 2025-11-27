fun touch<T>(y: T): void asm "NOP" // so that the compiler doesn't remove instructions 
fun pow2(y: int): int asm "POW2"

fun onInternalMessage() {
    try {
        // Repeat only operates on an inclusive range from 1 to 2^{31} - 1
        // Any valid integer value greater than that causes an error with exit code 5
        repeat (pow2(55)) {
            touch("smash. I. must.");
        }
    } catch(exitCode) {
        // exitCode is 5
        assert (exitCode == 5) throw 1111;
    } 

    try {
        // Builder.storeUint() function can only use up to 256 bits, thus 512 is too much:
        touch(beginCell().storeUint(-1, 512).toCell());
    } catch (exitCode) {
        // exitCode is 5
        assert (exitCode == 5) throw 1111;
    }

    try { 
        touch(beginCell().storeUint(100, 2).toCell()); // maximum value is 2^{2} - 1 = 3 < 100
    }
    catch(exitCode) {
        // exitCode is 5
        assert (exitCode == 5) throw 1111;
    }

    try {
        val deployMsg = createMessage({
            bounce: false,
            dest: {
                workchain: 0,
                stateInit: {
                    code: beginCell().endCell(),
                    data: beginCell().endCell(),
                },
                toShard: {
                    fixedPrefixLength: pow2(52), // but fixedPrefixLength is uint5
                    closeTo: contract.getAddress()
                },
            },
            value: 1,
            body: beginCell().endCell(),
        });

        deployMsg.send(SEND_MODE_PAY_FEES_SEPARATELY);
    } catch (exitCode) {
        // exitCode is 5
        assert (exitCode == 5) throw 1111;
    }
}
