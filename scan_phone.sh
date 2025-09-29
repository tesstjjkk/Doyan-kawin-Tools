#!/usr/bin/env bash
# scan_phone.sh
# Script sederhana untuk menjalankan PhoneInfoga scan pada sebuah nomor telepon.
# Usage:
#   ./scan_phone.sh 085264029085
#   ./scan_phone.sh +6285264029085
#
# Hati-hati: gunakan hanya untuk nomor yang Anda punya izin untuk telusuri.
# Memerlukan: phoneinfoga binary di PATH atau Docker (image: sundowndev/phoneinfoga)

set -euo pipefail

PRINT_USAGE() {
  cat <<EOF
Usage: $0 <phone-number>
Example: $0 08******
         $0 +628******
Notes:
 - Script akan mencoba gunakan 'phoneinfoga' binary (jika ada),
   jika tidak tersedia akan pakai Docker (butuh Docker daemon aktif).
 - Output disimpan di folder ./outputs/
EOF
}

if [ "${#}" -lt 1 ]; then
  PRINT_USAGE
  exit 1
fi

RAW_NUMBER="$1"

# fungsi untuk normalisasi ke format internasional +62 (Indonesia) bila nomor mulai dengan 0
normalize() {
  num="$1"
  # hapus spasi, - dan tanda kurung
  num="$(echo "$num" | tr -d ' -()')"
  if [[ "$num" =~ ^\+ ]]; then
    echo "$num"
    return
  fi
  if [[ "$num" =~ ^0 ]]; then
    # ubah 0xxx... -> +62xxx...
    echo "+62${num:1}"
    return
  fi
  if [[ "$num" =~ ^62 ]]; then
    echo "+$num"
    return
  fi
  # fallback: kembalikan apa adanya
  echo "$num"
}

NORM_NUMBER="$(normalize "$RAW_NUMBER")"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
OUTDIR="./outputs"
mkdir -p "$OUTDIR"

OUT_JSON="${OUTDIR}/${NORM_NUMBER//+/_}_${TIMESTAMP}.json"
OUT_TXT="${OUTDIR}/${NORM_NUMBER//+/_}_${TIMESTAMP}.txt"

echo "Nomor yang diproses: $RAW_NUMBER"
echo "Format internasional: $NORM_NUMBER"
echo "Output JSON -> $OUT_JSON"
echo "Output TXT  -> $OUT_TXT"
echo

# fungsi eksekusi phoneinfoga (binary)
run_binary() {
  echo "[*] Menemukan binary 'phoneinfoga' — menggunakan binary lokal..."
  # beberapa versi phoneinfoga mengeluarkan output ke stdout; gunakan redirect
  # perintah umum: phoneinfoga scan -n <number> --format json
  if command -v phoneinfoga >/dev/null 2>&1; then
    # coba jalankan dengan flag --format json bila tersedia, fallback ke scan biasa
    if phoneinfoga --help 2>&1 | grep -q -- '--format'; then
      phoneinfoga scan -n "$NORM_NUMBER" --format json > "$OUT_JSON" 2>&1 || {
        echo "[!] Perintah phoneinfoga gagal. Coba menjalankan tanpa --format."
        phoneinfoga scan -n "$NORM_NUMBER" > "$OUT_JSON" 2>&1 || return 1
      }
    else
      phoneinfoga scan -n "$NORM_NUMBER" > "$OUT_JSON" 2>&1 || return 1
    fi
    # juga simpan versi teks (stdout -> txt)
    cat "$OUT_JSON" > "$OUT_TXT"
    return 0
  else
    return 1
  fi
}

# fungsi eksekusi via Docker image sundowndev/phoneinfoga
run_docker() {
  echo "[*] Tidak menemukan binary 'phoneinfoga'. Mencoba Docker image 'sundowndev/phoneinfoga'..."
  if ! command -v docker >/dev/null 2>&1; then
    echo "[!] Docker tidak terinstall atau tidak ditemukan di PATH. Tidak bisa lanjut."
    return 1
  fi

  # jalankan docker container sementara untuk scan
  # kita mount volume untuk menyimpan output di host (opsional). Namun phoneinfoga image biasanya hanya output ke stdout.
  docker run --rm -it sundowndev/phoneinfoga scan -n "$NORM_NUMBER" --format json > "$OUT_JSON" 2>&1 || {
    echo "[!] Perintah Docker phoneinfoga gagal. Coba jalankan manual: docker run --rm -it sundowndev/phoneinfoga"
    return 1
  }
  cat "$OUT_JSON" > "$OUT_TXT"
  return 0
}

# jalankan
if run_binary; then
  echo "[+] Selesai: hasil disimpan di $OUT_JSON dan $OUT_TXT"
  exit 0
fi

if run_docker; then
  echo "[+] Selesai (Docker): hasil disimpan di $OUT_JSON dan $OUT_TXT"
  exit 0
fi

echo "[!] Gagal: tidak ada metode yang berhasil (tidak ada binary phoneinfoga dan Docker tidak bisa dipakai)."
echo "Coba instal PhoneInfoga atau jalankan via Docker."
exit 2
