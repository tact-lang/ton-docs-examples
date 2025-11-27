fun touch<T>(y: T): void asm "NOP" // so that the compiler doesn't remove instructions 

fun onInternalMessage() {
    // Too few bits
    try {
        touch(beginCell().endCell().beginParse().loadInt(1)); // 0 bits!
    } catch (exitCode) {
        // exitCode is 9
        assert (exitCode == 9) throw 1111;
    }

    // Too few refs
    try {
        touch(beginCell().endCell().beginParse().loadRef()); // 0 refs!
    } catch (exitCode) {
        // exitCode is 9
        assert (exitCode == 9) throw 1111;
    }
}

