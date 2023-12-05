part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const BASE = _Paths.BASE;
   static const ADMIN_HOME = _Paths.ADMIN_HOME;
    static const SELLER_HOME = _Paths.SELLER_HOME;
  
  static const HOME = _Paths.HOME;
  static const FAVORITES = _Paths.FAVORITES;
  static const CART = _Paths.CART;
  static const NOTIFICATIONS = _Paths.NOTIFICATIONS;
  static const SETTINGS = _Paths.SETTINGS;
  static const PRODUCT_DETAILS = _Paths.PRODUCT_DETAILS;
  static const PRODUCT_DETAILS_FAVORITE = _Paths.PRODUCT_DETAILS_FAVORITE; // Nueva ruta
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const BASE = '/base';
  static const HOME = '/home';
  static const FAVORITES = '/favorites';
  static const CART = '/cart';
  static const NOTIFICATIONS = '/notifications';
  static const SETTINGS = '/settings';
  static const PRODUCT_DETAILS = '/product-details';
  static const PRODUCT_DETAILS_FAVORITE = '/product-details-favorite';
  static const ADMIN_HOME = '/admin-home';
  static const SELLER_HOME = '/seller-home';
}
