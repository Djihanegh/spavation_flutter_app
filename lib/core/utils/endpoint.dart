class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = 'https://spa.esayway.com/public/api';

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



}
