// profile_controller.dart

import 'dart:convert';

import 'package:ecommerce_app/app/data/local/my_shared_pref.dart';
import 'package:ecommerce_app/app/data/models/user_model.dart';
import 'package:ecommerce_app/config/theme/my_theme.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var isLightTheme = MySharedPref.getThemeIsLight();

  @override
  void onInit() {
    super.onInit();
    fetchDataFromUrl();
 
  }

 

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
        Uri.parse('http://localhost:8090/dataUser/listu'),
        headers: {'Authorization': 'Bearer $userToken'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        userInfo = UserModel.fromJson(data);
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

  // Nuevo método para realizar la solicitud PUT con los datos del formulario
  Future<void> updateUserData({
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    try {
      // Construye el cuerpo de la solicitud en formato JSON
      final Map<String, dynamic> requestBody = {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
      };

      // Convierte el mapa a una cadena JSON
      final String requestBodyJson = json.encode(requestBody);

      // Realiza la solicitud HTTP PUT a la URL de actualización
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final userToken = prefs.getString('userToken') ?? '';

      final response = await http.put(
        Uri.parse('http://localhost:8090/dataUser/update'),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
        },
        body: requestBodyJson,
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      print('datos que se mandan: ${requestBodyJson}');

      if (response.statusCode == 200) {
        try {
          // Intenta decodificar la respuesta como un JSON válido
          final dynamic decodedResponse = json.decode(response.body);

          if (decodedResponse is Map<String, dynamic>) {
            // Actualiza la información del usuario con los nuevos datos del JSON
            userInfo = UserModel.fromJson(decodedResponse);

            // Imprime la información actualizada del usuario
            print('User data updated successfully:');
            print('User ID: ${userInfo?.userId}');
            print('First Name: ${userInfo?.firstName}');
            print('Last Name: ${userInfo?.lastName}');
            print('Phone: ${userInfo?.phone}');
            print('Role ID: ${userInfo?.roleId}');
            print('Status: ${userInfo?.status}');
            print('Register Date: ${userInfo?.registerDate}');
          } else {
            // No es un JSON válido
            print('User data updated successfully (non-JSON response)');
          }
        } catch (e) {
          // La respuesta no es un JSON válido, manejar como caso especial
          print('User data updated successfully (no changes in user data)');
        }
      } else {
        throw Exception('Failed to update user data');
      }
    } catch (e) {
      print('Error updating user data: $e');
    }
  }
}
