import 'package:ecommerce_app/app/data/models/product_favorites_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class FavoritesController extends GetxController {
  // Lista para contener los productos favoritos
  List<FavItemModel> products = [];

  @override
  void onInit() {
    getFavoriteProducts();
    super.onInit();
  }

  /// Obtener los productos favoritos desde la URL
  Future<void> getFavoriteProducts() async {
    try {
      print('ya entró');
      final baseUrl = 'http://3.219.197.64:8090';

      // Obtén el token del usuario desde SharedPreferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userToken = prefs.getString('userToken');

      if (userToken == null) {
        print('Usuario no autenticado');
        return;
      }

      // Realiza la solicitud HTTP con el token del usuario
      final response = await http.get(
        Uri.parse('$baseUrl/favorite/list'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        // Parsea la respuesta JSON
        final List<dynamic> favoriteItems = json.decode(response.body);

        // Mapea la lista de elementos favoritos
        products = favoriteItems.map((item) {
          return FavItemModel.fromJson(item);
        }).toList();
        //print(favoriteItems);
        // Actualiza la vista
        update();
      } else {
        print(
            'Error al obtener los productos favoritos. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al obtener los productos favoritos: $e');
    }
  }
}
