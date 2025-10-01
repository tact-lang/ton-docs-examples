contract Test
(
) {
    receive(msg: Slice) {
        nop(msg.loadUint(64));
    }
}

asm fun nop(c: Int) {
    NOP
}