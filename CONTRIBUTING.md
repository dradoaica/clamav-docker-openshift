# Contributing to clamav-docker-openshift

Thank you for your interest in contributing to clamav-docker-openshift! This project provides an OpenShift-ready image
of [ClamAV](https://www.clamav.net/), built on top of the official
[clamav/clamav](https://hub.docker.com/r/clamav/clamav) image. Its goal is to stay as close to upstream as possible
while making the image work under OpenShift's restricted security context (arbitrary non-root UID, root group `0`).

## Where Things Live

- [Dockerfile](Dockerfile): the image itself. It pins the upstream ClamAV version, fixes ownership/permissions of
  `/var/lib/clamav` and `/var/log/clamav`, and runs as user `1001` via the upstream `/init-unprivileged` entrypoint.
- [.github/workflows/release.yml](.github/workflows/release.yml): builds and pushes the image to GHCR when a GitHub
  release is published.
- [README.md](README.md): build, push and run instructions.
- The Helm chart lives in a separate repository:
  [dradoaica/helm-charts](https://github.com/dradoaica/helm-charts/tree/main/charts/clamav-openshift). Changes to
  deployment manifests, values or chart templates should be proposed there.

Problems with ClamAV itself (scanning, `clamd`/`freshclam` behavior, detections) belong upstream at
[Cisco-Talos/clamav](https://github.com/Cisco-Talos/clamav). Security issues follow [SECURITY.md](SECURITY.md).

## Reporting Bugs

Please open an issue that includes:

- The image tag (and digest, if possible) and whether you pulled it from Docker Hub or GHCR.
- Where it runs: OpenShift, Kubernetes or plain Docker/Podman, and its version.
- The Security Context Constraint / security context in use (e.g. `restricted-v2`) and the UID the pod runs as.
- Container logs, especially any `freshclam` or `clamd` permission errors.

## Spot a Typo?

Typos and other small fixes are welcome — no contribution is too small! Just open a pull request; there's no need to
create an issue first.

## Updating the ClamAV Version

Most contributions are version bumps. When a new `clamav/clamav` tag is released:

1. Update the `FROM clamav/clamav:<version>` line in the [Dockerfile](Dockerfile).
2. Update every `dradoaica/clamav-openshift:<version>` reference in [README.md](README.md).
3. Update the supported version in [SECURITY.md](SECURITY.md).
4. Build and test the image locally (see below).
5. Use a commit message like `ClamAV 1.5.4`.

Image tags always match the upstream ClamAV version. Please don't use floating base tags such as `latest` or `stable`.

## Testing Your Changes

Build the image:

```sh
docker build -t clamav-openshift:dev -f Dockerfile .
```

Run it as an arbitrary UID in the root group, the way OpenShift does, so that permission problems show up locally:

```sh
docker run --rm -d --name clamav-openshift-dev --user 123456:0 -p 3310:3310 clamav-openshift:dev
docker logs -f clamav-openshift-dev
```

Wait for `freshclam` to download the signature database and for `clamd` to start, then check that it answers:

```sh
docker exec clamav-openshift-dev clamdscan --version
echo PING | nc localhost 3310   # expect: PONG
```

Also make sure the container still works with the default user (no `--user` flag). If you can, verify on an OpenShift
cluster with the default `restricted-v2` SCC, without granting `anyuid` or other extra privileges.

## Pull Requests

- Keep changes focused; one logical change per pull request.
- Describe what you changed, why, and how you tested it (Docker/Podman/OpenShift, and which UID).
- Don't commit secrets, signature databases or other generated files.
- Releases are created by the maintainer: publishing a GitHub release triggers the workflow that builds and pushes the
  image, so pull requests should not change image tags in the workflow.

## Contribution Principles

- **Stay close to upstream**: this image should be a minimal delta on top of `clamav/clamav`. Prefer upstream
  configuration and entrypoints over custom scripts, and propose general improvements to ClamAV or its Docker image
  upstream instead.
- **Least privilege**: the image must run without root and without extra SCCs. Grant group `0` only what OpenShift
  needs; avoid world-writable paths, `setuid` binaries or broadening permissions beyond the ClamAV data and log
  directories.
- **Small and reproducible**: avoid adding packages, layers or tools to the image unless they're needed at runtime.
  Pin versions so that a given tag always builds the same ClamAV release.

## Code of Conduct

To ensure a welcoming and positive environment for everyone, please follow our [Code of Conduct](CODE_OF_CONDUCT.md).
Respectful collaboration is key to a successful project.
