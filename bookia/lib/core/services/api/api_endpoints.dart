class ApiEndpoints {
  static const String baseUrl = 'https://codingarabic.online/api';

  static const String register = '/register';
  static const String login = '/login';
  static const String logout = '/logout';

  // home
  static const String productsBestSeller = '/products-bestseller';
  static const String sliders = '/sliders';

  // wishlist
  static const String wishlist = '/wishlist';
  static const String removeFromWishlist = '/remove-from-wishlist';
  static const String addToWishlist = '/add-to-wishlist';

  // cart
  static const String cart = '/cart';
  static const String removeFromCart = '/remove-from-cart';
  static const String addToCart = '/add-to-cart';
  static const String updateCart = '/update-cart';

  // order
  static const String checkout = '/checkout';
  static const String placeOrder = '/place-order';

  // profile
  static const String profile = '/profile';
  static const String updateProfile = '/update-profile';
}
