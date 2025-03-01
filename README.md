# VMaNGOS

VMaNGOS is an [open-source project, known as Vanilla MaNGOS](https://github.com/vmangos), devoted to accurately recreating an earlier eras of vanilla progression. This repository contains the Bazel build instructions for assembling container images that are capable of building variants of VMaNGOS.

This repository is responsible for:

- The build-deps image - An image based on Ubuntu with all build dependencies installed
- The builder image - An image with the vmangos/core source (& other source-based deps) included
- The runtime image - An image based on Ubuntu with all runtime dependencies installed
- The database image - An image containing a dataset of SQL data files
- The extractor image - A ready-to-run image for extracting client data
- The release image - A ready-to-run image for running the emulator server

## Advisory

This repository is extracted from a mono-repo (large repository containing multiple projects), which is why this repository does not leverage GitHub Actions/GitLab Pipelines or any similar services offered by the Git hosting provider. Images are built from this repository & published into the registry.

Images built from this source code should be the same for released images.

## Building

To build these images, this requires a build environment that supports Bazel & `docker`. Builds can be executed by running the standard `bazel build` steps. All container images within the repository can be built at once using the command:

```bash
bazel build //...
```

Individual images can be built by running commands similar to `bazel build //containers/builder:image`.

## Local Execution

Images can be experimented with locally by leveraging the load actions, which can be executed by `bazel run` as such:

```bash
bazel run //containers/builder:load
```

This will load the images into the docker daemon with the `wip` tag.
