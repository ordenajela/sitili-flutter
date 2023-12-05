import 'package:ecommerce_app/app/modules/admin/controllers/admin_controller.dart';
import 'package:get/get.dart';

class AdminHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminController>(() => AdminController());
  }
}
