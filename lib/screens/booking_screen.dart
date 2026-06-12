import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../models/lapangan_model.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String _selectedKategori = 'Semua';
  final _searchController = TextEditingController();

  final List<String> _kategoriList = [
    'Semua', 'Futsal', 'Basket', 'Badminton', 'Tenis'
  ];

  List<LapanganModel> get _filteredLapangan {
    if (_selectedKategori == 'Semua') return LapanganData.dummyLapangan;
    return LapanganData.dummyLapangan
        .where((l) => l.kategori == _selectedKategori)
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pesan Lapangan',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackText,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.greyBorder),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.poppins(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Cari lapangan atau lokasi...',
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 13, color: AppColors.greyText),
                        prefixIcon: const Icon(Icons.search,
                            color: AppColors.greyText, size: 20),
                        suffixIcon: const Icon(Icons.tune,
                            color: AppColors.greyText, size: 20),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _kategoriList.map((k) {
                        final isSelected = _selectedKategori == k;
                        return GestureDetector(
                          onTap: () => setState(() => _selectedKategori = k),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.greyBorder,
                              ),
                            ),
                            child: Text(
                              k,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : AppColors.greyText,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _filteredLapangan.length,
                itemBuilder: (ctx, i) {
                  final lapangan = _filteredLapangan[i];
                  return GestureDetector(
                    onTap: () =>
                        Get.toNamed('/detail-lapangan', arguments: lapangan),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16),
                            ),
                            child: Container(
                              width: 100,
                              height: 90,
                              color: _getLapanganColor(lapangan.kategori),
                              child: Icon(
                                _getLapanganIcon(lapangan.kategori),
                                size: 44,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lapangan.nama,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.blackText,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined,
                                          size: 12, color: AppColors.greyText),
                                      const SizedBox(width: 2),
                                      Text(
                                        lapangan.lokasi,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: AppColors.greyText,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.star_rounded,
                                          size: 14, color: Colors.amber),
                                      const SizedBox(width: 3),
                                      Text(
                                        '${lapangan.rating} (${lapangan.jumlahUlasan})',
                                        style: GoogleFonts.poppins(
                                          fontSize: 11,
                                          color: AppColors.greyText,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    lapangan.formattedPrice,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
