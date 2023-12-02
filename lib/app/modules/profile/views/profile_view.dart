import 'package:ecommerce_app/app/components/screen_title.dart';
import 'package:ecommerce_app/app/data/models/user_model.dart';
import 'package:ecommerce_app/app/modules/product_details/views/widgets/rounded_button.dart';
import 'package:ecommerce_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:ecommerce_app/app/modules/profile/views/update_profile.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final _profileController = Get.find<ProfileController>();

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: GetBuilder<ProfileController>(
          builder: (_) => ListView(
            children: [
              30.verticalSpace,
              Row(
                children: [
                  const ScreenTitle(
                    title: 'Perfil',
                  ),
                  Spacer(),
                  RoundedButton(
                    onPressed: () => Get.back(),
                    child: SvgPicture.asset(Constants.backArrowIcon,
                        fit: BoxFit.none),
                  ),
                ],
              ),
              20.verticalSpace,
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // -- IMAGE
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

                    const SizedBox(height: 20),

                    // -- BUTTON
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () =>
                            Get.to(() => const UpdateProfileScreen()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text('Editar Perfil',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(),
                    const SizedBox(height: 10),

                    // -- MENU
                    ProfileMenuWidget(
                        title: 'Mis compras',
                        icon: Icons.account_balance_wallet,
                        onPress: () {}),
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
      trailing: endIcon ? Icon(Icons.arrow_forward_ios) : null,
      onTap: () => onPress(),
    );
  }
}
