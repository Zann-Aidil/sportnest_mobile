import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentMethod {
  final String id;
  final String name;
  final String icon;
  final String type; // e.g. e-wallet, bank

  PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'icon': icon,
    'type': type,
  };
}

class PaymentController extends GetxController {
  var savedMethods = <PaymentMethod>[].obs;
  var selectedMethodId = ''.obs;

  final List<PaymentMethod> availableMethods = [
    PaymentMethod(id: 'gopay', name: 'GoPay', icon: 'assets/images/logo.png', type: 'E-Wallet'),
    PaymentMethod(id: 'ovo', name: 'OVO', icon: 'assets/images/logo.png', type: 'E-Wallet'),
    PaymentMethod(id: 'dana', name: 'DANA', icon: 'assets/images/logo.png', type: 'E-Wallet'),
    PaymentMethod(id: 'bca', name: 'BCA Virtual Account', icon: 'assets/images/logo.png', type: 'Transfer Bank'),
    PaymentMethod(id: 'mandiri', name: 'Mandiri Virtual Account', icon: 'assets/images/logo.png', type: 'Transfer Bank'),
  ];

  @override
  void onInit() {
    super.onInit();
    loadPaymentMethods();
  }

  Future<void> loadPaymentMethods() async {
    final prefs = await SharedPreferences.getInstance();
    
    // For simplicity, we just load the selected one.
    // Real implementation might store a JSON list of added methods.
    selectedMethodId.value = prefs.getString('selectedPaymentMethod') ?? 'gopay';
    
    // Populate saved methods with defaults if empty
    bool hasSaved = prefs.getBool('hasSavedMethods') ?? false;
    if (!hasSaved) {
      savedMethods.addAll([
        availableMethods[0], // GoPay
        availableMethods[3], // BCA
      ]);
      await prefs.setBool('hasSavedMethods', true);
    } else {
      // Mocking loaded methods
      savedMethods.addAll([
        availableMethods[0],
        availableMethods[3],
      ]);
    }
  }

  Future<void> addMethod(PaymentMethod method) async {
    if (!savedMethods.any((m) => m.id == method.id)) {
      savedMethods.add(method);
    }
  }

  Future<void> removeMethod(String id) async {
    savedMethods.removeWhere((m) => m.id == id);
    if (selectedMethodId.value == id) {
      selectedMethodId.value = savedMethods.isNotEmpty ? savedMethods.first.id : '';
      await _saveSelected();
    }
  }

  Future<void> selectMethod(String id) async {
    selectedMethodId.value = id;
    await _saveSelected();
  }

  Future<void> _saveSelected() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedPaymentMethod', selectedMethodId.value);
  }

  PaymentMethod? get selectedMethod {
    try {
      return savedMethods.firstWhere((m) => m.id == selectedMethodId.value);
    } catch (e) {
      return savedMethods.isNotEmpty ? savedMethods.first : null;
    }
  }
}
