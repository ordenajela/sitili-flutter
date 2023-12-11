import 'package:ecommerce_app/app/modules/admin/controllers/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeAdminView extends GetView<AdminController> {
  const HomeAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis datos',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => CustomCard(
                    text: 'Productos en SITILI:',
                    subText: controller.productsCount.value,
                    color: theme.primaryColor,
                    iconData: Icons.storefront,
                  )),
              SizedBox(height: 10.h), 
              Obx(() => CustomCard(
                    text: 'Ganancia de ventas:',
                    subText: '\$${controller.salesCount.value}',
                    color: Color.fromARGB(255, 65, 37, 110),
                    iconData: Icons.local_atm,
                  )),
              SizedBox(height: 10.h), 
              Obx(() => CustomCard(
                    text: 'Integrantes de SITILI:',
                    subText: controller.ratedProductsCount.value,
                    color: Color.fromARGB(255, 65, 37, 110),
                    iconData: Icons.sentiment_satisfied,
                  )),
              SizedBox(height: 10.h),
              Obx(() => CustomCard(
                    text: 'Total de envíos realizados:',
                    subText: controller.sentCount.value,
                    color: theme.primaryColor,
                    iconData: Icons.local_shipping,
                  )),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String text;
  final String subText;
  final Color color;
  final IconData iconData;

  const CustomCard({
    required this.text,
    required this.subText,
    required this.color,
    required this.iconData,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        color: color,
        child: Stack(
          children: [
            Positioned(
              top: 8,
              left: 8,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  iconData,
                  color: color,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 50.w,
                right: 8,
                left: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(color: Colors.white),
                  ),
                  Center(
                    child: Text(
                      subText,
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
