#!/usr/bin/env bash
set -uo pipefail

SKRIP_INI='scripts/cek-rahasia.sh'
gagal=0

laporkan() {
  if [ -n "$2" ]; then
    echo "::error::$1"
    echo "$2" | sed 's/^/  - /'
    gagal=1
  fi
}

BERKAS_TERLARANG='(^|/)\.env$|(^|/)\.env\.(?!example$)[^/]+$|\.(dump|backup)$|(^|/)dataset_[^/]*$|\.ipynb$|(^|/)data/mentah/|(^|/)(gold|pool)[^/]*\.json$'
temuan=$(git ls-files | grep -P "$BERKAS_TERLARANG" || true)
laporkan 'Berkas yang tidak boleh di-commit' "$temuan"

temuan=$(git ls-files | grep -P '(^|/)\.env\.example$' | while read -r berkas; do
  grep -nP '^\s*[A-Za-z_][A-Za-z0-9_]*\s*=\s*\S' "$berkas" | cut -d: -f1 | sed "s|^|$berkas:|"
done || true)
laporkan '.env.example harus bernilai kosong' "$temuan"

cek_pola() {
  local judul=$1 pola=$2 hasil
  hasil=$(git ls-files -z | grep -zv "^${SKRIP_INI}\$" \
    | xargs -0 -r grep -IHnP -- "$pola" 2>/dev/null | cut -d: -f1,2 || true)
  laporkan "$judul" "$hasil"
}

cek_pola 'URL PostgreSQL berkata sandi ke host selain localhost' \
  'postgres(ql)?://[^:/\s@]+:[^@\s]+@(?!localhost[:/]|127\.0\.0\.1[:/])'
cek_pola 'Token Apify' 'apify_api_[A-Za-z0-9]{20,}'
cek_pola 'Token GitHub' '\b(gh[pousr]_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{30,})'
cek_pola 'Rahasia klien Google OAuth' 'GOCSPX-[A-Za-z0-9_-]{20,}'
cek_pola 'Kunci API Render' '\brnd_[A-Za-z0-9]{20,}'
cek_pola 'Kunci privat' '-----BEGIN [A-Z ]*PRIVATE KEY-----'
cek_pola 'Nilai rahasia ditulis langsung' \
  '(JWT_SECRET|API_KEY|CRON_TOKEN|WEBHOOK_SECRET|APIFY_TOKEN|POSTGRES_PASSWORD)\s*[:=]\s*[\x22\x27]?[A-Za-z0-9+/_-]{16,}'

if [ "$gagal" -ne 0 ]; then
  echo 'Pemeriksaan rahasia GAGAL: keluarkan berkas/baris di atas dari commit.'
  echo 'Bila rahasia asli sempat ter-push, ganti rahasia itu di layanannya.'
  exit 1
fi
echo 'Pemeriksaan rahasia: tidak ada temuan.'