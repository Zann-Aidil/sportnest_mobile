import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import '../constants/colors.dart';
import '../constants/assets.dart';
import '../models/lapangan_model.dart';
import '../controllers/user_controller.dart';
import '../widgets/custom_popup.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;
  String _selectedKategori = 'Semua';
  final _searchController = TextEditingController();

  final List<String> _kategoriList = ['Semua', 'Futsal', 'Basket', 'Badminton', 'Tenis'];

  final List<Map<String, dynamic>> _kategoriIcons = [
    {'name': 'Semua', 'icon': AppAssets.iconSemua},
    {'name': 'Futsal', 'icon': AppAssets.iconFutsal},
    {'name': 'Basket', 'icon': AppAssets.iconBasket},
    {'name': 'Badminton', 'icon': AppAssets.iconBadminton},
    {'name': 'Tenis', 'icon': AppAssets.iconTenis},
  ];

  List<LapanganModel> get _filteredLapangan {
    if (_selectedKategori == 'Semua') return LapanganData.dummyLapangan;
    return LapanganData.dummyLapangan
        .where((l) => l.kategori == _selectedKategori)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Get.arguments != null) {
        if (Get.arguments['showLoginSuccess'] == true) {
          CustomPopup.show(
            icon: Icons.check_circle_rounded,
            iconColor: AppColors.primary,
            title: 'Login Berhasil!',
            primaryButtonText: 'Lanjut',
            onPrimaryButtonTap: () => Get.back(),
          );
        } else if (Get.arguments['showRegisterSuccess'] == true) {
          final userName = Get.arguments['userName'] ?? '';
          CustomPopup.show(
            icon: Icons.celebration,
            iconColor: AppColors.primary,
            title: 'Akun Berhasil Didaftarkan!\nSelamat datang, $userName',
            primaryButtonText: 'Mulai Sekarang',
            onPrimaryButtonTap: () => Get.back(),
          );
        }
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: IndexedStack(
        index: _currentNavIndex,
        children: [
          _buildHomeBody(),
          _buildBookingBody(),
          _buildNotifikasiBody(),
          _buildProfilBody(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHomeBody() {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // App Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'SportNest',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.greyBorder),
                    ),
                    child: const Icon(Icons.notifications_outlined,
                        color: AppColors.blackText, size: 22),
                  ),
                ],
              ),
            ),
          ),

          // Greeting
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo, Selamat datang! 👋',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackText,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Search Bar
                  Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.greyBorder),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: GoogleFonts.poppins(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Cari lapangan atau olahraga...',
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 13, color: AppColors.greyText),
                        prefixIcon: const Icon(Icons.search,
                            color: AppColors.greyText, size: 20),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Hero Banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: _buildHeroBanner(),
            ),
          ),

          // Kategori Olahraga
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kategori Olahraga',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackText,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Lihat Semua',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: _buildKategoriRow(),
          ),

          // Rekomendasi Lapangan
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rekomendasi Lapangan',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackText,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) {
                  final lapangan = _filteredLapangan[i];
                  return _buildLapanganCard(lapangan, i);
                },
                childCount: _filteredLapangan.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B7C35), Color(0xFF27A349)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            right: 40,
            bottom: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Temukan Lapangan\nOlahraga Favoritmu',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Booking mudah, olahraga makin seru!',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => setState(() => _currentNavIndex = 1),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 7),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Cari Sekarang',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Athlete illustration (icon placeholder)
          Positioned(
            right: 16,
            bottom: 8,
            child: Icon(
              Icons.sports_soccer,
              size: 70,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKategoriRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _kategoriIcons.asMap().entries.map((entry) {
          final index = entry.key;
          final k = entry.value;
          final isSelected = _selectedKategori == k['name'];
          return FadeInDown(
            delay: Duration(milliseconds: 100 * index),
            child: GestureDetector(
              onTap: () => setState(() => _selectedKategori = k['name'] as String),
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.greyBorder,
                        width: isSelected ? 2.0 : 1.0,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    child: Center(
                      child: Image.asset(
                        k['icon'] as String,
                        width: 36,
                        height: 36,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    k['name'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected ? AppColors.primary : AppColors.greyText,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLapanganCard(LapanganModel lapangan, int index) {
    return FadeInUp(
      delay: Duration(milliseconds: 100 * index),
      child: GestureDetector(
      onTap: () => Get.toNamed('/detail-lapangan', arguments: lapangan),
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
            // Image
            Hero(
              tag: 'lapangan_image_${lapangan.id}',
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: Image.asset(
                  'assets/images/${lapangan.imageUrl}.jpg',
                  width: 100,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 100,
                    height: 90,
                    color: AppColors.lightGrey,
                    child: const Icon(Icons.image_not_supported, color: AppColors.greyText),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getLapanganColor(lapangan.kategori).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            lapangan.kategori,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _getLapanganColor(lapangan.kategori),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            lapangan.nama,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackText,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
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
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            size: 14, color: Colors.amber),
                        const SizedBox(width: 3),
                        Text(
                          '${lapangan.rating}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackText,
                          ),
                        ),
                        Text(
                          ' (${lapangan.jumlahUlasan})',
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
    ));
  }

  // Booking Tab Body
  Widget _buildBookingBody() {
    return SafeArea(
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
                // Search
                Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.greyBorder),
                  ),
                  child: TextField(
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
                // Kategori Filter
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
                            color:
                                isSelected ? AppColors.primary : Colors.white,
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
                              color:
                                  isSelected ? Colors.white : AppColors.greyText,
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

          // Lapangan List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredLapangan.length,
              itemBuilder: (ctx, i) => _buildBookingLapanganCard(_filteredLapangan[i]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingLapanganCard(LapanganModel lapangan) {
    return GestureDetector(
      onTap: () => Get.toNamed('/detail-lapangan', arguments: lapangan),
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
        child: Column(
          children: [
            // Image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                'assets/images/${lapangan.imageUrl}.jpg',
                height: 130,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 130,
                  width: double.infinity,
                  color: AppColors.lightGrey,
                  child: const Icon(Icons.image_not_supported, size: 40, color: AppColors.greyText),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          lapangan.nama,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackText,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded,
                              size: 15, color: Colors.amber),
                          const SizedBox(width: 3),
                          Text(
                            '${lapangan.rating} (${lapangan.jumlahUlasan})',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 14, color: AppColors.greyText),
                      const SizedBox(width: 3),
                      Text(
                        lapangan.lokasi,
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: AppColors.greyText),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        lapangan.formattedPrice,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Pesan',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotifikasiBody() {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Text(
              'Notifikasi',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.blackText,
              ),
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: Column(
              children: [
                Icon(Icons.notifications_off_outlined,
                    size: 64, color: AppColors.greyBorder),
                const SizedBox(height: 12),
                Text(
                  'Belum ada notifikasi',
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: AppColors.greyText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Avatar
            CircleAvatar(
              radius: 45,
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: const Icon(Icons.person, size: 50, color: AppColors.primary),
            ),
            const SizedBox(height: 12),
            // Name & Email from controller (reactive)
            Obx(() {
              final userController = Get.find<UserController>();
              return Column(
                children: [
                  Text(
                    userController.name.value.isNotEmpty
                        ? userController.name.value
                        : 'Pengguna SportNest',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackText,
                    ),
                  ),
                  Text(
                    userController.email.value,
                    style: GoogleFonts.poppins(
                        fontSize: 13, color: AppColors.greyText),
                  ),
                ],
              );
            }),
            const SizedBox(height: 24),
            // Menu items
            ...[
              {'icon': Icons.history, 'label': 'Riwayat Pemesanan', 'route': '/riwayat-booking'},
              {'icon': Icons.payment_outlined, 'label': 'Metode Pembayaran', 'route': null},
              {'icon': Icons.notifications_outlined, 'label': 'Notifikasi', 'route': null},
              {'icon': Icons.help_outline, 'label': 'Bantuan', 'route': null},
              {'icon': Icons.info_outline, 'label': 'Tentang Kami', 'route': null},
            ].map((item) => _buildProfileMenuItem(
                  icon: item['icon'] as IconData,
                  label: item['label'] as String,
                  onTap: () {
                    if (item['route'] != null) Get.toNamed(item['route'] as String);
                  },
                )),
            const SizedBox(height: 8),
            _buildProfileMenuItem(
              icon: Icons.logout,
              label: 'Keluar',
              color: AppColors.error,
              onTap: () {
                CustomPopup.show(
                  icon: Icons.meeting_room_outlined,
                  iconColor: AppColors.error,
                  title: 'Oh no! You\'re leaving...\nAre you sure?',
                  primaryButtonText: 'Nah, Just Kidding',
                  onPrimaryButtonTap: () => Get.back(),
                  secondaryButtonText: 'Yes, Log Me Out',
                  onSecondaryButtonTap: () {
                    Get.back(); // Close dialog
                    Get.find<UserController>().logout(showSuccess: true);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon,
                color: color ?? AppColors.blackText, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: color ?? AppColors.blackText,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                size: 14, color: color ?? AppColors.greyText),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home_rounded, 'label': 'Beranda'},
      {'icon': Icons.calendar_today_rounded, 'label': 'Pesanan'},
      {'icon': Icons.notifications_rounded, 'label': 'Notifikasi'},
      {'icon': Icons.person_rounded, 'label': 'Profil'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final isSelected = _currentNavIndex == i;
              return GestureDetector(
                onTap: () => setState(() => _currentNavIndex = i),
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        items[i]['icon'] as IconData,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.greyText,
                        size: 24,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        items[i]['label'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.greyText,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
