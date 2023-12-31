import 'package:ecommerce_app/app/modules/settings/views/widgets/setting_item_logout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../components/screen_title.dart';
import '../controllers/settings_controller.dart';
import 'widgets/settings_item.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configuración',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            30.verticalSpace,
            const ScreenTitle(
              title: 'Configuración',
              dividerEndIndent: 230,
            ),
            20.verticalSpace,
            Text('Cuenta',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.normal,
                )),
            20.verticalSpace,
            const SettingsItem(
              title: 'Mi perfil',
              icon: Constants.userIcon,
              isAccount: true,
            ),
            30.verticalSpace,
            Text('Configuraciones',
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.normal,
                )),
            20.verticalSpace,
            const SettingsItem(
              title: 'Modo oscuro',
              icon: Constants.themeIcon,
              isDark: true,
            ),
            25.verticalSpace,
            const SettingsItemLogOut(
              title: 'Cerrar sesión',
              icon: Constants.logoutIcon,
            ),
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
