# 🔍 README — Cek Jejak Digital Berdasarkan Nomor Telepon

Panduan singkat menggunakan kombinasi pengecekan manual + tool OSINT (PhoneInfoga) untuk menyelidiki nomor telepon (contoh: `08********`).  
Dokumen ini dibuat untuk penggunaan **legal dan etis** (cek jejak publik sendiri atau nomor yang Anda punya izin untuk telusuri).

---

## Ringkasan Singkat
- Tujuan: Menemukan jejak publik (forum, iklan, akun sosial, laporan spam) terkait sebuah nomor telepon.
- Metode: 1) Pencarian manual (Google, media sosial, marketplace), 2) Aplikasi Caller ID (Truecaller/Whoscall/GetContact), 3) Tool OSINT otomatis (PhoneInfoga).
- Hati-hati: Jangan mencoba mendapatkan data pribadi sensitif (KTP, OTP, data bank). Gunakan alat ini untuk menemukan **jejak publik** saja.

---

## Daftar isi
1. Prasyarat
2. Langkah manual & sumber yang disarankan
3. PhoneInfoga — instalasi & contoh penggunaan
4. Contoh alur pengecekan (quick checklist)
5. Interpretasi hasil & next steps
6. Etika & legalitas

---

## 1. Prasyarat
- Komputer (Linux/macOS/Windows). Untuk Windows kemungkinan perlu WSL atau Docker.  
- Koneksi internet.
- (Opsional) Akun API gratis seperti NumVerify jika ingin hasil geolokasi/validasi lebih baik.

---

## 2. Langkah manual & sumber yang disarankan
Sebelum pakai tool otomatis, cek manual dulu:

- **Google / mesin pencari**  
  Coba varian: `08********`, `+628******`, `628******`.  
  Lihat hasil di forum, blog, marketplace, atau laporan penipuan.

- **Truecaller / Whoscall / GetContact**  
  Pasang aplikasi, masukkan atau simpan nomor lalu lihat tag/nama yang orang lain gunakan.

- **Media sosial & marketplace**  
  Cari nomor di Facebook, Instagram, Telegram, Twitter (X), OLX, Tokopedia, Bukalapak, Kaskus, dsb.

- **WhatsApp / Telegram**  
  Simpan nomor ke kontak lalu buka di WhatsApp/Telegram untuk melihat foto profil, nama, atau info status (jika tersedia).

- **Situs pelaporan spam / blokir**  
  Cek tempat orang melaporkan nomor spam (mis. Whoscall, TelGuarder, atau forum lokal).

---

## 3. PhoneInfoga — instalasi & contoh penggunaan
PhoneInfoga adalah framework OSINT untuk nomor telepon yang populer — bisa dipakai dari CLI atau sebagai web API. Dokumentasi resmi dan repo tersedia untuk detail lebih lanjut.  [oai_citation:0‡GitHub](https://github.com/sundowndev/phoneinfoga?utm_source=chatgpt.com)

### 3.1 Opsi 1 — Binary (direkomendasikan)
1. Buka halaman rilis GitHub PhoneInfoga → download binary untuk OS Anda (lihat rilis).  [oai_citation:1‡GitHub](https://github.com/sundowndev/phoneinfoga/releases?utm_source=chatgpt.com)  
2. Ekstrak file dan beri izin eksekusi (Linux/macOS):
   ```bash
   tar -xf PhoneInfoga_Linux_x86_64.tar.gz
   ./phoneinfoga version


# 📑 Dokumentasi — Script `scan_phone.sh`

Script ini digunakan untuk menjalankan **PhoneInfoga** guna melakukan OSINT (Open Source Intelligence) pada nomor telepon.  
Hasil akan disimpan dalam format `.json` dan `.txt` di folder `outputs/`.

⚠️ **Catatan Penting**:  
Gunakan script ini hanya untuk **nomor yang Anda miliki izin untuk telusuri**. Hasil yang ditampilkan adalah jejak publik, bukan data pribadi sensitif.

---

## 🔧 Prasyarat
- Sistem operasi: Linux / macOS (untuk Windows bisa via WSL atau Docker).
- **PhoneInfoga** binary *atau* Docker dengan image `sundowndev/phoneinfoga`.
- Bash (sudah tersedia di Linux/macOS, di Windows gunakan WSL/PowerShell dengan bash).

---

## 📥 Instalasi
1. Clone repo atau salin file `scan_phone.sh`.
2. Beri izin eksekusi:
   ```bash
   chmod +x scan_phone.sh
