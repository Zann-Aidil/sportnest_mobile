import 'package:get/get.dart';
import '../controllers/user_controller.dart';
import '../controllers/booking_controller.dart';
import '../controllers/payment_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController(), permanent: true);
    Get.put(BookingController(), permanent: true);
    Get.put(PaymentController(), permanent: true);
  }
}
