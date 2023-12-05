
import 'package:ecommerce_app/app/modules/admin/controllers/admin_controller.dart';
import 'package:ecommerce_app/app/modules/seller/controllers/seller_controller.dart';
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/product_item.dart';
import '../../../components/screen_title.dart';
import '../../../components/custom_carousel.dart';


class HomeSellerView extends GetView<SellerController> {
  const HomeSellerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Text("Home seller")),
    );
  }
}
