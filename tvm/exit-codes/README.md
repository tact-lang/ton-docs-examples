# TVM Exit Codes Examples

This repository contains examples of different exit codes for TON blockchain documentation.

## Project structure

-   `contracts` - source code of all the smart contracts of the project, each demonstrating a specific exit code.
-   `wrappers` - wrapper classes (implementing `Contract` from ton-core) for the contracts, including any [de]serialization primitives and compilation functions.
-   `tests` - tests for the contracts that verify the correct exit codes are returned.
-   `build` - compiled contracts.

## Exit Codes

This project demonstrates various exit codes that can occur during smart contract execution in TVM:

-   **Compute Phase Exit Codes**: 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, -14
-   **Action Phase Exit Codes**: 33, 34

Each contract file (e.g., `2.tolk`, `3.tolk`) demonstrates how to trigger and handle a specific exit code.

## How to use

### Build

`npx blueprint build` or `yarn blueprint build`

### Test

`npx blueprint test` or `yarn blueprint test`

Tests verify that each contract correctly returns the corresponding exit code when executed.
