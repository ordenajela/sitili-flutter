import 'package:ecommerce_app/app/data/models/product_cart_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
        responseData = json.decode(response.body);
      } else {}
    } catch (error) {
      print('Connection error: $error');
    }
  }

  Future<void> updateProductQuantityOnServer(
      int productId, int quantity) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userToken = prefs.getString('userToken');

      if (userToken == null || userToken.isEmpty) {
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
      } else {}
    } catch (e) {}
  }

  onIncreasePressed(int productId) {
    try {
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
      } else {}
    } catch (e) {}
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
      update();
      if (selectedQuantities[productId]!.value == 0) {
        onDeletePressed(productId);
      }
    }
  }

  onDeletePressed(int productId) async {
    try {
      await deleteProductOnServer(productId);

      int index = products.indexWhere((p) => p.carId == productId);
      if (index != -1) {
        double removedProductPrice =
            products[index].price * selectedQuantities[productId]!.value;
        products.removeAt(index);
        selectedQuantities.remove(productId);

        total.value -= removedProductPrice;

        update(['TotalPrice']);
        update();
      }
    } catch (e) {}
  }

  Future<void> deleteProductOnServer(int productId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userToken = prefs.getString('userToken');

      if (userToken == null) {
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
      } else {}
    } catch (e) {}
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
        throw Exception('Error al obtener los productos del carrito');
      }
    } catch (e) {
      throw Exception('Error al obtener los productos del carrito');
    }
  }
}
