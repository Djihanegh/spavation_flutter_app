class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = 'https://spa.esayway.com/public/api';

  // Storage Url
  static const storageUrl = 'https://spa.esayway.com/public/storage/';

  // receiveTimeout
  static const Duration receiveTimeout = Duration(seconds: 15000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(seconds: 15000);

  // Auth

  static const String login = '/auth/login';

  static const String register = '/auth/register';

  static const String checkOtp = '/auth/otp';

  static const String resendOtp = '/auth/resend-otp';

  // Categories

  static const String categories = '/categories';

  // Banners

  static const String banners = '/banners';

  // Salons

  static const String salons = '/salons';

  // Products

  static const String products = '/products/salon/';


}
