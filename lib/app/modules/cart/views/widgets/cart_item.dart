import 'package:ecommerce_app/app/data/models/product_cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants.dart';

import '../../controllers/cart_controller.dart';

class CartItem extends GetView<CartController> {
  final CartItemModel product; // Cambia ProductModel a CartItemModel

  const CartItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25.r),
            child: Stack(
              children: [
                Container(
                  width: 105.w,
                  height: 125.h,
                  color: const Color(0xFFEDF1FA),
                ),
                Positioned(
                  left: 15.w,
                  bottom: -150.h,
                  child: Image.network(
                    product.images![0]!, // Usa las imágenes del nuevo modelo
                    height: 250.h,
                  ),
                ),
              ],
            ),
          ),
          20.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              5.verticalSpace,
              Text(
                product.productName, 
                style: theme.textTheme.displayMedium,
                overflow: TextOverflow.ellipsis,
              ),
              5.verticalSpace,
              Text(
                '${product.category}',
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 16.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              5.verticalSpace,
              Text(
                '\$${product.price}',
                style: theme.textTheme.displayLarge?.copyWith(
                  fontSize: 18.sp,
                ),
              ),
              10.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => controller.onIncreasePressed(product.carId),
                    child: SvgPicture.asset(Constants.decreaseIcon),
                  ),
                  10.horizontalSpace,
                  Obx(() => Text(
                        '${controller.selectedQuantities[product.carId]?.value ?? 0}',
                        style: theme.textTheme.displaySmall,
                      )),
                  10.horizontalSpace,
                  GestureDetector(
                    onTap: () => controller.onDecreasePressed(product.carId),
                    child: SvgPicture.asset(Constants.increaseIcon),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () => controller.onDeletePressed(product.carId),
            customBorder: const CircleBorder(),
            child: Container(
              padding: EdgeInsets.all(10.r),
              child: SvgPicture.asset(
                Constants.cancelIcon,
                width: 20.w,
                height: 20.h,
                color: theme.textTheme.bodyMedium!.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
