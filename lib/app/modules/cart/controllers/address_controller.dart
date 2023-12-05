

import 'dart:convert';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddressController extends GetxController {
  int addressId = 0;

  Future<void> createAddress({
    required String country,
    required String state,
    required String city,
    required String postalCode,
    required String mainAddress,
    String? streetAddress1,
    String? streetAddress2,
    required String description,
  }) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userToken = prefs.getString('userToken');

      if (userToken == null || userToken.isEmpty) {
        print('User token not available');
        return;
      }

      // Construye el cuerpo de la solicitud en formato JSON
      final Map<String, dynamic> requestBody = {
        "country": country,
        "state": state,
        "city": city,
        "postalCode": postalCode,
        "mainAddress": mainAddress,
        "streetAddress1": streetAddress1,
        "streetAddress2": streetAddress2,
        "description": description,
      };

      // Convierte el mapa a una cadena JSON
      final String requestBodyJson = json.encode(requestBody);

      // Realiza la solicitud HTTP POST a la URL de creación de dirección
      final response = await http.post(
        Uri.parse('http://localhost:8090/address/create'),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
        body: requestBodyJson,
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('Datos que se mandan: ${requestBodyJson}');

      if (response.statusCode == 200) {
        // Procesa la respuesta según tus necesidades
        print('Dirección creada exitosamente');
        // Obtén el ID de la dirección creada (puedes extraerlo de la respuesta)
        addressId = 1; // Reemplaza esto con el valor real del ID

        // Después de crear la dirección con éxito, obtén la lista de direcciones del usuario
        await fetchAndPrintUserAddresses();
      } else {
        throw Exception('Failed to create address');
      }
    } catch (e) {
      print('Error creating address: $e');
      // Puedes manejar el error según tus necesidades
      throw Exception('Failed to create address');
    }
  }

  Future<void> fetchAndPrintUserAddresses() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? userToken = prefs.getString('userToken');

      if (userToken == null || userToken.isEmpty) {
        print('User token not available');
        return;
      }
      

     
      final response = await http.get(
        Uri.parse('http://localhost:8090/address/list'),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      final Map<String, dynamic> responseBody = json.decode(response.body);
      final int addressId = responseBody['id'];

      print('ID de la dirección: $addressId');
      await prefs.setInt('addressId', addressId);
    } catch (e) {
      print('Error fetching user addresses: $e');
      // Puedes manejar el error según tus necesidades
      throw Exception('Failed to fetch user addresses');
    }
  }
}
