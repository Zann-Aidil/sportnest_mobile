import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';

class CustomPopup extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String? imageAsset;
  final String title;
  final String primaryButtonText;
  final VoidCallback onPrimaryButtonTap;
  final String? secondaryButtonText;
  final VoidCallback? onSecondaryButtonTap;

  const CustomPopup({
    Key? key,
    this.icon,
    this.iconColor,
    this.imageAsset,
    required this.title,
    required this.primaryButtonText,
    required this.onPrimaryButtonTap,
    this.secondaryButtonText,
    this.onSecondaryButtonTap,
  }) : super(key: key);

  static void show({
    IconData? icon,
    Color? iconColor,
    String? imageAsset,
    required String title,
    required String primaryButtonText,
    required VoidCallback onPrimaryButtonTap,
    String? secondaryButtonText,
    VoidCallback? onSecondaryButtonTap,
  }) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: CustomPopup(
          icon: icon,
          iconColor: iconColor,
          imageAsset: imageAsset,
          title: title,
          primaryButtonText: primaryButtonText,
          onPrimaryButtonTap: onPrimaryButtonTap,
          secondaryButtonText: secondaryButtonText,
          onSecondaryButtonTap: onSecondaryButtonTap,
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imageAsset != null)
            Image.asset(
              imageAsset!,
              height: 120,
              width: 120,
              fit: BoxFit.contain,
              color: Colors.white,
              colorBlendMode: BlendMode.darken,
            )
          else if (icon != null)
            Icon(
              icon,
              size: 64,
              color: iconColor ?? AppColors.blackText,
            ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.blackText,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onPrimaryButtonTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                primaryButtonText,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          if (secondaryButtonText != null) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: onSecondaryButtonTap ?? () => Get.back(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  secondaryButtonText!,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
