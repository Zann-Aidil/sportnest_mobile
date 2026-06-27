import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import '../constants/colors.dart';
import '../models/lapangan_model.dart';
import '../models/booking_model.dart';
import '../constants/assets.dart';
import '../controllers/booking_controller.dart';

class RiwayatBookingScreen extends StatefulWidget {
  const RiwayatBookingScreen({Key? key}) : super(key: key);

  @override
  State<RiwayatBookingScreen> createState() => _RiwayatBookingScreenState();
}

class _RiwayatBookingScreenState extends State<RiwayatBookingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final BookingController _bookingController = Get.find<BookingController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new,
              color: AppColors.blackText, size: 20),
        ),
        title: Text(
          'Riwayat Pemesanan',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.blackText,
          ),
        ),
        centerTitle: false,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.greyText,
          labelStyle: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w600),
          unselectedLabelStyle:
              GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
          tabs: const [
            Tab(text: 'Pemesanan Aktif'),
            Tab(text: 'Selesai'),
          ],
        ),
      ),
      body: Obx(() => TabBarView(
        controller: _tabController,
        children: [
          _buildBookingList(_bookingController.activeBookings, isActive: true),
          _buildBookingList(_bookingController.pastBookings, isActive: false),
        ],
      )),
    );
  }

  Widget _buildBookingList(List<BookingModel> bookings,
      {required bool isActive}) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: AppColors.greyBorder),
            const SizedBox(height: 12),
            Text(
              'Belum ada riwayat pemesanan',
              style: GoogleFonts.poppins(
                  fontSize: 14, color: AppColors.greyText),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (ctx, i) => _buildBookingCard(bookings[i], isActive, i),
    );
  }

  Widget _buildBookingCard(BookingModel booking, bool isActive, int index) {
    final Color statusColor = isActive ? AppColors.primary : AppColors.greyText;

    return FadeInLeft(
      delay: Duration(milliseconds: 100 * index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/${booking.lapanganImage}.jpg',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 50,
                        height: 50,
                        color: _getLapanganColor(booking.lapanganNama),
                        child: const Icon(Icons.sports, color: Colors.white, size: 24),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.lapanganNama,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      booking.status,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: statusColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Divider(color: AppColors.greyBorder, height: 1),
              const SizedBox(height: 14),

              // Details
              Row(
                children: [
                  Expanded(
                    child: _buildDetailItem(
                      Icons.calendar_today_outlined,
                      booking.formattedTanggal,
                    ),
                  ),
                  Expanded(
                    child: _buildDetailItem(
                      Icons.access_time,
                      '${booking.jamMulai} - ${booking.jamSelesai}',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Kode
              Row(
                children: [
                  Text(
                    'Kode: ',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.greyText,
                    ),
                  ),
                  Text(
                    booking.kodeBooking,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.greyText),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.blackText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Color _getLapanganColor(String nama) {
    if (nama.toLowerCase().contains('futsal')) return const Color(0xFF27A349);
    if (nama.toLowerCase().contains('basket')) return const Color(0xFFE8821A);
    if (nama.toLowerCase().contains('badminton')) return const Color(0xFF1976D2);
    if (nama.toLowerCase().contains('tenis')) return const Color(0xFF7B1FA2);
    return const Color(0xFF27A349);
  }

  String _getKategoriIcon(String nama) {
    return AppAssets.getKategoriIcon(nama);
  }
}
