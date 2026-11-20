Статус сервисов
______________________________________________________
#!/bin/bash
set -euo pipefail
for service in nginx myapp postgresql redis ; do
status="$(systemctl is-active "$service" || true)"
echo "${service}": "$status"
done
