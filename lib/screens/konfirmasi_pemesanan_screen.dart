import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import '../constants/colors.dart';
import '../constants/assets.dart';
import '../models/lapangan_model.dart';

class KonfirmasiPemesananScreen extends StatefulWidget {
  const KonfirmasiPemesananScreen({Key? key}) : super(key: key);

  @override
  State<KonfirmasiPemesananScreen> createState() =>
      _KonfirmasiPemesananScreenState();
}

class _KonfirmasiPemesananScreenState
    extends State<KonfirmasiPemesananScreen> {
  late LapanganModel lapangan;
  late DateTime tanggal;
  late String jamMulai;
  late String jamSelesai;
  String _selectedMetode = 'E-Wallet';

  final List<String> _metodeList = ['E-Wallet', 'Transfer Bank', 'Kartu Kredit'];

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    lapangan = args['lapangan'] as LapanganModel? ?? LapanganData.dummyLapangan.first;
    tanggal = args['tanggal'] as DateTime? ?? DateTime.now();
    jamMulai = args['jamMulai'] as String? ?? '10:00';
    jamSelesai = args['jamSelesai'] as String? ?? '11:00';
  }

  String get _formattedTanggal {
    const days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return '${days[tanggal.weekday - 1]}, ${tanggal.day} ${months[tanggal.month - 1]} ${tanggal.year}';
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
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

  String _getKategoriIcon(String kategori) {
    return AppAssets.getKategoriIcon(kategori);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new,
              color: AppColors.blackText, size: 20),
        ),
        title: Text(
          'Konfirmasi Pemesanan',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.blackText,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Lapangan Card
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.greyBorder),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/images/${lapangan.imageUrl}.jpg',
                            width: 72,
                            height: 72,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 72,
                              height: 72,
                              color: _getLapanganColor(lapangan.kategori),
                              child: const Icon(Icons.sports, color: Colors.white, size: 32),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lapangan.nama,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppColors.blackText,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined,
                                    size: 13, color: AppColors.greyText),
                                const SizedBox(width: 3),
                                Text(
                                  lapangan.lokasi,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: AppColors.greyText,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Detail Pemesanan
                  _buildDetailRow('Tanggal', _formattedTanggal),
                  _buildDivider(),
                  _buildDetailRow('Jam', '$jamMulai - $jamSelesai'),
                  _buildDivider(),
                  _buildDetailRow('Durasi', '1 Jam'),
                  _buildDivider(),
                  _buildDetailRow(
                      'Total Harga', 'Rp ${_formatNumber(lapangan.hargaPerJam)}'),
                  _buildDivider(),

                  // Metode Pembayaran
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Metode Pembayaran',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppColors.greyText,
                          ),
                        ),
                        DropdownButton<String>(
                          value: _selectedMetode,
                          underline: const SizedBox(),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackText,
                          ),
                          items: _metodeList.map((m) {
                            return DropdownMenuItem(value: m, child: Text(m));
                          }).toList(),
                          onChanged: (val) =>
                              setState(() => _selectedMetode = val ?? _selectedMetode),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: AppColors.greyBorder, height: 1),
                  const SizedBox(height: 20),

                  // Total Pembayaran
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Pembayaran',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackText,
                        ),
                      ),
                      Text(
                        'Rp ${_formatNumber(lapangan.hargaPerJam)}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
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

          // Pay Button
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
              child: BounceInUp(
                duration: const Duration(milliseconds: 600),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => Get.toNamed('/pembayaran', arguments: {
                      'lapangan': lapangan,
                      'tanggal': tanggal,
                      'jamMulai': jamMulai,
                      'jamSelesai': jamSelesai,
                      'metode': _selectedMetode,
                    }),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Bayar Sekarang',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),    ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.greyText,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.blackText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(color: AppColors.greyBorder, height: 1);
  }
}
