To run in an environment that is suitable for building the Leap Motion platform repository, run
the `docker-user` script with command-line parameters that are intended for use with `docker run`.
The last parameter is the docker image that has already been configured with the proper build
environment. Use `docker images` to see if an image already exists for your desired combination.
There are several Dockerfile files that may be found in the top-level directory of this repo
that are used to build various images.

It is expected that a docker volume exists that is named in the form of `libraries-${arch}-${distro}`
(e.g., `libraries-arm64-xenial`). It must contain all of the external libraries that are used
to build platform. It will automatically be mounted as `/opt/local/Libraries-${arch}` (e.g.,
`/opt/local/Libraries-arm64`). In addition, your home directory will also automatically be mounted in
the docker container. Here is an example of starting an instance of Ubuntu 16.04 (Xenial) for ARM64:
```
  $ ./scripts/docker-user -it --rm ubuntu-arm64:xenial
```
The container includes an instance of `qemu-arm64-static` (or `qemu-arm-static` for 32-bit builds),
thus allowing native ARM executables to be run within the environment, eliminating the need for
"host" (x86_64) executables.

Once you are running inside of the docker shell, make your way to the platform repository. Create
a directory called `build`. From within there, create another directory corresponding to the
distro/architecture for which you will build (e.g., `xenial` or `xenial-arm64`). This will allow
you to keep the builds separate. You can then run `cmake` to configure the build. For 32-bit builds,
use `arm32` instead of `arm64`:
```
  $ cmake -DCMAKE_TOOLCHAIN_FILE=../../toolchain-arm64.cmake -DHOST_EXTERNAL_LIBRARY_DIR=/opt/local/Libraries-arm64 ../..
```
Alternately, to build the external libraries that seem to be distro-specific, go to the top-level of
this repo, create a `build` directory, go into that directory, then run:
```
  $ ../scripts/leap-libraries
```
Currently, this builds boost, autowiring, and the various external leap* libraries. If a directory with
the specified version already exists, it will not try to rebuild it (unless a dependency was rebuilt).
To force a rebuild of a library, remove the appropriate directory from the `/opt/local/Libraries-arm64`
(or `arm32`) directory.
