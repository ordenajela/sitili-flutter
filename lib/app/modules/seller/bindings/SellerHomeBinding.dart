import 'package:ecommerce_app/app/modules/seller/controllers/seller_controller.dart';

import 'package:get/get.dart';

class SellerHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SellerController>(() => SellerController());

  }
}
