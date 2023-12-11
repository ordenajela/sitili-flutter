import 'dart:convert';

import 'package:ecommerce_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PaymentController extends GetxController {
  Future<void> makePayment({
    required String cardNumber,
    required String expiryDate,
    required String cvvCode,
  }) async {
    try {
      // Obtén el token de usuario desde Shared Preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userToken = prefs.getString('userToken');

      if (userToken == null || userToken.isEmpty) {
        // Manejar el caso en que el token de usuario no está presente
        print('User token not available');
        return;
      }

      // Construye el cuerpo de la solicitud en formato JSON
      final Map<String, dynamic> requestBody = {
        'cc': cardNumber,
        'expiryDate': expiryDate,
        'cvv': cvvCode,
      };

      // Convierte el mapa a una cadena JSON
      final String requestBodyJson = json.encode(requestBody);

      // Realiza la solicitud HTTP POST a la URL de pago
      final response = await http.post(
        Uri.parse('http://3.219.197.64:8090/paymentcc/create'),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
        body: requestBodyJson,
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('DATOS: ${requestBody}');

      if (response.statusCode == 200) {
        // Procesa la respuesta según tus necesidades
        print('Pago exitoso');

        // Parsea el cuerpo de la respuesta para obtener el ID de la tarjeta
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final int cardId = responseBody['id'];

        // Imprime los detalles de la tarjeta, incluyendo el ID
        print('Detalles de la tarjeta:');
        print('ID de la tarjeta: $cardId');
        print('Número de tarjeta: $cardNumber');
        print('Fecha de caducidad: $expiryDate');
        print('Código CVV: $cvvCode');
        await prefs.setInt('ccId', cardId);
        // Puedes realizar acciones adicionales aquí si es necesario
      } else {
        // Maneja el caso en que la solicitud no fue exitosa
        print('Error en la solicitud de pago');
        // Puedes mostrar mensajes de error o realizar otras acciones según tus necesidades
      }
    } catch (e) {
      print('Error en la solicitud de pago: $e');
      // Puedes manejar el error según tus necesidades
    }
  }

  Future<void> makeOrderSaleCar() async {
    try {
      // Obtén el token de usuario desde Shared Preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userToken = prefs.getString('userToken');

      if (userToken == null || userToken.isEmpty) {
        // Manejar el caso en que el token de usuario no está presente
        print('User token not available');
        return;
      }

      // Obtén el ID de la tarjeta almacenado en SharedPreferences
      final int? cardId = prefs.getInt('ccId');
      if (cardId == null) {
        // Manejar el caso en que el ID de la tarjeta no está presente
        print('Card ID not available');
        return;
      }

      // Obtén el ID de la dirección almacenado en SharedPreferences
      final int? addressId = prefs.getInt('addressId');
      if (addressId == null) {
        // Manejar el caso en que el ID de la dirección no está presente
        print('Address ID not available');
        return;
      }

      // Construye el cuerpo de la solicitud en formato JSON
      final Map<String, dynamic> requestBody = {
        'cc_id': cardId,
        'address_id': addressId,
      };

      // Convierte el mapa a una cadena JSON
      final String requestBodyJson = json.encode(requestBody);

      // Realiza la solicitud HTTP POST a la URL de order/saleCar
      final response = await http.post(
        Uri.parse('http://3.219.197.64:8090/order/saleCar'),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
        body: requestBodyJson,
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('DATOS: ${requestBody}');

      if (response.statusCode == 200) {
        // Procesa la respuesta según tus necesidades
        print('Pedido realizado exitosamente');
        final CartController cartController = Get.find();
        cartController.getCartProducts();
        // Puedes realizar acciones adicionales aquí si es necesario
      } else {
        // Maneja el caso en que la solicitud no fue exitosa
        print('Error en la solicitud de pedido');
        // Puedes mostrar mensajes de error o realizar otras acciones según tus necesidades
      }
    } catch (e) {
      print('Error en la solicitud de pedido: $e');
      // Puedes manejar el error según tus necesidades
    }
  }
}
