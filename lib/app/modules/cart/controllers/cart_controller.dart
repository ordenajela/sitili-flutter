// cart_controller.dart

import 'package:ecommerce_app/app/data/models/product_cart_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../components/custom_snackbar.dart';
import '../../base/controllers/base_controller.dart';

class CartController extends GetxController {
  List<CartItemModel> products = [];
  var total = 0.0.obs;
  RxBool loading = true.obs;
  Map<int, RxInt> selectedQuantities = {};
  Map<int, RxDouble> selectedPrices = {};
  static const int defaultQuantity = 1;
  dynamic responseData;
  @override
  void onInit() async {
    await fetchDataUserList();

    if (_isUserIdEqualToThree()) {
      await getCartProducts();
    }

    super.onInit();
  }

  bool _isUserIdEqualToThree() {
    return responseData != null && responseData['id'] == 3;
  }

  Future<void> fetchDataUserList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('userToken');

    if (userToken == null || userToken.isEmpty) {
      print('User token not available');
      return;
    }

    final url = Uri.parse('http://3.219.197.64:8090/dataUser/listu');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Handle the response data here
        responseData = json.decode(response.body);
      } else {}
    } catch (error) {
      // Handle connection errors
      print('Connection error: $error');
    }
  }

  Future<void> updateProductQuantityOnServer(
      int productId, int quantity) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userToken = prefs.getString('userToken');

      if (userToken == null || userToken.isEmpty) {
        print('User token not available');
        return;
      }

      final response = await http.put(
        Uri.parse('http://3.219.197.64:8090/shoppingCar/update'),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'id': productId,
          'quantity': quantity,
        }),
      );

      if (response.statusCode == 200) {
        print('Cantidad actualizada en el servidor');
      } else {
        print(
            'Error al actualizar la cantidad en el servidor. Código de estado: ${response.statusCode}');
        print('Detalles de la respuesta: ${response.body}');
      }
    } catch (e) {
      print('Error en updateProductQuantityOnServer: $e');
    }
  }

  onIncreasePressed(int productId) {
    try {
      print('Tratando de aumentar la cantidad del producto con ID: $productId');
      int index = products.indexWhere((p) => p.carId == productId);

      if (index != -1) {
        var product = products[index];
        selectedQuantities[productId] ??= RxInt(defaultQuantity);
        selectedQuantities[productId]!.value++;
        selectedPrices[productId] =
            RxDouble(product.price * selectedQuantities[productId]!.value);

        updateProductQuantityOnServer(
            productId, selectedQuantities[productId]!.value);
        updateTotalPrice();
        update();

        print(
            'Aumentada la cantidad del producto con ID $productId. cantidad actual: ${selectedQuantities[productId]}, precio actual: ${selectedPrices[productId]}');
      } else {
        print('Producto con ID $productId no encontrado en la lista');
      }
    } catch (e) {
      print('Error en onIncreasePressed: $e');
    }
  }

  onDecreasePressed(int productId) {
    int index = products.indexWhere((p) => p.carId == productId);
    if (index != -1 && (selectedQuantities[productId]?.value ?? 0) > 0) {
      selectedQuantities[productId]!.value--;
      selectedPrices[productId] = RxDouble(
          products[index].price * selectedQuantities[productId]!.value);

      updateProductQuantityOnServer(
          productId, selectedQuantities[productId]!.value);
      updateTotalPrice();
      update(); // Actualiza todas las partes de la vista

      // Verifica si la cantidad ha llegado a cero y elimina el producto del carrito
      if (selectedQuantities[productId]!.value == 0) {
        onDeletePressed(productId);
      }
    }
  }

  onDeletePressed(int productId) async {
    try {
      // Elimina el producto del servidor
      await deleteProductOnServer(productId);

      // Elimina el producto localmente
      int index = products.indexWhere((p) => p.carId == productId);
      if (index != -1) {
        double removedProductPrice =
            products[index].price * selectedQuantities[productId]!.value;
        products.removeAt(index);
        selectedQuantities.remove(productId);

        // Actualiza el precio total restando el precio del producto eliminado
        total.value -= removedProductPrice;

        // Actualiza la vista
        update(['TotalPrice']);
        update();
      }
    } catch (e) {
      print('Error en onDeletePressed: $e');
    }
  }

  Future<void> deleteProductOnServer(int productId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userToken = prefs.getString('userToken');

      if (userToken == null) {
        print('Usuario no autenticado');

        return;
      }

      final baseUrl = 'http://3.219.197.64:8090';
      final response = await http.delete(
        Uri.parse('$baseUrl/shoppingCar/delete'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
        body: jsonEncode({'id': productId}),
      );

      if (response.statusCode == 200) {
        print('Producto eliminado con éxito');
      } else {
        print(
            'Error al eliminar el producto. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en deleteProductOnServer: $e');
    }
  }

  void updateTotalPrice() {
    total.value = products.fold<double>(
        0, (p, c) => p + c.price * selectedQuantities[c.carId]!.value);
    update(['TotalPrice']);
  }

  Future<void> getCartProducts() async {
    try {
      loading.value = true;

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userToken = prefs.getString('userToken');

      if (userToken == null) {
        print('Usuario no autenticado');
        return;
      }

      final baseUrl = 'http://3.219.197.64:8090';

      final response = await http.get(
        Uri.parse('$baseUrl/shoppingCar/list'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> cartItems = json.decode(response.body);

        products = cartItems.map((item) {
          return CartItemModel.fromJson(item);
        }).toList();

        for (var product in products) {
          selectedQuantities[product.carId] = RxInt(defaultQuantity);
          selectedPrices[product.carId] = RxDouble(product.price);
        }

        total.value = products.fold<double>(
            0, (p, c) => p + c.price * selectedQuantities[c.carId]!.value);

        loading.value = false;
        update();
      } else {
        print(
            'Error al obtener los productos del carrito. Código de estado: ${response.statusCode}');
        throw Exception('Error al obtener los productos del carrito');
      }
    } catch (e) {
      print('Error al obtener los productos del carrito: $e');
      throw Exception('Error al obtener los productos del carrito');
    }
  }
}
