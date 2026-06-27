import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../constants/colors.dart';
import '../models/lapangan_model.dart';
import '../models/booking_model.dart';
import '../controllers/user_controller.dart';
import '../controllers/booking_controller.dart';

class PembayaranScreen extends StatefulWidget {
  const PembayaranScreen({Key? key}) : super(key: key);

  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen>
    with TickerProviderStateMixin {
  late LapanganModel lapangan;
  late AnimationController _scanAnimController;
  late Animation<double> _scanAnimation;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    lapangan = args['lapangan'] as LapanganModel? ?? LapanganData.dummyLapangan.first;

    _scanAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scanAnimController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scanAnimController.dispose();
    super.dispose();
  }

  void _handlePayment() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2));

    final userController = Get.find<UserController>();
    final bookingController = Get.find<BookingController>();
    final args = Get.arguments as Map<String, dynamic>;
    final tanggal = args['tanggal'] as DateTime;
    final jamMulai = args['jamMulai'] as String;
    final jamSelesai = args['jamSelesai'] as String;
    final metode = args['metode'] as String;
    
    final kodeBooking = 'SN${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    
    final newBooking = BookingModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      lapanganId: lapangan.id,
      lapanganNama: lapangan.nama,
      lapanganLokasi: lapangan.lokasi,
      lapanganImage: lapangan.imageUrl,
      tanggal: tanggal,
      jamMulai: jamMulai,
      jamSelesai: jamSelesai,
      durasi: 1,
      totalHarga: lapangan.hargaPerJam,
      metodePembayaran: metode,
      status: 'Aktif',
      kodeBooking: kodeBooking,
      userEmail: userController.email.value,
    );
    
    await bookingController.addBooking(newBooking);

    setState(() => _isProcessing = false);
    Get.offNamed('/pembayaran-berhasil', arguments: newBooking);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new,
              color: Colors.white, size: 20),
        ),
        title: Text(
          'Scan QR Code',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_outlined, color: Colors.white, size: 22),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),

            // Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Arahkan kamera ke QR Code\nuntuk melakukan pembayaran',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // QR Scanner Frame
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Dark background
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black,
                    ),

                    // QR Code
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: QrImageView(
                          data: 'SPORTNEST-${lapangan.id}-${DateTime.now().millisecondsSinceEpoch}',
                          version: QrVersions.auto,
                          size: 250,
                          backgroundColor: Colors.white,
                          eyeStyle: const QrEyeStyle(
                            eyeShape: QrEyeShape.square,
                            color: Colors.black,
                          ),
                          dataModuleStyle: const QrDataModuleStyle(
                            dataModuleShape: QrDataModuleShape.square,
                            color: Colors.black,
                          ),
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),

                    // Scanning border corners
                    SizedBox(
                      width: 270,
                      height: 270,
                      child: CustomPaint(
                        painter: _ScannerCornerPainter(),
                      ),
                    ),

                    // Animated scan line
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: AnimatedBuilder(
                        animation: _scanAnimation,
                        builder: (ctx, _) {
                          return Stack(
                            children: [
                              Positioned(
                                top: _scanAnimation.value * 240,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 2,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        AppColors.primary.withOpacity(0.8),
                                        AppColors.primary,
                                        AppColors.primary.withOpacity(0.8),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Flash + Pay Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                children: [
                  // Flash button
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: const Icon(Icons.flashlight_on_outlined,
                        color: Colors.white, size: 24),
                  ),
                  const SizedBox(height: 20),

                  // Pay Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _isProcessing ? null : _handlePayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: _isProcessing
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            )
                          : Text(
                              'Konfirmasi Pembayaran',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScannerCornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const cornerLength = 28.0;
    const radius = 10.0;

    // Top-left
    canvas.drawLine(
        Offset(radius, 0), const Offset(cornerLength, 0), paint);
    canvas.drawLine(
        Offset(0, radius), Offset(0, cornerLength), paint);
    canvas.drawArc(
        Rect.fromLTWH(0, 0, radius * 2, radius * 2),
        3.14159, 3.14159 / 2, false, paint);

    // Top-right
    canvas.drawLine(
        Offset(size.width - cornerLength, 0),
        Offset(size.width - radius, 0), paint);
    canvas.drawLine(
        Offset(size.width, radius), Offset(size.width, cornerLength), paint);
    canvas.drawArc(
        Rect.fromLTWH(size.width - radius * 2, 0, radius * 2, radius * 2),
        -3.14159 / 2, 3.14159 / 2, false, paint);

    // Bottom-left
    canvas.drawLine(
        Offset(0, size.height - cornerLength), Offset(0, size.height - radius), paint);
    canvas.drawLine(
        Offset(radius, size.height), Offset(cornerLength, size.height), paint);
    canvas.drawArc(
        Rect.fromLTWH(0, size.height - radius * 2, radius * 2, radius * 2),
        3.14159 / 2, 3.14159 / 2, false, paint);

    // Bottom-right
    canvas.drawLine(
        Offset(size.width - cornerLength, size.height),
        Offset(size.width - radius, size.height), paint);
    canvas.drawLine(
        Offset(size.width, size.height - cornerLength),
        Offset(size.width, size.height - radius), paint);
    canvas.drawArc(
        Rect.fromLTWH(
            size.width - radius * 2, size.height - radius * 2, radius * 2, radius * 2),
        0, 3.14159 / 2, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
