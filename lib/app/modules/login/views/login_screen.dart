import 'dart:convert';
import 'package:ecommerce_app/app/components/custom_button.dart';
import 'package:ecommerce_app/app/modules/login/views/register_screen.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<Map<String, dynamic>> signIn(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://3.219.197.64:8090/authenticate'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Error en la solicitud de inicio de sesión: ${response.body}');
      }
    } catch (error) {
      throw Exception('Error en la solicitud de inicio de sesión: $error');
    }
  }
}

void _redirectToRoleScreen(String roleName) {
  switch (roleName) {
    case 'User':
      Get.offNamed(Routes.BASE);
      break;
    case 'Admin':
      Get.offNamed(Routes.ADMIN_HOME);
      break;
    case 'Seller':
      Get.offNamed(Routes.SELLER_HOME);
      break;
    default:
     
      break;
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        final Map<String, dynamic> responseData = await AuthService.signIn(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        final String token = responseData['jwtToken'];
        final String roleName = responseData['user']['role'][0]['roleName'];

       
        await _saveUserCredentials(token, emailController.text.trim());

        _redirectToRoleScreen(roleName);
      } catch (error) {
       
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
                  width: 120.w,
                  height: 90.h,
                ),
                const Text(
                  'Iniciar sesión',
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
                      TextFormField(
                        controller: emailController,
                        // validator: (value) => EmailValidator.validate(value!)
                        //     ? null
                        //     : "Ingrese un email válido",
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
                            return 'Este campo es oblogatorio';
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
                        text: 'Ingresar',
                        onPressed: () {
                          _signIn();
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('¿Aún no tienes una cuenta?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(
                                    title: 'Register UI',
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Crear una cuenta',
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
    );
  }
}
