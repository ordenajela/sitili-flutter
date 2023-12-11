import 'package:ecommerce_app/app/modules/admin/controllers/admin_controller.dart';
import 'package:ecommerce_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:ecommerce_app/app/modules/settings/controllers/settings_controller.dart';
import 'package:get/get.dart';

class AdminHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminController>(() => AdminController());
     Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
