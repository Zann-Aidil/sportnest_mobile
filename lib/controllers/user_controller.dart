import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/database_service.dart';

class UserController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var isLoggedIn = false.obs;
  var userId = 0.obs; // ID dari SQLite

  @override
  void onInit() {
    super.onInit();
    loadSession();
  }

  /// Memuat sesi login yang tersimpan (hanya id + email)
  Future<void> loadSession() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUserId = prefs.getInt('userId') ?? 0;
    final savedEmail = prefs.getString('userEmail') ?? '';
    final loggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (loggedIn && savedUserId > 0) {
      userId.value = savedUserId;
      email.value = savedEmail;
      isLoggedIn.value = true;
      await _loadProfileFromDB(savedUserId);
    }
  }

  /// Ambil data profil terbaru dari database
  Future<void> _loadProfileFromDB(int id) async {
    try {
      final db = DatabaseService.instance;
      final userData = await db.getUserByEmail(email.value);
      if (userData != null) {
        name.value = userData['namaLengkap'] ?? '';
        phone.value = userData['noTelepon'] ?? '';
        userId.value = userData['id'] as int;
      }
    } catch (e) {
      // ignore
    }
  }

  /// Dipanggil setelah login berhasil
  Future<void> setUserFromDB(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    final id = userData['id'] as int;

    userId.value = id;
    name.value = userData['namaLengkap'] ?? '';
    email.value = userData['email'] ?? '';
    phone.value = userData['noTelepon'] ?? '';
    isLoggedIn.value = true;

    await prefs.setInt('userId', id);
    await prefs.setString('userEmail', email.value);
    await prefs.setBool('isLoggedIn', true);
  }

  /// Update profil — simpan ke DB dan refresh state
  Future<void> updateProfile(String newName, String newPhone) async {
    if (userId.value == 0) return;
    await DatabaseService.instance.updateUser(
      userId: userId.value,
      namaLengkap: newName,
      noTelepon: newPhone,
    );
    name.value = newName;
    phone.value = newPhone;
  }

  /// Logout — bersihkan sesi
  Future<void> logout({bool showSuccess = false}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('userEmail');
    await prefs.setBool('isLoggedIn', false);

    userId.value = 0;
    name.value = '';
    email.value = '';
    phone.value = '';
    isLoggedIn.value = false;

    Get.offAllNamed('/login', arguments: {'showLogoutSuccess': showSuccess});
  }
}
