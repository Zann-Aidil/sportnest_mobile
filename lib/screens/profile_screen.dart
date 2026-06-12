import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
          'Profil',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.blackText,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: const Icon(Icons.person, size: 44, color: AppColors.primary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ahmad Rizky',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.blackText,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'ahmad.rizky@email.com',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: AppColors.greyText,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '+62 812 3456 7890',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: AppColors.greyText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.edit_outlined,
                          color: AppColors.primary, size: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Menu List
            _buildMenuSection(
              title: 'Pemesanan',
              items: [
                _MenuItem(
                  icon: Icons.history_rounded,
                  label: 'Riwayat Pemesanan',
                  onTap: () => Get.toNamed('/riwayat-booking'),
                ),
              ],
            ),
            const SizedBox(height: 12),

            _buildMenuSection(
              title: 'Akun',
              items: [
                _MenuItem(
                  icon: Icons.payment_outlined,
                  label: 'Metode Pembayaran',
                  onTap: () {},
                ),
                _MenuItem(
                  icon: Icons.notifications_outlined,
                  label: 'Notifikasi',
                  onTap: () {},
                ),
                _MenuItem(
                  icon: Icons.lock_outline,
                  label: 'Ubah Kata Sandi',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 12),

            _buildMenuSection(
              title: 'Lainnya',
              items: [
                _MenuItem(
                  icon: Icons.help_outline,
                  label: 'Bantuan',
                  onTap: () {},
                ),
                _MenuItem(
                  icon: Icons.info_outline,
                  label: 'Tentang Kami',
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Logout
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () => Get.offAllNamed('/login'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.error.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.logout, color: AppColors.error, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Keluar',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection({
    required String title,
    required List<_MenuItem> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.greyText,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: items.asMap().entries.map((e) {
              final i = e.key;
              final item = e.value;
              return Column(
                children: [
                  GestureDetector(
                    onTap: item.onTap,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          Icon(item.icon,
                              color: AppColors.blackText, size: 20),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              item.label,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackText,
                              ),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              size: 14, color: AppColors.greyText),
                        ],
                      ),
                    ),
                  ),
                  if (i < items.length - 1)
                    const Divider(
                      height: 1,
                      indent: 50,
                      color: AppColors.divider,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}
