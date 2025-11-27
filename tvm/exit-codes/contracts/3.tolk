// Remember kids, don't try to overflow the stack at home!
fun stackOverflow(): void asm 
"""
    x{} SLICE        // s
    BLESS            // c
    0 SETNUMARGS     // c'
    2 PUSHINT        // c' 2
    SWAP             // 2 c'
    1 -1 SETCONTARGS // ← this blows up
"""


fun onInternalMessage() {
    try { 
        stackOverflow();
    } catch(exitCode) {
        assert (exitCode == 3) throw 1111;
    }
}
