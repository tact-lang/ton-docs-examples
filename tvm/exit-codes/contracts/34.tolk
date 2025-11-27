fun onInternalMessage() {
    // For example, let's try to send an ill-formed message:
    // won't fail in the compute phase, but will result in exit code 34 in the Action phase
    sendRawMessage(beginCell().endCell(), 0);
}

