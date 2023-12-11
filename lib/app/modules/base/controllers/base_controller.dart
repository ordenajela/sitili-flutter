import 'package:ecommerce_app/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BaseController extends GetxController {
  // current screen index
  int currentIndex = 0;

  /// change the selected screen index
  changeScreen(int selectedIndex) {
    currentIndex = selectedIndex;
    update();
  }

  /// Obtén el token del usuario desde SharedPreferences
  Future<String?> _getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userToken');
  }

  onFavoriteButtonPressed({required int productId}) async {
    try {
      final baseUrl = 'http://3.219.197.64:8090';
      final userToken = await _getUserToken();

      if (userToken == null) {
        print('Usuario no autenticado');
        return;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/favorite/create'),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'id': productId}),
      );

      if (response.statusCode == 200) {
        print('Product added to favorites successfully');
        Get.snackbar(
          'Éxito',
          'Producto agregado a favoritos correctamente',
          backgroundColor: Colors.green, // Fondo verde
          colorText: Colors.white, // Texto blanco
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (response.statusCode == 401) {
        print('Failed to add the product to favorites. Status code: 401');
      } else {
        print(
            'Failed to add the product to favorites. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      Get.find<FavoritesController>().getFavoriteProducts();
      update(['FavoriteButton']);
    } catch (e) {
      print('Error adding the product to favorites: $e');
    }
  }

  onFavoriteButtonPressedDelete({required int productId}) async {
    try {
      final baseUrl = 'http://3.219.197.64:8090';
      final userToken = await _getUserToken();

      if (userToken == null) {
        print('Usuario no autenticado');
        return;
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/favorite/delete'),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'id': productId}),
      );

      if (response.statusCode == 200) {
        print('Product removed from favorites successfully');
      } else if (response.statusCode == 401) {
        print('Failed to remove the product from favorites. Status code: 401');
      } else {
        print(
            'Failed to remove the product from favorites. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      Get.find<FavoritesController>().getFavoriteProducts();
      update(['FavoriteButton']);
    } catch (e) {
      print('Error removing the product from favorites: $e');
    }
  }
}
