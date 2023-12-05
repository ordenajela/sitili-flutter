import 'package:ecommerce_app/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AdminController extends GetxController {
  // current screen index
  int currentIndex = 0;

  /// change the selected screen index
  changeScreen(int selectedIndex) {
    currentIndex = selectedIndex;
    update();
  }

}
