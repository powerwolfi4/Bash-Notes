Бэкап папки
__________________________________________________________
#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
    echo "Использование: $(basename "$0") <что_бэкапить> [куда_сохранить]" >&2
    exit 1
fi

src_dir="$1"
dest_dir="${2:-/tmp}"

if [[ ! -d "$src_dir" ]]; then
    echo "Ошибка: директория '$src_dir' не найдена" >&2
    exit 1
fi

mkdir -p "$dest_dir"

dir_name="$(basename "${src_dir%/}")"
timestamp="$(date +%Y-%m-%d_%H-%M-%S)"
archive_path="${dest_dir%/}/${dir_name}_${timestamp}.tar.gz"

# Флаг успешного завершения, чтобы не путать нормальный выход с ошибкой
success=false

cleanup() {
    local exit_code=$?
    if [[ "$success" == false ]]; then
        rm -f "$archive_path"
        echo "Бэкап прерван, неполный архив удален" >&2
    fi
    exit "$exit_code"
}
trap cleanup EXIT

tar -czf "$archive_path" -C "$(dirname "$src_dir")" "$dir_name"
success=true

printf "Готово: %s (%s)\n" "$archive_path" "$(du -h "$archive_path" | cut -f1)"
