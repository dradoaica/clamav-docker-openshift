# Security Policy

clamav-docker-openshift is a thin layer on top of the official
[clamav/clamav](https://hub.docker.com/r/clamav/clamav) image. It only adjusts file ownership and permissions so that
ClamAV can run under OpenShift's arbitrary, non-root UIDs (group `0`), and switches the default user to `1001`.

## Supported Versions

Each image tag tracks the upstream ClamAV version it is built from (for example, `1.5.4` is built from
`clamav/clamav:1.5.4`). Only the latest released tag is supported:

| Version          | Supported |
|------------------|-----------|
| latest (`1.5.4`) | Yes       |
| older tags       | No        |

Images are published to:

- Docker Hub: `dradoaica/clamav-openshift`
- GitHub Container Registry: `ghcr.io/dradoaica/clamav-docker-openshift`

If you find a security issue with an older tag, please update to the latest tag first. If for some reason you can't,
let us know why so we can better understand your situation.

## Scope

Please report to this project issues introduced by **this repository**, for example:

- File or directory permissions in the image that are broader than needed (e.g. writable paths that allow tampering
  with the signature database or ClamAV binaries).
- The container running as root, or being able to escalate privileges, when it should run unprivileged.
- Problems in the [Dockerfile](Dockerfile) or the [release workflow](.github/workflows/release.yml) that could lead to
  a compromised or tampered image being published.
- Issues in
  the [clamav-openshift Helm chart](https://github.com/dradoaica/helm-charts/tree/main/charts/clamav-openshift)
  that affect how this image is deployed.

The following are **out of scope** here and should be reported upstream:

- Vulnerabilities in ClamAV itself (`clamd`, `freshclam`, `clamscan`, `libclamav`): follow the
  [ClamAV security policy](https://github.com/Cisco-Talos/clamav/security/policy).
- Vulnerabilities in the upstream `clamav/clamav` base image or its OS packages: report them to the
  [ClamAV Docker project](https://github.com/Cisco-Talos/clamav-docker). Once a fixed upstream image is released, we
  will publish a matching tag here.
- Missed detections (false negatives) or false positives: submit samples to
  [ClamAV](https://www.clamav.net/reports/malware) or [false positive reports](https://www.clamav.net/reports/fp).

If you're unsure whether an issue belongs here or upstream, report it here and we'll help route it.

## Reporting a Vulnerability

**Please do not report security vulnerabilities through public GitHub issues.**

Report them privately using GitHub's
[private vulnerability reporting](https://github.com/dradoaica/clamav-docker-openshift/security/advisories/new)
(the "Report a vulnerability" button on the repository's **Security** tab).

Please include:

- The image tag and digest you are using, and where you pulled it from (Docker Hub or GHCR).
- Your platform (OpenShift, Kubernetes, plain Docker/Podman) and version, plus the Helm chart version if applicable.
- A description of the issue and its impact.
- Steps to reproduce, or a proof of concept.

This is a project maintained in spare time, so there is no guaranteed response time, but we aim to acknowledge reports
within a week and to release a fixed image as soon as practical. You'll be credited in the advisory unless you prefer
to remain anonymous.
