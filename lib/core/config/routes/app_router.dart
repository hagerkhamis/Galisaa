// lib/core/config/routes/app_router.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import '../../../features/splash/presentation/pages/splash_page.dart';
import '../../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../../features/auth/presentation/pages/login_page.dart';
import '../../../features/auth/presentation/pages/user_type_selection_page.dart';
import '../../../features/auth/presentation/pages/sign_up_page.dart';
import '../../../features/auth/presentation/pages/caregiver_signup_page.dart';
import '../../../features/auth/presentation/pages/elderly_signup_page.dart';
import '../../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../../features/auth/presentation/pages/create_new_password_page.dart';
import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/sessions/presentation/pages/sessions_list_page.dart';
import '../../../features/sessions/presentation/pages/session_profile_page.dart';
import '../../../features/sessions/presentation/pages/filter_page.dart';
import '../../../features/sessions/presentation/pages/search_page.dart';
import '../../../features/sessions/presentation/pages/booking_page.dart';
import '../../../features/requests/presentation/pages/requests_list_page.dart';
import '../../../features/requests/presentation/pages/request_details_page.dart';
import '../../../features/requests/presentation/pages/send_request_page.dart';
import '../../../features/requests/presentation/pages/previous_orders_page.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
import '../../../features/profile/presentation/pages/caregiver_profile_page.dart';
import '../../../features/profile/presentation/pages/reports_page.dart';
import '../../../features/profile/presentation/pages/settings_page.dart';
import '../../../features/profile/presentation/pages/notifications_settings_page.dart';
import '../../../features/profile/presentation/pages/language_settings_page.dart';
import '../../../features/profile/presentation/pages/privacy_settings_page.dart';
import '../../../features/profile/presentation/pages/privacy_policy_page.dart';
import '../../../features/profile/presentation/pages/account_security_page.dart';
import '../../../features/profile/presentation/pages/delete_account_page.dart';
import '../../../features/profile/presentation/pages/download_data_page.dart';
import '../../../features/profile/presentation/pages/about_page.dart';
import '../../../features/rating/presentation/pages/rating_page.dart';
import '../../../features/rating/presentation/pages/session_evaluation_page.dart';
import '../../../features/communication/presentation/pages/communications_page.dart';
import '../../../features/communication/presentation/pages/chat_page.dart';
import '../../../features/bookings/presentation/pages/my_bookings_page.dart';

/// Router configuration using GoRouter
/// يوفر Navigation للتطبيق
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.splash,
    routes: [
      // Splash Route
      GoRoute(
        path: RouteNames.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),

      // Onboarding Route
      GoRoute(
        path: RouteNames.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),

      // Auth Routes
      GoRoute(
        path: RouteNames.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.userTypeSelection,
        name: RouteNames.userTypeSelection,
        builder: (context, state) => const UserTypeSelectionPage(),
      ),
      GoRoute(
        path: RouteNames.caregiverSignUp,
        name: RouteNames.caregiverSignUp,
        builder: (context, state) => const CaregiverSignupPage(),
      ),
      GoRoute(
        path: RouteNames.elderlySignUp,
        name: RouteNames.elderlySignUp,
        builder: (context, state) => const ElderlySignupPage(),
      ),
      GoRoute(
        path: RouteNames.signUp,
        name: RouteNames.signUp,
        builder: (context, state) {
          final userType = state.uri.queryParameters['userType'];
          return SignUpPage(userType: userType);
        },
      ),
      GoRoute(
        path: RouteNames.forgotPassword,
        name: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: RouteNames.otpVerification,
        name: RouteNames.otpVerification,
        builder: (context, state) => const OtpVerificationPage(),
      ),
      GoRoute(
        path: RouteNames.createNewPassword,
        name: RouteNames.createNewPassword,
        builder: (context, state) => const CreateNewPasswordPage(),
      ),

      // Main App Routes
      GoRoute(
        path: RouteNames.home,
        name: RouteNames.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: RouteNames.sessions,
        name: RouteNames.sessions,
        builder: (context, state) => const SessionsListPage(),
      ),
      GoRoute(
        path: RouteNames.filter,
        name: RouteNames.filter,
        builder: (context, state) => const FilterPage(),
      ),
      GoRoute(
        path: RouteNames.search,
        name: RouteNames.search,
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: RouteNames.sessionProfile,
        name: RouteNames.sessionProfile,
        builder: (context, state) => const SessionProfilePage(),
      ),
      GoRoute(
        path: RouteNames.booking,
        name: RouteNames.booking,
        builder: (context, state) => const BookingPage(),
      ),
      GoRoute(
        path: RouteNames.requests,
        name: RouteNames.requests,
        builder: (context, state) => const RequestsListPage(),
      ),
      GoRoute(
        path: RouteNames.requestDetails,
        name: RouteNames.requestDetails,
        builder: (context, state) => const RequestDetailsPage(),
      ),
      GoRoute(
        path: RouteNames.sendRequest,
        name: RouteNames.sendRequest,
        builder: (context, state) => const SendRequestPage(),
      ),
      GoRoute(
        path: RouteNames.profile,
        name: RouteNames.profile,
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: RouteNames.caregiverProfile,
        name: RouteNames.caregiverProfile,
        builder: (context, state) => const CaregiverProfilePage(),
      ),
      GoRoute(
        path: RouteNames.previousOrders,
        name: RouteNames.previousOrders,
        builder: (context, state) => const PreviousOrdersPage(),
      ),
      GoRoute(
        path: RouteNames.reports,
        name: RouteNames.reports,
        builder: (context, state) => const ReportsPage(),
      ),
      GoRoute(
        path: RouteNames.settings,
        name: RouteNames.settings,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: RouteNames.notificationsSettings,
        name: RouteNames.notificationsSettings,
        builder: (context, state) => const NotificationsSettingsPage(),
      ),
      GoRoute(
        path: RouteNames.languageSettings,
        name: RouteNames.languageSettings,
        builder: (context, state) => const LanguageSettingsPage(),
      ),
      GoRoute(
        path: RouteNames.privacySettings,
        name: RouteNames.privacySettings,
        builder: (context, state) => const PrivacySettingsPage(),
      ),
      GoRoute(
        path: RouteNames.privacyPolicy,
        name: RouteNames.privacyPolicy,
        builder: (context, state) => const PrivacyPolicyPage(),
      ),
      GoRoute(
        path: RouteNames.accountSecurity,
        name: RouteNames.accountSecurity,
        builder: (context, state) => const AccountSecurityPage(),
      ),
      GoRoute(
        path: RouteNames.deleteAccount,
        name: RouteNames.deleteAccount,
        builder: (context, state) => const DeleteAccountPage(),
      ),
      GoRoute(
        path: RouteNames.downloadData,
        name: RouteNames.downloadData,
        builder: (context, state) => const DownloadDataPage(),
      ),
      GoRoute(
        path: RouteNames.about,
        name: RouteNames.about,
        builder: (context, state) => const AboutPage(),
      ),
      GoRoute(
        path: RouteNames.communications,
        name: RouteNames.communications,
        builder: (context, state) => const CommunicationsPage(),
      ),
      GoRoute(
        path: RouteNames.chat,
        name: RouteNames.chat,
        builder: (context, state) {
          final userName = state.uri.queryParameters['userName'];
          return ChatPage(userName: userName);
        },
      ),
      GoRoute(
        path: RouteNames.myBookings,
        name: RouteNames.myBookings,
        builder: (context, state) => const MyBookingsPage(),
      ),
      GoRoute(
        path: RouteNames.rating,
        name: RouteNames.rating,
        builder: (context, state) => const RatingPage(),
      ),
      GoRoute(
        path: RouteNames.sessionEvaluation,
        name: RouteNames.sessionEvaluation,
        builder: (context, state) {
          final date = state.uri.queryParameters['date'];
          final time = state.uri.queryParameters['time'];
          final caregiverName = state.uri.queryParameters['caregiverName'];
          return SessionEvaluationPage(
            date: date,
            time: time,
            caregiverName: caregiverName,
          );
        },
      ),
    ],
    
    // Error handling
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
  );
});
