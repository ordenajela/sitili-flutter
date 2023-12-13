import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../data/models/product_favorites_model.dart';
import '../modules/base/controllers/base_controller.dart';

class ProductItemFavorites extends StatelessWidget {
  final FavItemModel product;
  const ProductItemFavorites({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    print('Image URL: ${product.images}');
    return GestureDetector(
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDF1FA),
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                ),
                Positioned(
                  right: product.favId == 2 ? 0 : 0.w,
                  bottom: -50.h,
                  child: Image.network(product.images![0], height: 260.h)
                      .animate()
                      .slideX(
                        duration: const Duration(milliseconds: 200),
                        begin: 1,
                        curve: Curves.easeInSine,
                      ),
                ),
                Positioned(
                  left: 15.w,
                  bottom: 20.h,
                  child: GetBuilder<BaseController>(
                    id: 'FavoriteButtonDelete',
                    builder: (controller) => GestureDetector(
                      onTap: () => controller.onFavoriteButtonPressedDelete(
                        productId: product.favId!,
                      ),
                      child: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(
                          Constants.favFilledIcon,
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ).animate().fade(),
              ],
            ),
            10.verticalSpace,
            Text(product.productName!, style: theme.textTheme.bodyMedium)
                .animate()
                .fade()
                .slideY(
                  duration: const Duration(milliseconds: 200),
                  begin: 1,
                  curve: Curves.easeInSine,
                ),
            5.verticalSpace,
            Text('\$${product.price}', style: theme.textTheme.displaySmall)
                .animate()
                .fade()
                .slideY(
                  duration: const Duration(milliseconds: 200),
                  begin: 2,
                  curve: Curves.easeInSine,
                ),
          ],
        ),
      ),
    );
  }
}
