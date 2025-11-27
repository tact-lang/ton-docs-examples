fun touch<T>(y: T): void asm "NOP" // so that the compiler doesn't remove instructions 
// The actual returned value type doesn't match the declared one
fun typeCheckError(): cell asm "42 PUSHINT";

fun onInternalMessage() {
    try {
        // it isn't cell 
        touch(typeCheckError().beginParse());
    } catch (exitCode) {
        // exitCode is 7
        assert (exitCode == 7) throw 1111;
    }
}