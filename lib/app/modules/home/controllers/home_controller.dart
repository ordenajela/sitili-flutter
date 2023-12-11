
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/models/product_model.dart';

class HomeController extends GetxController {
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  late String userToken;
  int? selectedCategoryId;
  var isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await obtenerProductos();
    await obtenerCategorias();
    isLoading.value = false;
  }

  Future<void> obtenerCategorias() async {
    try {
      final response = await http.get(
        Uri.parse('http://3.219.197.64:8090/categories/listAll'),
        headers: {'Authorization': 'Bearer $userToken'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        categories.assignAll(data.map((json) => CategoryModel.fromJson(json)));
        
      } else {
       
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      
    }
  }

  Future<void> obtenerProductos() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      userToken = prefs.getString('userToken') ?? '';

      final response = await http.get(
        Uri.parse('http://3.219.197.64:8090/product/listAll'),
        headers: {'Authorization': 'Bearer $userToken'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        products.assignAll(data.map((json) => ProductModel.fromJson(json)));
      } else {
        
        throw Exception('Failed to load products');
      }
    } catch (e) {
      
    }
  }

  Future<void> obtenerProductosSegunCategoria(int? categoryId) async {
    try {
     
      selectedCategoryId = categoryId;

      if (categoryId != null) {
       
        final response = await http.post(
          Uri.parse('http://3.219.197.64:8090/categories/proxcat'),
          headers: {
            'Authorization': 'Bearer $userToken',
            'Content-Type': 'application/json',
          },
          body: json.encode({'id': categoryId}),
        );

        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          products.assignAll(data.map((json) => ProductModel.fromJson(json)));
        } else {
          print('No se pudo cargar productos por categoría');
          throw Exception('Failed to load products by category');
        }
      } else {
        
        await obtenerProductos();
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }
}

class CategoryModel {
  final int id;
  final String name;
  final bool status;

  CategoryModel({required this.id, required this.name, required this.status});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }
}
