struct Storage {
    counter: uint64; // the current counter value
}

// load contract data from persistent storage
fun Storage.load() {
    return Storage.fromCell(contract.getData())
}

// save contract data to persistent storage
fun Storage.save(self) {
    contract.setData(self.toCell())
}

struct(0x7e8764ef) IncreaseCounter {
    increaseBy: uint32
}

struct(0x3a752f06) ResetCounter {}

type AllowedMessage = IncreaseCounter | ResetCounter;

fun onInternalMessage(in: InMessage) {
    // use `lazy` to defer parsing until fields are accessed
    val msg = lazy AllowedMessage.fromSlice(in.body);

    // matching our union to determine body structure
    match (msg) {
        IncreaseCounter => {
            // load contract storage lazily (efficient for large or partial reads/updates)
            var storage = lazy Storage.load();
            storage.counter += msg.increaseBy;
            storage.save();
        }

        ResetCounter => {
            var storage = lazy Storage.load();
            storage.counter = 0;
            storage.save();
        }

        // this match branch would be executed if message body does not match IncreaseCounter or ResetCounter structures
        else => {
            // reject user message (throw) if body is not empty
            assert(in.body.isEmpty()) throw 0xFFFF
        }
    }
}

get fun currentCounter(): int {
    val storage = lazy Storage.load();
    return storage.counter;
}