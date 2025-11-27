fun drop(): void asm "DROP" 

fun onInternalMessage() {
    try {
        repeat(100){
            drop();
        }
    } catch(exitCode) {
        assert (exitCode == 2) throw 1111;
    }
}
