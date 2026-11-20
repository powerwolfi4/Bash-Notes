Проверка диска(функции)
__________________________________________________________                    
#!/bin/bash
set -euo pipefail
get_usage() {
    local usage="$(df / | awk 'NR==2 {print $5+0}')"
    echo "$usage"
}
check() {
    local disk_usage="$1"
if [ "$disk_usage" -gt 80 ]; then
    echo "WARNING: disk usage at ${disk_usage}%"
else
    echo "OK: disk usage at ${disk_usage}%"
fi
}
main () {
    local usage="$(get_usage)"
    check "$usage"
