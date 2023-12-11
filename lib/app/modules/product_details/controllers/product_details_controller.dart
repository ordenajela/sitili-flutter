import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../utils/dummy_helper.dart';
import '../../../data/models/product_model.dart';
import '../../base/controllers/base_controller.dart';
import '../../cart/controllers/cart_controller.dart';

class ProductDetailsController extends GetxController {
  ProductModel product = Get.arguments;

  onFavoriteButtonPressed() {
    Get.find<BaseController>().onFavoriteButtonPressed(productId: product.product_id!);
    update(['FavoriteButton']);
  }

  onAddToCartPressed() async {
    try {
      final baseUrl = 'http://3.219.197.64:8090';

      // Get the user token from shared preferences
      final userToken = await _getUserToken();

      final response = await http.post(
        Uri.parse('$baseUrl/shoppingCar/createF'),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'id': product.product_id, 'stock': 1}),
      );

      if (response.statusCode == 200) {
        print('Product added to the shopping cart successfully');
      } else if (response.statusCode == 401) {
        print(
            'Failed to add the product to the shopping cart. Status code: 401');
      } else {
        print(
            'Failed to add the product to the shopping cart. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error adding the product to the shopping cart: $e');
    }

    Get.find<CartController>().getCartProducts();
    Get.back();
  }

  Future<String> _getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userToken') ?? '';
  }
}
