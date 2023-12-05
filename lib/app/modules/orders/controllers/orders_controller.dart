import 'package:ecommerce_app/app/modules/orders/views/widgets/orders_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersController extends GetxController {
  List<Map<String, dynamic>> _ordersList = [];

  List<Map<String, dynamic>> get ordersList => _ordersList;

  @override
  void onInit() {
    super.onInit();
    // Llama al método fetchOrdersData al iniciar el controlador
    fetchOrdersData();
  }

  Future<void> fetchOrdersData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('userToken');

    if (userToken == null || userToken.isEmpty) {
      print('User token not available');
      return;
    }

    final url = Uri.parse('http://localhost:8090/order/listUser');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Verificar si la respuesta es una lista o un mapa
        dynamic responseData = json.decode(response.body);

        if (responseData is List) {
          // Si es una lista, puedes asignarla a la propiedad en tu controlador
          _ordersList = List<Map<String, dynamic>>.from(responseData);
          print('Datos recibidos (Lista): $_ordersList');

          // Notifica a los widgets que dependen de este controlador para que se reconstruyan
          update();
        } else {
          print('Tipo de respuesta no reconocido');
        }
      } else {
        // La petición falló con un código de estado diferente a 200
        print('Error en la petición. Código de estado: ${response.statusCode}');
      }
    } catch (error) {
      // Manejar errores de conexión
      print('Error de conexión: $error');
    }
  }

  Future<void> fetchOrderDetails(String orderId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userToken = prefs.getString('userToken');

    if (userToken == null || userToken.isEmpty) {
      print('User token not available');
      return;
    }

    final url = Uri.parse('http://localhost:8090/orderDetail/listDetails');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({'id': orderId}),
      );

      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Decode the response body
        List<Map<String, dynamic>> responseData =
            List<Map<String, dynamic>>.from(json.decode(response.body));

        // Navigate to OrderDetailsView with the decoded list of data
        Get.to(() => OrderDetailsView(orderDetailsList: responseData));
      } else {
        // Handle other status codes if needed
        print('Error in the request. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle connection errors
      print('Connection error: $error');
    }
  }
}
