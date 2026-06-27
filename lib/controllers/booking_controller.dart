import 'package:get/get.dart';
import '../models/booking_model.dart';
import '../services/database_service.dart';
import 'user_controller.dart';

class BookingController extends GetxController {
  var activeBookings = <BookingModel>[].obs;
  var pastBookings = <BookingModel>[].obs;
  var isLoading = false.obs;

  final UserController userController = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();
    // Auto-reload saat userId berubah (login/logout)
    ever(userController.userId, (_) => loadBookings());
    loadBookings();
  }

  /// Muat semua booking milik user yang sedang login dari SQLite
  Future<void> loadBookings() async {
    final currentUserId = userController.userId.value;
    if (currentUserId == 0) {
      activeBookings.clear();
      pastBookings.clear();
      return;
    }

    isLoading.value = true;
    try {
      final allBookings = await DatabaseService.instance
          .getBookingsByUserId(currentUserId);

      activeBookings.value =
          allBookings.where((b) => b.status == 'Aktif').toList();
      pastBookings.value = allBookings
          .where((b) => b.status == 'Selesai' || b.status == 'Dibatalkan')
          .toList();
    } catch (e) {
      activeBookings.clear();
      pastBookings.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// Simpan booking baru ke SQLite
  Future<void> addBooking(BookingModel newBooking) async {
    final currentUserId = userController.userId.value;
    if (currentUserId == 0) return;

    await DatabaseService.instance.addBooking(newBooking, currentUserId);
    await loadBookings(); // Refresh tampilan
  }

  /// Batalkan booking
  Future<void> cancelBooking(String bookingId) async {
    await DatabaseService.instance.updateBookingStatus(bookingId, 'Dibatalkan');
    await loadBookings();
  }

  /// Tandai booking sebagai selesai
  Future<void> completeBooking(String bookingId) async {
    await DatabaseService.instance.updateBookingStatus(bookingId, 'Selesai');
    await loadBookings();
  }
}
