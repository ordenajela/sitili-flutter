
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../components/product_item.dart';
import '../../../components/screen_title.dart';
import '../../../components/custom_carousel.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: FutureBuilder<void>(
     
          future: controller.obtenerProductos(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView(
                children: [
                  30.verticalSpace,
                  const ScreenTitle(
                    title: 'Inicio',
                  ),
                  20.verticalSpace,
                  CustomCarousel(
                    itemList: controller.products.map((product) {
                      return GestureDetector(
                        onTap: () => Get.toNamed(
                          Routes.PRODUCT_DETAILS,
                          arguments: product,
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 120.h,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    product.imagenes![0] ?? '',
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                product.name ?? 'No Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  30.verticalSpace,
                  const ScreenTitle(
                    title: 'Productos',
                  ),
                  20.verticalSpace,
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.w,
                      mainAxisSpacing: 15.h,
                      mainAxisExtent: 260.h,
                    ),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) => ProductItem(
                      product: controller.products[index],
                    ),
                  ),
                  10.verticalSpace,
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
