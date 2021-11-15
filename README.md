
# Bootrr

A sanity checker for boards under automated test on LAVA.

Before running the tests for your software stack on LAVA, you really want to
ensure that the basics are in place.

Testing that all the expected hardware is detected and that modules and
firmwares can be loaded catches some very common kind of regressions: for
instance, when renaming identifiers it is often the case that firmware blobs no
longer get loaded since their location needs to be updated accordingly.

This repository contains:
* static board descriptions that list what to expect for each specific
  board type
* helpers to inspect the current system and compare it against the static board
  description for it
* the `bootrr` script to automatically detect the current board and run
  the matching tests

The output is in a format meant to be directly parsed by LAVA.

## Install

```sh
$ make prefix=/usr/local DESTDIR=/ install
```

## Usage

```sh
$ bootrr
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=deferred-probe-empty RESULT=skip>
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=all-cpus-are-online RESULT=pass>
```

## Related Efforts

- [LAVA](https://lavasoftware.org/) - A continuous integration system for deploying operating systems onto physical and virtual hardware for running tests.
- [KernelCI](https://kernelci.org/) - Community-led test system focused on the upstream Linux kernel.

## License

BSD-3-Clause
