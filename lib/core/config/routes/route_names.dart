// lib/core/config/routes/route_names.dart

/// Route names constants
/// استخدام String constants بدلاً من hard-coded strings
class RouteNames {
  // Splash & Onboarding
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  
  // Auth
  static const String login = '/login';
  static const String userTypeSelection = '/user-type-selection';
  static const String signUp = '/signup';
  static const String caregiverSignUp = '/caregiver-signup';
  static const String elderlySignUp = '/elderly-signup';
  static const String forgotPassword = '/forgot-password';
  static const String search = '/search';
  static const String otpVerification = '/otp-verification';
  static const String createNewPassword = '/create-new-password';
  
  // Main App
  static const String home = '/home';
  static const String sessions = '/sessions';
  static const String sessionProfile = '/session-profile';
  static const String booking = '/booking';
  static const String requests = '/requests';
  static const String requestDetails = '/request-details';
  static const String sendRequest = '/send-request';
  static const String profile = '/profile';
  static const String rating = '/rating';
  static const String filter = '/filter';
  static const String previousOrders = '/previous-orders';
  static const String reports = '/reports';
  static const String settings = '/settings';
  static const String notificationsSettings = '/notifications-settings';
  static const String languageSettings = '/language-settings';
  static const String privacySettings = '/privacy-settings';
  static const String privacyPolicy = '/privacy-policy';
  static const String accountSecurity = '/account-security';
  static const String deleteAccount = '/delete-account';
  static const String downloadData = '/download-data';
  static const String about = '/about';
  static const String communications = '/communications';
  static const String chat = '/chat';
  static const String myBookings = '/my-bookings';
  static const String caregiverProfile = '/caregiver-profile';
  static const String sessionEvaluation = '/session-evaluation';
  
  // Add more routes as needed
}
