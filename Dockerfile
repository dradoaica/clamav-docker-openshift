FROM clamav/clamav:1.5.1

# fix check permissions error for ClamAV
RUN chgrp -R 0 /var/lib/clamav && chmod -R g=u /var/lib/clamav
RUN chgrp -R 0 /var/log/clamav && chmod -R g=u /var/log/clamav
RUN chown -R 1001:0 /var/lib/clamav && chmod -R 775 /var/lib/clamav
RUN chown -R 1001:0 /var/log/clamav && chmod -R 775 /var/log/clamav

USER 1001

ENTRYPOINT ["/bin/sh", "/init-unprivileged"]
