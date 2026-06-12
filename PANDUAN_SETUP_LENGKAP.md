═══════════════════════════════════════════════════════════════════════════════
  📱 PANDUAN SETUP SPORTNEST MOBILE - STEP BY STEP
═══════════════════════════════════════════════════════════════════════════════

🎯 OVERVIEW:
Anda sudah mendapatkan 3 file fundamental:
  1. main.dart - Setup routing dan theme global
  2. constants/colors.dart - Semua warna yang digunakan
  3. constants/strings.dart - Semua text yang digunakan

Plus: 12 screen stubs untuk kompilasi pertama

═══════════════════════════════════════════════════════════════════════════════
LANGKAH 1: UPDATE pubspec.yaml (10 MENIT)
═══════════════════════════════════════════════════════════════════════════════

📁 Buka file: pubspec.yaml di root project

Cari bagian 'dependencies:' dan GANTI SELURUH ISI DENGAN INI:

```yaml
dependencies:
  flutter:
    sdk: flutter
  # UI & Navigation
  cupertino_icons: ^1.0.2
  get: ^4.6.5
  google_fonts: ^6.1.0
  
  # Icons & Images
  flutter_svg: ^2.0.7
  cached_network_image: ^3.3.0
  
  # State Management
  provider: ^6.0.8
  
  # API & Data
  http: ^1.1.0
  dio: ^5.3.1
  
  # QR Code & Barcode
  qr_flutter: ^4.1.0
  
  # Payment
  flutter_credit_card: ^4.0.1
  
  # DateTime Picker
  intl: ^0.19.0
  
  # Local Storage
  shared_preferences: ^2.2.1
  
  # Loading & Animations
  shimmer: ^3.0.0
  lottie: ^2.4.0
```

⚠️ PENTING: 
- Jangan ubah flutter: sdk bagian, hanya dependencies saja!
- Pastikan indentasi konsisten (2 spaces)

Setelah edit, di TERMINAL jalankan:
```bash
flutter pub get
```

Tunggu sampai selesai (akan ada notif "Running: flutter pub get")

✅ Cek: Tidak ada error di console

═══════════════════════════════════════════════════════════════════════════════
LANGKAH 2: BUAT STRUKTUR FOLDER (5 MENIT)
═══════════════════════════════════════════════════════════════════════════════

Di dalam folder 'lib/', buat folder-folder berikut:

lib/
├── constants/          (← BUAT FOLDER)
├── screens/            (← SUDAH ADA)
├── models/             (← BUAT FOLDER)
├── widgets/            (← BUAT FOLDER)
├── services/           (← BUAT FOLDER)
└── utils/              (← BUAT FOLDER)

Caranya:
1. Di VS Code, right-click pada folder 'lib'
2. Pilih "New Folder"
3. Ketik nama folder yang diinginkan
4. Lakukan untuk setiap folder di atas

✅ Cek: Semua folder sudah terbuat

═══════════════════════════════════════════════════════════════════════════════
LANGKAH 3: COPY FILE CONSTANTS (5 MENIT)
═══════════════════════════════════════════════════════════════════════════════

Anda sudah punya 2 file:
  ✓ colors.dart
  ✓ strings.dart

Tempat mereka:
📁 lib/constants/colors.dart    ← Dari file colors.dart
📁 lib/constants/strings.dart   ← Dari file strings.dart

Caranya:
1. Buat 2 file baru di folder constants/:
   - Right-click pada folder 'constants'
   - Pilih "New File"
   - Beri nama 'colors.dart'
   - Copy-paste isi file colors.dart yang diberikan

2. Ulangi untuk strings.dart

✅ Cek: File sudah ada di lib/constants/

═══════════════════════════════════════════════════════════════════════════════
LANGKAH 4: GANTI main.dart (5 MENIT)
═══════════════════════════════════════════════════════════════════════════════

📁 Buka file: lib/main.dart

HAPUS semua isi dan GANTI dengan isi main.dart yang baru

⚠️ PENTING: Pastikan import paths sudah sesuai:
  - import 'constants/colors.dart';
  - import 'constants/strings.dart';
  - import 'screens/splash_screen.dart';
  - (dan semua screen lainnya)

✅ Cek: File main.dart sudah di-update, tidak ada error merah di garis import

═══════════════════════════════════════════════════════════════════════════════
LANGKAH 5: BUAT SCREEN STUBS (10 MENIT)
═══════════════════════════════════════════════════════════════════════════════

Buat 12 file screen baru dengan nama:

Di folder 'lib/screens/', buat file-file ini:
  1. splash_screen.dart
  2. login_screen.dart
  3. register_screen.dart
  4. home_screen.dart
  5. booking_screen.dart
  6. detail_lapangan_screen.dart
  7. pilih_jadwal_screen.dart
  8. konfirmasi_pemesanan_screen.dart
  9. pembayaran_screen.dart
  10. pembayaran_berhasil_screen.dart
  11. riwayat_booking_screen.dart
  12. profile_screen.dart

Caranya:
1. Right-click folder 'screens'
2. Pilih "New File"
3. Ketik nama file (misal: splash_screen.dart)
4. Copy-paste stub code dari file 'screen_stubs.txt'
   (Setiap screen dipisah dengan "---")

💡 TIPS: Buat satu file, copy-paste kode stub-nya, lalu buat file berikutnya

✅ Cek: Semua 12 file sudah terbuat dan tidak ada error

═══════════════════════════════════════════════════════════════════════════════
LANGKAH 6: TEST RUN (5 MENIT)
═══════════════════════════════════════════════════════════════════════════════

Di terminal, jalankan:
```bash
flutter run
```

Atau tekan F5 di VS Code

Tunggu proses build selesai (sekitar 1-2 menit untuk pertama kali)

✅ Cek Sukses Jika:
  - Emulator menampilkan splash screen SportNest
  - Tidak ada error merah
  - Setelah 3 detik, otomatis pindah ke login screen
  - Tombol back berfungsi normal

❌ Jika Ada Error:
  - Scroll ke atas di terminal untuk lihat error message
  - Cek import paths di main.dart
  - Pastikan semua file sudah terbuat
  - Jalankan: flutter clean && flutter pub get

═══════════════════════════════════════════════════════════════════════════════
LANGKAH 7: NEXT - BUILD SCREEN PERTAMA (LOGIN SCREEN)
═══════════════════════════════════════════════════════════════════════════════

Setelah project berhasil run, saya akan buat:
  ✓ Login Screen dengan form yang bagus
  ✓ Input validation
  ✓ Social login buttons (Google & Facebook)

Kode akan diberikan file-by-file dengan penjelasan detail.

═══════════════════════════════════════════════════════════════════════════════
🎓 TROUBLESHOOTING
═══════════════════════════════════════════════════════════════════════════════

Error: "Cannot find 'colors.dart'"
→ Pastikan file ada di lib/constants/colors.dart

Error: "Undefined name 'GetX'"
→ Jalankan: flutter pub get

Error: "Could not build the app"
→ Jalankan: flutter clean && flutter pub get && flutter run

Error di Android build:
→ Pastikan Android SDK sudah update: flutter doctor

═══════════════════════════════════════════════════════════════════════════════
📝 CHECKLIST BEFORE RUNNING
═══════════════════════════════════════════════════════════════════════════════

☐ pubspec.yaml sudah di-update dengan semua packages
☐ flutter pub get sudah dijalankan
☐ Folder constants/, models/, widgets/ sudah dibuat
☐ File colors.dart & strings.dart ada di lib/constants/
☐ File main.dart sudah diganti dengan yang baru
☐ Semua 12 screen files sudah dibuat (di lib/screens/)
☐ Emulator Pixel 7 sudah running
☐ VS Code tidak menunjukkan error merah pada import

═══════════════════════════════════════════════════════════════════════════════

Setelah semua setup selesai dan project berhasil run, reply dengan:
"BERHASIL" atau sertakan screenshot splash screen-nya!

Kemudian saya akan lanjut dengan step berikutnya: BUILD LOGIN SCREEN yang BAGUS! 🎨

═══════════════════════════════════════════════════════════════════════════════
