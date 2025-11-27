// There's no such code page, and an attempt to set it fails
fun invalidOpcode(): void asm "42 SETCP" 

fun onInternalMessage() {
    try {
        invalidOpcode();
    } catch (exitCode) {
        // exitCode is 6
        assert (exitCode == 6) throw 1111;
    }
}
