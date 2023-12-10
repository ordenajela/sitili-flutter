import 'package:ecommerce_app/app/data/models/user_model.dart';

import 'package:ecommerce_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:ecommerce_app/app/modules/profile/views/update_profile.dart';
import 'package:ecommerce_app/app/modules/seller/views/home_seller_view.dart';
import 'package:ecommerce_app/app/modules/settings/controllers/settings_controller.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileSellerView extends StatelessWidget {
  final _profileController = Get.find<ProfileController>();

  ProfileSellerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mi perfil',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: GetBuilder<ProfileController>(
          builder: (_) => ListView(
            children: [
              30.verticalSpace,
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CircleAvatar(
                              backgroundColor: theme.primaryColor,
                              child: SvgPicture.asset(Constants.userIcon,
                                  fit: BoxFit.none),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // -- USER INFO
                    FutureBuilder<UserModel>(
                      future: _profileController.getUserInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final user = snapshot.data!;
                          return Column(
                            children: [
                              Text('${user.firstName} ${user.lastName}',
                                  style: Theme.of(context).textTheme.headline4),
                              Text('${_profileController.getUserRole()}',
                                  style: Theme.of(context).textTheme.bodyText2),
                            ],
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 30),
                    const Divider(),
                    const SizedBox(height: 10),

                    ProfileMenuWidget(
                      title: 'Cerrar sesión',
                      icon: Icons.logout,
                      onPress: () {
                        Get.find<SettingsController>().logout();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPress;
  final Color? textColor;
  final bool endIcon;

  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.textColor,
    this.endIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      leading: Icon(icon),
      onTap: () => onPress(),
    );
  }
}
