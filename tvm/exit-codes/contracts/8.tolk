fun touch<T>(y: T): void asm "NOP" // so that the compiler doesn't remove instructions 

fun onInternalMessage() {
    // Too many bits
    try {
        val data = beginCell()
            .storeInt(0, 250)
            .storeInt(0, 250)
            .storeInt(0, 250)
            .storeInt(0, 250)
            .storeInt(0, 24) // 1024 bits!
            .toCell();
        touch(data);
    } catch (exitCode) {
        // exitCode is 8
        assert (exitCode == 8) throw 1111;
    }

    // Too many refs
    try {
        val data = beginCell()
            .storeRef(beginCell().endCell())
            .storeRef(beginCell().endCell())
            .storeRef(beginCell().endCell())
            .storeRef(beginCell().endCell())
            .storeRef(beginCell().endCell()) // 5 refs!
            .toCell();
        touch(data);
    } catch (exitCode) {
        // exitCode is 8
        assert (exitCode == 8) throw 1111;
    }
}

