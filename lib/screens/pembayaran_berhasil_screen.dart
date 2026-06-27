import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../models/booking_model.dart';
import '../controllers/booking_controller.dart';

class PembayaranBerhasilScreen extends StatefulWidget {
  const PembayaranBerhasilScreen({Key? key}) : super(key: key);

  @override
  State<PembayaranBerhasilScreen> createState() => _PembayaranBerhasilScreenState();
}

class _PembayaranBerhasilScreenState extends State<PembayaranBerhasilScreen> {
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    _saveBooking();
  }

  Future<void> _saveBooking() async {
    final booking = Get.arguments as BookingModel?;
    if (booking == null || _saved) return;
    _saved = true;
    try {
      final bookingController = Get.find<BookingController>();
      await bookingController.addBooking(booking);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final booking = Get.arguments as BookingModel?;
    if (booking == null) return const Scaffold(body: Center(child: Text('Data tidak ditemukan')));

    final kodeBooking = booking.kodeBooking;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Success Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  size: 60,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Pembayaran Berhasil!',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackText,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Terima kasih atas pemesanan Anda',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.greyText,
                ),
              ),
              const SizedBox(height: 32),

              // Booking Code Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.greyBorder),
                ),
                child: Column(
                  children: [
                    Text(
                      'Kode Pemesanan',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppColors.greyText,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      kodeBooking,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: AppColors.greyBorder),
                    const SizedBox(height: 12),
                    _buildInfoRow('Lapangan', booking.lapanganNama),
                    const SizedBox(height: 6),
                    _buildInfoRow('Lokasi', booking.lapanganLokasi),
                    const SizedBox(height: 6),
                    _buildInfoRow('Harga', booking.formattedHarga),
                  ],
                ),
              ),

              const Spacer(),

              // Buttons
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () => Get.toNamed('/riwayat-booking'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Lihat Detail Pemesanan',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Get.offAllNamed('/home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Kembali ke Beranda',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 13, color: AppColors.greyText),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.blackText,
          ),
        ),
      ],
    );
  }
}
