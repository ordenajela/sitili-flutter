import 'package:ecommerce_app/app/components/custom_button.dart';
import 'package:ecommerce_app/app/modules/product_details/controllers/product_details_controller.dart';
import 'package:ecommerce_app/app/modules/product_details/views/widgets/rounded_button.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';



class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({Key? key, String? productName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 450.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDF1FA),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.r),
                        bottomRight: Radius.circular(30.r),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30.h,
                    left: 20.w,
                    right: 20.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RoundedButton(
                          onPressed: () => Get.back(),
                          child: SvgPicture.asset(Constants.backArrowIcon,
                              fit: BoxFit.none),
                        ),
                        GetBuilder<ProductDetailsController>(
                          id: 'FavoriteButton',
                          builder: (_) => RoundedButton(
                            onPressed: () =>
                                controller.onFavoriteButtonPressed(),
                            child: Align(
                              child: SvgPicture.asset(
                                controller.product.isFavorite!
                                    ? Constants.favFilledIcon
                                    : Constants.favOutlinedIcon,
                                width: 16.w,
                                height: 15.h,
                                color: controller.product.isFavorite!
                                    ? null
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: controller.product.product_id == 2 ? 0 : 30.w,
                    bottom: -350.h,
                    child: Image.network(
                      controller.product.imagenes![0]!,
                      height: 700.h,
                    ).animate().slideX(
                          duration: const Duration(milliseconds: 300),
                          begin: 1,
                          curve: Curves.easeInSine,
                        ),
                  ),
                ],
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  controller.product.name!,
                  style: theme.textTheme.bodyLarge,
                ).animate().fade().slideX(
                      duration: const Duration(milliseconds: 300),
                      begin: -1,
                      curve: Curves.easeInSine,
                    ),
              ),
              10.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Text(
                      '\$${controller.product.price}',
                      style: theme.textTheme.displayMedium,
                    ),
                    30.horizontalSpace,
                    const Icon(Icons.star_rounded, color: Color(0xFFFFC542)),
                    5.horizontalSpace,
                    Text(
                      controller.product.rating!.toString(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    5.horizontalSpace,
                    // Text(
                    //   '(${controller.product.reviews!})',
                    //   style:
                    //       theme.textTheme.bodyMedium?.copyWith(fontSize: 16.sp),
                    // ),
                  ],
                ).animate().fade().slideX(
                      duration: const Duration(milliseconds: 300),
                      begin: -1,
                      curve: Curves.easeInSine,
                    ),
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Descripción:',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ).animate().fade().slideX(
                      duration: const Duration(milliseconds: 300),
                      begin: -1,
                      curve: Curves.easeInSine,
                    ),
              ),
              10.verticalSpace,
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(controller.product.reviews.toString())),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: CustomButton(
                  text: 'Añadir al carrito',
                  onPressed: () => controller.onAddToCartPressed(),
                  //disabled: controller.product.quantity! > 0,
                  fontSize: 16.sp,
                  radius: 12.r,
                  verticalPadding: 12.h,
                  hasShadow: true,
                  shadowColor: theme.primaryColor,
                  shadowOpacity: 0.3,
                  shadowBlurRadius: 4,
                  shadowSpreadRadius: 0,
                ).animate().fade().slideY(
                      duration: const Duration(milliseconds: 300),
                      begin: 1,
                      curve: Curves.easeInSine,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
