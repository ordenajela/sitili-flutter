import 'package:ecommerce_app/app/data/local/my_shared_pref.dart';
import 'package:ecommerce_app/app/modules/favorites/controllers/favorites_controller.dart';
import 'package:ecommerce_app/app/modules/login/views/login_screen.dart';
import 'package:ecommerce_app/config/theme/my_theme.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SellerController extends GetxController {
  // current screen index
  int currentIndex = 0;

  /// change the selected screen index
  changeScreen(int selectedIndex) {
    currentIndex = selectedIndex;
    update();
  }


}
