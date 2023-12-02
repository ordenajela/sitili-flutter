import 'package:ecommerce_app/app/modules/login/views/login_screen.dart';
import 'package:ecommerce_app/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants.dart';
import '../../controllers/settings_controller.dart';

class SettingsItemLogOut extends StatelessWidget {
  final String title;
  final String icon;
  final bool isAccount;
  final bool isDark;

  const SettingsItemLogOut({
    Key? key,
    required this.title,
    required this.icon,
    this.isAccount = false,
    this.isDark = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ListTile(
      title: Text(
        title,
        style: theme.textTheme.displayMedium?.copyWith(
          fontSize: 16.sp,
        ),
      ),
      subtitle: !isAccount
          ? null
          : Text(
              'Usuario',
              style: theme.textTheme.displaySmall,
            ),
      leading: CircleAvatar(
        radius: isAccount ? 30.r : 25.r,
        backgroundColor: theme.primaryColor,
        child: SvgPicture.asset(icon, fit: BoxFit.none),
      ),
      trailing: isDark
          ? GetBuilder<SettingsController>(
              id: 'Theme',
              builder: (controller) => CupertinoSwitch(
                value: !controller.isLightTheme,
                onChanged: controller.changeTheme,
                activeColor: theme.primaryColor,
              ),
            )
          : InkWell(
              onTap: () {
                // Llamada a la función de cierre de sesión
                Get.find<SettingsController>().logout();
              },
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: SvgPicture.asset(Constants.forwardArrowIcon,
                    fit: BoxFit.none),
              ),
            ),
    );
  }
}
