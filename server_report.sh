Обычный отчет о сервере
__________________________________________________________
#!/bin/bash
set -euo pipefail
echo 'Имя сервера'
hostname
echo 'Адрес'
hostname -I
echo 'Версия'
awk -F= 'NR<=2 {print $2}' /etc/os-release
echo 'Время работы и нагрузка'
uptime
echo 'Память' 
free -h
echo 'Диск'
df -h
echo 'топ 5 процессов по нагрузке CPU'
ps aux --sort=-%cpu | head -n 6
echo 'Работающие сервисы и открытые порты'
