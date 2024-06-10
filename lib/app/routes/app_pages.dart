import 'package:get/get.dart';
import 'package:hezr/app/modules/auth/forget/binding/forget_password_binding.dart';
import 'package:hezr/app/modules/auth/forget/pages/forget_password_screen.dart';
import 'package:hezr/app/modules/auth/login/binding/login_binding.dart';
import 'package:hezr/app/modules/auth/login/pages/login_screen.dart';
import 'package:hezr/app/modules/auth/signup/pages/email_phone_screen.dart';
import 'package:hezr/app/modules/auth/signup/pages/otp_screen.dart';
import 'package:hezr/app/modules/auth/signup/pages/profile_picture_screen.dart';
import 'package:hezr/app/modules/auth/signup/pages/singup_screen.dart';
import 'package:hezr/app/modules/auth/signup/pages/welcome_screen.dart';
import 'package:hezr/app/modules/doctor/doctor_appointment/binding/doctor_appointment_binding.dart';
import 'package:hezr/app/modules/doctor/doctor_appointment/pages/appointment_detail_screen.dart';
import 'package:hezr/app/modules/doctor/doctor_appointment/pages/cancel_appointment_detail.dart';
import 'package:hezr/app/modules/doctor/doctor_bottom_navi_bar/binding/doctor_home_binding.dart';
import 'package:hezr/app/modules/doctor/doctor_bottom_navi_bar/page/doctor_bottom_navi_bar.dart';
import 'package:hezr/app/modules/doctor/doctor_bottom_navi_bar/page/doctor_drawer.dart';
import 'package:hezr/app/modules/doctor/doctor_offers/binding/doctor_offers_binding.dart';
import 'package:hezr/app/modules/doctor/doctor_offers/pages/doctor_offers_page.dart';
import 'package:hezr/app/modules/on_boarding/pages/login_selection_screen.dart';
import 'package:hezr/app/modules/on_boarding/pages/onboarding_screen.dart';
import 'package:hezr/app/modules/splash/splash_screen.dart';
import 'package:hezr/app/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => const OnBoardingScreen(),
    ),
    GetPage(
      name: Routes.loginSelectionScreen,
      page: () => const LoginSelectionScreen(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginScreen(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.singup,
      page: () => const SignUpScreen(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.emailPhoneNumber,
      page: () => const EmailPhoneNumberScreen(),
    ),
    GetPage(
      name: Routes.otpScreen,
      page: () => const OtpScreen(),
    ),
    GetPage(
      name: Routes.forgetPassword,
      page: () => const ForgetPassowrdScreen(),
      binding: ForgetPasswordBindings(),
    ),
    GetPage(
      name: Routes.profilePic,
      page: () => const ProfilePictureScreen(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.welcome,
      page: () => const WelcomeScreen(),
    ),
    GetPage(
      name: Routes.doctordrawerScreen,
      page: () => const DoctorDrawerScreen(),
      binding: DoctorHomeBinding(),
    ),
    GetPage(
      name: Routes.doctorBottomNaviBar,
      page: () => const DoctorBottomNaviBar(),
    ),
    GetPage(
      name: Routes.doctorOffers,
      page: () => const DoctorOffersPage(),
      binding: DoctorOffersBinding(),
    ),
    GetPage(
      name: Routes.doctorAppointmentDetail,
      page: () => const AppointmentDetailScreen(),
    ),
    GetPage(
      name: Routes.cancelAppointment,
      page: () => const CancelAppointmentDetail(),
      binding: DoctorAppointmentBinding(),
    ),
  ];
}
