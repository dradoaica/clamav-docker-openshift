# clamav-openshift

Chart for deploying a ClamAVd on OpenShift as StatefulSet.

Based on https://git.zero-downtime.net/ZeroDownTime/kubezero/src/branch/master/charts/clamav

## Requirements

Kubernetes: `>= 1.26.0`

## Values

| Key                          | Type   | Default                                                                           | Description                                                                                                          |
|------------------------------|--------|-----------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------|
| freshclam.mirrors            | string | `"database.clamav.net"`                                                           | A list of clamav mirrors to be used by the clamav service                                                            |
| freshclam.httpsProxyHost     | string | `""`                                                                              | The proxy host                                                                                                       |
| freshclam.httpsProxyPort     | string | `""`                                                                              | The proxy port                                                                                                       |
| fullnameOverride             | string | `""`                                                                              | Override the full name of the clamav-openshift chart                                                                 |
| image                        | object | `{"repository":"dradoaica/clamav-openshift","tag":"1.3"}`                         | The clamav docker image                                                                                              |
| limits.connectionQueueLength | int    | `100`                                                                             | Maximum length the queue of pending connections may grow to                                                          |
| limits.fileSize              | int    | `25`                                                                              | The largest file size scanable by clamav, in MB                                                                      |
| limits.maxThreads            | int    | `4`                                                                               | Maximum number of threads running at the same time.                                                                  |
| limits.scanSize              | int    | `100`                                                                             | The largest scan size permitted in clamav, in MB                                                                     |
| limits.sendBufTimeout        | int    | `500`                                                                             | This option specifies how long to wait (in milliseconds) if the send buffer is full, keep low to avoid clamd hanging |
| nameOverride                 | string | `""`                                                                              | Override the name of the clamav-openshift chart                                                                      |
| replicaCount                 | int    | `1`                                                                               |                                                                                                                      |
| resources                    | object | `{"requests":{"cpu":"300m","memory":"2Gi"}, "limits":{"cpu":"2","memory":"4Gi"}}` | The resource requests and limits for the clamav service                                                              |
| service.port                 | int    | `3310`                                                                            | The port to be used by the clamav service                                                                            |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)