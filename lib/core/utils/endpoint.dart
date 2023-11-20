class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = 'http://admin.spavation.co/public/api';

  // dev Url

  static const String devUrl = 'https://spa.esayway.com/public/api';

  // Storage Url
  static const storageUrl =
      'http://admin.spavation.co/public/storage/'; // 'https://spa.esayway.com/public/storage/';

  // receiveTimeout
  static const Duration receiveTimeout = Duration(seconds: 15000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(seconds: 80);

  // Auth

  static const String login = '/auth/login';

  static const String register = '/auth/register';

  static const String checkOtp = '/auth/otp';

  static const String resendOtp = '/auth/resend-otp';

  static const String customer = '/auth/customer';

  static const String getUser = '/auth/user';

  // Categories

  static const String categories = '/categories';

  // Banners

  static const String banners = '/banners';

  // Salons

  static const String salons = '/salons';

  static const String searchSalons = '/salons/search/';

  // Cities

  static const String cities = '/cities';

  // Products

  static const String products = '/products/salon/';

  static const String productTimes = '/products/time-intervals/';

  // Reservations

  static const String reservations = '/reservations';

  // Coupons

  static const String coupon = '/check-copoun';

  // Forgot Password

  static const String forgetPasswordSendOtp = '/forgot-password/send-otp';
  static const String updatePassword = '/forgot-password/update-password';
  static const String forgetPasswordCheckOtp = '/forgot-password/check-otp';
}
