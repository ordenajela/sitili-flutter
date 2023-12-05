import 'package:ecommerce_app/app/modules/admin/controllers/admin_controller.dart';
import 'package:ecommerce_app/app/modules/seller/controllers/seller_controller.dart';
import 'package:ecommerce_app/app/modules/seller/views/home_seller_view.dart';
import 'package:ecommerce_app/app/modules/seller/views/profile_seller_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../utils/constants.dart';


class SellerHomeView extends GetView<SellerController> {
  const SellerHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = context.theme;
    return GetBuilder<SellerController>(
      builder: (_) => Scaffold(
        extendBody: true,
        body: SafeArea(
          bottom: false,
          child: IndexedStack(
            index: controller.currentIndex,
            children:  [
            HomeSellerView(),
            ProfileSellerView()
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                spreadRadius: 0,
                blurRadius: 10,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
            child: BottomNavigationBar(
              currentIndex: controller.currentIndex,
              type: BottomNavigationBarType.fixed,
              elevation: 0.0,
              backgroundColor: theme.scaffoldBackgroundColor,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedFontSize: 0.0,
              items: [
                _mBottomNavItem(
                  label: 'Home',
                  icon: Constants.homeIcon,
                ),
                _mBottomNavItem(
                  label: 'Perfil',
                  icon: Constants.settingsIcon,
                ),
              ],
              onTap: controller.changeScreen,
            ),
          ),
        ),
      ),
    );
  }

  _mBottomNavItem({required String label, required String icon}) {
    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(icon, color: Get.theme.iconTheme.color),
      activeIcon: SvgPicture.asset(icon, color: Get.theme.primaryColor),
    );
  }
}
