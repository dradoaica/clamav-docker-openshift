FROM clamav/clamav:1.2.1

RUN install -d -g "clamav" -m 775 -o "clamav" "/run/clamav"

COPY "./scripts/docker-entrypoint-unprivileged.sh" "/init-unpriv.sh"

# fix check permissions error for ClamAV
RUN chgrp -R 0 /var/lib/clamav && chmod -R g=u /var/lib/clamav
RUN chgrp -R 0 /run/clamav && chmod -R g=u /run/clamav
RUN chgrp -R 0 /var/log/clamav && chmod -R g=u /var/log/clamav
RUN chown -R 1001:0 /var/lib/clamav && chmod 775 /var/lib/clamav
RUN chown -R 1001:0 /run/clamav && chmod 775 /run/clamav
RUN chown -R 1001:0 /var/log/clamav && chmod 775 /var/log/clamav

USER 1001

ENTRYPOINT ["/bin/sh", "/init-unpriv.sh"]