import "@stdlib/tvm-dicts";

fun touch<T>(y: T): void asm "NOP" // so that the compiler doesn't remove instructions 
fun cast<T, U>(y: T): U asm "NOP"
fun cell?.addIntToIDict(mutate self, key: int, number: int): void {
    return self.iDictSetBuilder(32, key, beginCell().storeInt(number, 32));
}

fun onInternalMessage() {
    var dict = createEmptyDict();
    dict.addIntToIDict(0, 0);
    dict.addIntToIDict(1, 1);

    // The Int to Int dictionary is being misinterpreted as a map<int32, cell>
    val m: map<int32, cell> = cast(dict);
    
    try {
        // And the error happens only when we touch it
        touch(m.get(0).isFound);
    } catch (exitCode) {
        // exitCode is 10
        assert (exitCode == 10) throw 1111;
    }
}

