import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import '../constants/colors.dart';
import '../models/lapangan_model.dart';

class PilihJadwalScreen extends StatefulWidget {
  const PilihJadwalScreen({Key? key}) : super(key: key);

  @override
  State<PilihJadwalScreen> createState() => _PilihJadwalScreenState();
}

class _PilihJadwalScreenState extends State<PilihJadwalScreen> {
  late LapanganModel lapangan;
  late DateTime _selectedDate;
  String? _selectedSlot;

  final List<DateTime> _weekDays = [];
  final List<String> _timeSlots = [
    '08:00 - 09:00',
    '09:00 - 10:00',
    '10:00 - 11:00',
    '11:00 - 12:00',
    '12:00 - 13:00',
    '13:00 - 14:00',
    '14:00 - 15:00',
    '15:00 - 16:00',
  ];

  final Set<String> _bookedSlots = {'09:00 - 10:00', '13:00 - 14:00'};

  @override
  void initState() {
    super.initState();
    lapangan = Get.arguments as LapanganModel? ?? LapanganData.dummyLapangan.first;
    _selectedDate = DateTime.now();

    // Generate next 5 weekdays
    final now = DateTime.now();
    for (int i = 0; i < 5; i++) {
      _weekDays.add(now.add(Duration(days: i)));
    }
    _selectedDate = _weekDays.first;
  }

  String _getDayName(DateTime date) {
    const days = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
    return days[date.weekday % 7];
  }

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');
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
          'Pilih Jadwal',
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
                  // Pilih Tanggal
                  Text(
                    'Pilih Tanggal',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackText,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Date Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: _weekDays.map((date) {
                      final isSelected = date.day == _selectedDate.day &&
                          date.month == _selectedDate.month;
                      return GestureDetector(
                        onTap: () => setState(() {
                          _selectedDate = date;
                          _selectedSlot = null;
                        }),
                        child: Container(
                          width: 56,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.greyBorder,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                _getDayName(date),
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? Colors.white.withOpacity(0.85)
                                      : AppColors.greyText,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${date.day}',
                                style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.blackText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 28),

                  // Pilih Jam
                  Text(
                    'Pilih Jam',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackText,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Time Slots
                  ...List.generate(_timeSlots.length, (i) {
                    final slot = _timeSlots[i];
                    final isBooked = _bookedSlots.contains(slot);
                    final isSelected = _selectedSlot == slot;

                    return GestureDetector(
                      onTap: isBooked
                          ? null
                          : () => setState(() => _selectedSlot = slot),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary.withOpacity(0.08)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : isBooked
                                    ? AppColors.greyBorder
                                    : AppColors.greyBorder,
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  slot,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isBooked
                                        ? AppColors.greyText
                                        : isSelected
                                            ? AppColors.primary
                                            : AppColors.blackText,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Rp ${_formatNumber(lapangan.hargaPerJam)}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: isBooked
                                        ? AppColors.greyText
                                        : isSelected
                                            ? AppColors.primary
                                            : AppColors.greyText,
                                  ),
                                ),
                              ],
                            ),
                            if (isBooked)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.greyBorder,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  'Terbooking',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: AppColors.greyText,
                                  ),
                                ),
                              ),
                            if (isSelected && !isBooked)
                              const Icon(Icons.check_circle_rounded,
                                  color: AppColors.primary, size: 22),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Bottom Button
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
                    onPressed: _selectedSlot == null
                        ? null
                        : () {
                            final jamParts = _selectedSlot!.split(' - ');
                            Get.toNamed('/konfirmasi-pemesanan', arguments: {
                              'lapangan': lapangan,
                              'tanggal': _selectedDate,
                              'jamMulai': jamParts[0],
                              'jamSelesai': jamParts[1],
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColors.greyBorder,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Lanjutkan',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
