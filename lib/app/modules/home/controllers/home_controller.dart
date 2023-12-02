// controllers/home_controller.dart
import 'package:connectivity/connectivity.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/product_model.dart';

class HomeController extends GetxController {
  RxList<ProductModel> products = <ProductModel>[].obs;
  late String userToken; // Add a variable to store the user token

  @override
  void onInit() {
    obtenerProductos();
    super.onInit();
  }

  Future<void> obtenerProductos() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      userToken = prefs.getString('userToken') ?? '';

      final response = await http.get(
        Uri.parse('http://localhost:8090/product/listAll'),
        headers: {'Authorization': 'Bearer $userToken'},
      );
      // print(checkConnectivity());
      // print('Response status code: ${response.statusCode}');
      // print('Response body home: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        products.assignAll(data.map((json) => ProductModel.fromJson(json)));
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }
}

Future<void> checkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {
    print('Conexión a Internet activa');
  } else {
    print('No hay conexión a Internet');
  }
}
