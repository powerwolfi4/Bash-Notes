Запросы по часам (файл лога nginx)
__________________________________________________________
#!/bin/bash
set -euo pipefail

file="${1:-}"

if [ ! -f "$file" ]; then
    echo 'Ошибка: файл не найден' >&2
    exit 1
fi

awk '{print $4}' "$file" | cut -d: -f2 | sort | uniq -c | while read ->
    hashes=$((count / 100))
    bar=""
    for ((i=0; i<hashes; i++)); do
        bar+="#"
    done
    printf "%s:00 [%s] %s\n" "$hour" "$bar" "$count"
