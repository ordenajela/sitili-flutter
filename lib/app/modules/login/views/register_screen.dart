import 'dart:convert';
import 'package:ecommerce_app/app/components/custom_button.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:ecommerce_app/app/modules/login/views/login_screen.dart';
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://3.219.197.64:8090/registerNewUser'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
          'role': 4,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error en la solicitud de registro: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error en la solicitud de registro: $error');
    }
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      try {
        final Map<String, dynamic> responseData = await AuthService.signUp(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
        );

        final String token = responseData['jwtToken'];

        print('Registro exitoso');
        print('El token: $token');

        await _saveUserCredentials(token, emailController.text.trim());

        Get.offNamed(Routes.BASE);
      } catch (error) {
        print('Error en el registro: ${error.toString()}');
      }
    }
  }

  Future<void> _saveUserCredentials(String token, String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userToken', token);
    prefs.setString('userEmail', email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 65, 37, 110),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    Constants.logo1,
                    width: 120,
                    height: 90,
                  ),
                  const Text(
                    'Registro',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color.fromARGB(255, 65, 37, 110),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: firstNameController,
                                validator: (value) => value!.isEmpty
                                    ? "Este campo es obligatorio"
                                    : null,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: 'Nombre',
                                  prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: lastNameController,
                                validator: (value) => value!.isEmpty
                                    ? "Este campo es obligatorio"
                                    : null,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  hintText: 'Apellido',
                                  prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          validator: (value) => EmailValidator.validate(value!)
                              ? null
                              : "Ingrese un email válido",
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                          maxLines: 1,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            hintText: 'Contraseña',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          text: 'Registrarse',
                          onPressed: () {
                            _signUp();
                          },
                          fontSize: 16.sp,
                          radius: 12.r,
                          verticalPadding: 12.h,
                          hasShadow: true,
                          shadowColor: Color.fromARGB(255, 82, 45, 142),
                          shadowOpacity: 0.3,
                          shadowBlurRadius: 4,
                          shadowSpreadRadius: 0,
                          backgroundColor: Color.fromARGB(255, 65, 37, 110),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('¿Ya tienes una cuenta?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const LoginPage(title: 'Login UI'),
                                  ),
                                );
                              },
                              child: const Text(
                                'Ingresar',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 65, 37, 110),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
