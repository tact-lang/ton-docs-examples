import "@stdlib/gas-payments";

fun onInternalMessage() {
    // For example, let's attempt to queue the reservation of a specific amount of nanoToncoins
    // This won't fail in the compute phase, but will result in exit code 33 in the action phase
    repeat (256) {
        reserveToncoinsOnBalance(1000000, RESERVE_MODE_AT_MOST);
    }
}

