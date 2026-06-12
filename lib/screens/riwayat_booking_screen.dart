import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../models/lapangan_model.dart';

class RiwayatBookingScreen extends StatefulWidget {
  const RiwayatBookingScreen({Key? key}) : super(key: key);

  @override
  State<RiwayatBookingScreen> createState() => _RiwayatBookingScreenState();
}

class _RiwayatBookingScreenState extends State<RiwayatBookingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _activeBookings = [
    {
      'lapangan': LapanganData.dummyLapangan[0],
      'tanggal': 'Selasa, 20 Mei 2025',
      'jam': '10:00 - 11:00',
      'status': 'Aktif',
      'kode': 'SN12345',
    },
  ];

  final List<Map<String, dynamic>> _pastBookings = [
    {
      'lapangan': LapanganData.dummyLapangan[1],
      'tanggal': 'Sabtu, 10 Mei 2025',
      'jam': '14:00 - 15:00',
      'status': 'Selesai',
      'kode': 'SN11234',
    },
    {
      'lapangan': LapanganData.dummyLapangan[2],
      'tanggal': 'Minggu, 4 Mei 2025',
      'jam': '08:00 - 09:00',
      'status': 'Selesai',
      'kode': 'SN10123',
    },
  ];

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
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBookingList(_activeBookings, isActive: true),
          _buildBookingList(_pastBookings, isActive: false),
        ],
      ),
    );
  }

  Widget _buildBookingList(List<Map<String, dynamic>> bookings,
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
      itemBuilder: (ctx, i) => _buildBookingCard(bookings[i], isActive),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking, bool isActive) {
    final lapangan = booking['lapangan'] as LapanganModel;
    final Color statusColor = isActive ? AppColors.primary : AppColors.greyText;

    return Container(
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
                  child: Container(
                    width: 50,
                    height: 50,
                    color: _getLapanganColor(lapangan.kategori),
                    child: Icon(
                      _getLapanganIcon(lapangan.kategori),
                      color: Colors.white.withOpacity(0.8),
                      size: 26,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lapangan.nama,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackText,
                        ),
                      ),
                      Text(
                        lapangan.lokasi,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.greyText,
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
                    booking['status'] as String,
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
                    booking['tanggal'] as String,
                  ),
                ),
                Expanded(
                  child: _buildDetailItem(
                    Icons.access_time,
                    booking['jam'] as String,
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
                  booking['kode'] as String,
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

  Color _getLapanganColor(String kategori) {
    switch (kategori) {
      case 'Futsal': return const Color(0xFF27A349);
      case 'Basket': return const Color(0xFFE8821A);
      case 'Badminton': return const Color(0xFF1976D2);
      case 'Tenis': return const Color(0xFF7B1FA2);
      default: return const Color(0xFF27A349);
    }
  }

  IconData _getLapanganIcon(String kategori) {
    switch (kategori) {
      case 'Futsal': return Icons.sports_soccer;
      case 'Basket': return Icons.sports_basketball;
      case 'Badminton':
      case 'Tenis': return Icons.sports_tennis;
      default: return Icons.sports;
    }
  }
}
