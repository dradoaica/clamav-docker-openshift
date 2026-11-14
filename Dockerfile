FROM clamav/clamav:1.5.5

# fix check permissions error for ClamAV
RUN chgrp -R 0 /var/lib/clamav && chmod -R g=u /var/lib/clamav
RUN chgrp -R 0 /var/log/clamav && chmod -R g=u /var/log/clamav
RUN chown -R 1001:0 /var/lib/clamav && chmod -R 775 /var/lib/clamav
RUN chown -R 1001:0 /var/log/clamav && chmod -R 775 /var/log/clamav

USER 1001

# tini as PID 1 (the shebang of /init-unprivileged is bypassed by /bin/sh): it forwards SIGTERM to clamd, freshclam and
# the milter (-g: the whole process group), so that the container stops at once instead of being killed after the grace
# period, with exit code 0 (-e 143: the exit code of a process stopped by SIGTERM)
ENTRYPOINT ["/sbin/tini", "-g", "-e", "143", "--", "/bin/sh", "/init-unprivileged"]
