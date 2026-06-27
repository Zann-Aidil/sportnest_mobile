import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// Import constants
import 'constants/colors.dart';
import 'constants/strings.dart';

// Import screens
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/booking_screen.dart';
import 'screens/detail_lapangan_screen.dart';
import 'screens/pilih_jadwal_screen.dart';
import 'screens/konfirmasi_pemesanan_screen.dart';
import 'screens/pembayaran_screen.dart';
import 'screens/pembayaran_berhasil_screen.dart';
import 'screens/riwayat_booking_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/payment_method_screen.dart';
import 'screens/edit_profile_screen.dart';

// Import bindings
import 'bindings/initial_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      defaultTransition: Transition.cupertino,

      // Theme Configuration
      theme: ThemeData(
        // Primary Color
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.bgWhite,
        useMaterial3: true,

        // Color Scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          error: AppColors.error,
          surface: AppColors.bgWhite,
          brightness: Brightness.light,
        ),

        // AppBar Theme
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.blackText,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.blackText,
          ),
        ),

        // Text Themes
        textTheme: TextTheme(
          // Large Title
          displayLarge: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: AppColors.blackText,
          ),
          // Medium Title
          displayMedium: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.blackText,
          ),
          // Small Title
          displaySmall: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.blackText,
          ),
          // Heading
          headlineSmall: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.blackText,
          ),
          // Body Large
          bodyLarge: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.blackText,
          ),
          // Body Medium
          bodyMedium: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.greyText,
          ),
          // Body Small
          bodySmall: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.greyText,
          ),
          // Label
          labelLarge: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),

        // Button Themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Outlined Button Theme
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary, width: 1.5),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Text Button Theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            textStyle: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.lightGrey,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.greyBorder, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.greyBorder, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.error, width: 1),
          ),
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            color: AppColors.greyText,
          ),
          labelStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),

        // Card Theme
        cardTheme: CardThemeData(
          color: AppColors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.all(0),
        ),
      ),

      // Initial Route
      initialRoute: '/splash',

      // Routes dengan GetX
      getPages: [
        GetPage(
          name: '/splash',
          page: () => const SplashScreen(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/register',
          page: () => const RegisterScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/booking',
          page: () => const BookingScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/detail-lapangan',
          page: () => const DetailLapanganScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/pilih-jadwal',
          page: () => const PilihJadwalScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/konfirmasi-pemesanan',
          page: () => const KonfirmasiPemesananScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/pembayaran',
          page: () => const PembayaranScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/pembayaran-berhasil',
          page: () => const PembayaranBerhasilScreen(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/riwayat-booking',
          page: () => const RiwayatBookingScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/profile',
          page: () => const ProfileScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/payment-method',
          page: () => const PaymentMethodScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/edit-profile',
          page: () => const EditProfileScreen(),
          transition: Transition.rightToLeft,
        ),
      ],
    );
  }
}
