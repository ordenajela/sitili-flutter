import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../utils/constants.dart';
import '../../../components/custom_button.dart';
import '../controllers/product_details_controller.dart';
import 'widgets/rounded_button.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({Key? key, String? productName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Producto',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.primaryColor,
        actions: [
          GetBuilder<ProductDetailsController>(
            id: 'FavoriteButton',
            builder: (_) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundedButton(
                onPressed: () => controller.onFavoriteButtonPressed(),
                child: Align(
                  child: SvgPicture.asset(
                    controller.product.isFavorite!
                        ? Constants.favFilledIcon
                        : Constants.favOutlinedIcon,
                    width: 16.w,
                    height: 15.h,
                    color: controller.product.isFavorite! ? null : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Positioned(
                right: controller.product.product_id == 2 ? 0 : 0.w,
                bottom: -350.h,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 400.w, // Ancho y altura iguales para hacerlo cuadrado
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      controller.product.imagenes![0]!,
                      fit: BoxFit
                          .cover, // Ajuste para expandir o adaptar al tamaño del contenedor
                    ),
                  ),
                ).animate().slideX(
                      duration: const Duration(milliseconds: 300),
                      begin: 1,
                      curve: Curves.easeInSine,
                    ),
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
