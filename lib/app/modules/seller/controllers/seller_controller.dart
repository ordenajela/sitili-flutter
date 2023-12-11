// SellerController.dart
import 'package:ecommerce_app/app/data/local/my_shared_pref.dart';
import 'package:ecommerce_app/app/data/models/user_model.dart';
import 'package:ecommerce_app/config/theme/my_theme.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SellerController extends GetxController {
  var isLightTheme = MySharedPref.getThemeIsLight();

  UserModel? userInfo;

  Future<UserModel> getUserInfo() async {
    userInfo = null;
    if (userInfo != null) {
      return userInfo!;
    }

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userToken = prefs.getString('userToken') ?? '';

      final response = await http.get(
        Uri.parse('http://3.219.197.64:8090/dataUser/listu'),
        headers: {'Authorization': 'Bearer $userToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        userInfo = UserModel.fromJson(data);
        print(response.body);
        return userInfo!;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print('Error fetching data: $e');

      throw Exception('Failed to fetch data');
    }
  }

  String getUserName() {
    return userInfo?.firstName ?? '';
  }

  String getUserLastName() {
    return userInfo?.lastName ?? '';
  }

  String getUserRole() {
    return userInfo?.roleId ?? '';
  }

  Future<void> fetchDataFromUrl() async {
    try {
      await getUserInfo();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  changeTheme(bool value) {
    MyTheme.changeTheme();
    isLightTheme = MySharedPref.getThemeIsLight();
    update(['Theme']);
  }

  int currentIndex = 0;

  // Nuevas variables para almacenar los resultados de las peticiones
  var productsCount = "0".obs;
  var salesCount = "0".obs;
  var ratedProductsCount = "0".obs;
  var sentCount = "0".obs;

  @override
  void onInit() {
    super.onInit();
    fetchSellerProducts();
    fetchSellerSales();
    fetchSellerRate();
    fetchSellerSent();
    fetchDataFromUrl();
    getUserInfo();
  }

  Future<void> fetchSellerProducts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('userToken');

    if (userToken == null || userToken.isEmpty) {
      print('User token not available');
      return;
    }

    final url = Uri.parse('http://3.219.197.64:8090/product/totSeller');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Productos en SITILI: $responseData');
        productsCount.value = responseData.toString();
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      print('Connection error: $error');
    }
  }

  Future<void> fetchSellerSales() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('userToken');

    if (userToken == null || userToken.isEmpty) {
      print('User token not available');
      return;
    }

    final url = Uri.parse('http://3.219.197.64:8090/order/sellerSales');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Ventas totales: $responseData');
        salesCount.value = responseData.toString();
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      print('Connection error: $error');
    }
  }

  Future<void> fetchSellerRate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('userToken');

    if (userToken == null || userToken.isEmpty) {
      print('User token not available');
      return;
    }

    final url = Uri.parse('http://3.219.197.64:8090/raiting/rateSeller');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Productos con 4★ o más: $responseData');
        ratedProductsCount.value = responseData.toString();
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      print('Connection error: $error');
    }
  }

  Future<void> fetchSellerSent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('userToken');

    if (userToken == null || userToken.isEmpty) {
      print('User token not available');
      return;
    }

    final url = Uri.parse('http://3.219.197.64:8090/order/sellerEnvs');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Envíos realizados: $responseData');
        sentCount.value = responseData.toString();
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      print('Connection error: $error');
    }
  }

  changeScreen(int selectedIndex) {
    currentIndex = selectedIndex;
    update();
  }
}
