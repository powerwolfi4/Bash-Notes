Разбор лога 

#!/bin/bash
set -euo pipefail
file="${1:-}" 
if [ -f "$file" ] ; then 
echo 'Сколько всего запросов'
wc -l < "$file"
echo 'Сколько разных адресов'
awk '{print $1}' "$file" | sort | uniq | wc -l
echo 'Сколько запросов с каждым кодом ответа'
awk '{print $9}' "$file" | sort | uniq -c | sort -nr 
echo '10 Самых частых страниц и адресов'
awk '{print $7}' "$file" | sort | uniq -c | sort -nr | head -n 10
awk '{print $1}' "$file" | sort | uniq -c | sort -nr | head -n 10
else
echo 'Ошибка, файл не найден'  >&2
exit 1
fi
