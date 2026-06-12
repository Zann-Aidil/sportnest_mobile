import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../models/lapangan_model.dart';

class DetailLapanganScreen extends StatefulWidget {
  const DetailLapanganScreen({Key? key}) : super(key: key);

  @override
  State<DetailLapanganScreen> createState() => _DetailLapanganScreenState();
}

class _DetailLapanganScreenState extends State<DetailLapanganScreen> {
  late LapanganModel lapangan;

  @override
  void initState() {
    super.initState();
    lapangan = Get.arguments as LapanganModel? ??
        LapanganData.dummyLapangan.first;
  }

  Color _getLapanganColor(String kategori) {
    switch (kategori) {
      case 'Futsal':
        return const Color(0xFF27A349);
      case 'Basket':
        return const Color(0xFFE8821A);
      case 'Badminton':
        return const Color(0xFF1976D2);
      case 'Tenis':
        return const Color(0xFF7B1FA2);
      default:
        return const Color(0xFF27A349);
    }
  }

  IconData _getLapanganIcon(String kategori) {
    switch (kategori) {
      case 'Futsal':
        return Icons.sports_soccer;
      case 'Basket':
        return Icons.sports_basketball;
      case 'Badminton':
        return Icons.sports_tennis;
      case 'Tenis':
        return Icons.sports_tennis;
      default:
        return Icons.sports;
    }
  }

  IconData _getFasilitasIcon(String fasilitas) {
    switch (fasilitas) {
      case 'Parkir':
        return Icons.local_parking;
      case 'Mushola':
        return Icons.mosque_outlined;
      case 'Toilet':
        return Icons.wc_outlined;
      case 'Kantin':
        return Icons.restaurant_menu_outlined;
      case 'Wi-Fi':
        return Icons.wifi;
      default:
        return Icons.check_circle_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Image
                  Stack(
                    children: [
                      Container(
                        height: 240,
                        width: double.infinity,
                        color: _getLapanganColor(lapangan.kategori),
                        child: Center(
                          child: Icon(
                            _getLapanganIcon(lapangan.kategori),
                            size: 90,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                      // Back button
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 8,
                        left: 16,
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.arrow_back_ios_new,
                                color: Colors.white, size: 18),
                          ),
                        ),
                      ),
                      // Share button
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 8,
                        right: 16,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.share_outlined,
                                color: Colors.white, size: 18),
                          ),
                        ),
                      ),
                      // Dots indicator
                      Positioned(
                        bottom: 12,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildDot(true),
                            const SizedBox(width: 4),
                            _buildDot(false),
                            const SizedBox(width: 4),
                            _buildDot(false),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Text(
                          lapangan.nama,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackText,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Location
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined,
                                size: 16, color: AppColors.greyText),
                            const SizedBox(width: 4),
                            Text(
                              lapangan.lokasi,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: AppColors.greyText,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Rating
                        Row(
                          children: [
                            const Icon(Icons.star_rounded,
                                size: 18, color: Colors.amber),
                            const SizedBox(width: 4),
                            Text(
                              '${lapangan.rating}',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.blackText,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '(${lapangan.jumlahUlasan} ulasan)',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: AppColors.greyText,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Deskripsi
                        Text(
                          'Deskripsi',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackText,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          lapangan.deskripsi,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: AppColors.greyText,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Fasilitas
                        Text(
                          'Fasilitas',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackText,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: lapangan.fasilitas
                              .map((f) => _buildFasilitasItem(f))
                              .toList(),
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Bar - Price + Book Button
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        lapangan.formattedPrice,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () =>
                            Get.toNamed('/pilih-jadwal', arguments: lapangan),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: Text(
                          'Pilih Jadwal',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      width: isActive ? 20 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  Widget _buildFasilitasItem(String fasilitas) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            _getFasilitasIcon(fasilitas),
            color: AppColors.primary,
            size: 26,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          fasilitas,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: AppColors.greyText,
          ),
        ),
      ],
    );
  }
}
