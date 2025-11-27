fun touch<T>(y: T): void asm "NOP" // so that the compiler doesn't remove instructions 
fun pow2(y: int): int asm "POW2"

fun onInternalMessage() {
    var x = -pow2(255) - pow2(255);
    var zero = x - x;

    try {
        touch(-x); // integer overflow by negation
                   // since the max positive value is 2^{256} - 1
    } catch(exitCode) {
        // exitCode is 4
        assert (exitCode == 4) throw 1111;
    } 

    try {
        touch(x / zero); // division by zero!
    } catch (exitCode) {
        // exitCode is 4
        assert (exitCode == 4) throw 1111;
    }

    try {
        touch(x * x * x); // integer overflow!
    } catch (exitCode) {
        // exitCode is 4
        assert (exitCode == 4) throw 1111;
    }
}
