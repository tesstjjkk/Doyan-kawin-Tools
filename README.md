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
