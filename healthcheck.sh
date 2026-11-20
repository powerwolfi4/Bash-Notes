Проверка адресов
__________________________________________________________
#!/bin/bash
set -euo pipefail
ok=0
fail=0
while IFS= read -r url; do
code=$(curl -s -o /dev/null -w '%{http_code}' --connect-timeout 3 --ma>
if [ "$code" = "200" ]; then
    echo "$url OK"
    ok="$(($ok + 1))"
else
    echo "$url FAIL"
    fail="$(($fail + 1))"
fi
done < /opt/app/conf/urls.txt
echo "OK: $ok, FAIL: $fail"
