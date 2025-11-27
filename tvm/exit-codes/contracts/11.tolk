fun sendMessage(msg: cell, mode: int): void asm "SENDMSG"

fun onInternalMessage() {
    try {
        // fails in the Compute phase when the message is ill-formed
        sendMessage(beginCell().endCell(), 0);
    } catch (exitCode) {
        // exitCode is 11
        assert (exitCode == 11) throw 1111;
    }
}

