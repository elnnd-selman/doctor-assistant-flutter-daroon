import 'package:daroon_doctor/app/modules/doctor/doctor_add_post/binding/doctor_post_binding.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_add_post/pages/doctor_update_post.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/binding/doctor_detail_binding.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/binding/doctor_office_binding.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/binding/edit_doctor_address_binding.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/binding/edit_doctor_schedule_binding.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/pages/edit_address_doctor.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/pages/edit_doctor_schedule.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/pages/see_on_map_offices.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/pages/add_assistant_premission.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/pages/change_assistant_address.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/pages/search_user_screen.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/pages/select_assistant_address.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/pages/add_offer_address.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/pages/edit_offer.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/pages/edit_offer_address.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/pages/offer_add_succesfully.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/binding/doctor_edit_profile_binding.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/pages/add_doctor_education.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/pages/doctor_change_email.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/pages/doctor_change_username.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/pages/post_like_user_detail.dart';
import 'package:get/get.dart';
import 'package:daroon_doctor/app/modules/auth/forget/binding/forget_password_binding.dart';
import 'package:daroon_doctor/app/modules/auth/forget/pages/forget_email.dart';
import 'package:daroon_doctor/app/modules/auth/forget/pages/forget_otp_screen.dart';
import 'package:daroon_doctor/app/modules/auth/forget/pages/forget_password_screen.dart';
import 'package:daroon_doctor/app/modules/auth/forget/pages/forget_phone.dart';
import 'package:daroon_doctor/app/modules/auth/login/binding/login_binding.dart';
import 'package:daroon_doctor/app/modules/auth/login/binding/opt_binding.dart';
import 'package:daroon_doctor/app/modules/auth/login/pages/login_screen.dart';
import 'package:daroon_doctor/app/modules/auth/reset_password/binding/reset_password_binding.dart';
import 'package:daroon_doctor/app/modules/auth/reset_password/pages/reset_password.dart';
import 'package:daroon_doctor/app/modules/auth/signup/pages/email_phone_screen.dart';
import 'package:daroon_doctor/app/modules/auth/signup/pages/first_signup_screen.dart';
import 'package:daroon_doctor/app/modules/auth/signup/pages/otp_screen.dart';
import 'package:daroon_doctor/app/modules/auth/signup/pages/profile_picture_screen.dart';
import 'package:daroon_doctor/app/modules/auth/signup/pages/singup_screen.dart';
import 'package:daroon_doctor/app/modules/auth/signup/pages/welcome_screen.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/binding/doctor_address_binding.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/pages/add_adress_detail.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/pages/add_doctor_address.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/pages/doctor_address_details.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/binding/doctor_appointment_binding.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/pages/appointment_detail_screen.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_appointment/pages/cancel_appointment_detail.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/binding/doctor_assistant_binding.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/pages/add_assistant.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/pages/doctor_assistant_detail.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/pages/doctor_assistants.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/pages/edit_address.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_assistant/pages/edit_assistant.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_bottom_navi_bar/binding/doctor_home_binding.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_bottom_navi_bar/page/doctor_bottom_navi_bar.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_bottom_navi_bar/page/doctor_drawer.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_message/pages/doctor_chat_room.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_message/pages/doctor_message.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_notification/pages/doctor_notification.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/binding/doctor_offers_binding.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/pages/add_offer.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/pages/doctor_offer_detail.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_offers/pages/doctor_offers_page.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/binding/doctor_profile_binding.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/pages/doctor_edit_level.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/pages/doctor_edit_profile.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/pages/doctor_edit_speciality.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/pages/doctor_language.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_profile/pages/doctor_profile.dart';
import 'package:daroon_doctor/app/modules/on_boarding/pages/login_selection_screen.dart';
import 'package:daroon_doctor/app/modules/on_boarding/pages/onboarding_screen.dart';
import 'package:daroon_doctor/app/modules/splash/splash_screen.dart';
import 'package:daroon_doctor/app/routes/app_routes.dart';

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
      page: () => LoginScreen(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.firstsignup,
      page: () => const FirstSignupScreen(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.singup,
      page: () => SignUpScreen(),
      binding: LoginBindings(),
    ),
    GetPage(
      name: Routes.emailPhoneNumber,
      page: () => const EmailPhoneNumberScreen(),
    ),
    GetPage(
        name: Routes.otpScreen,
        page: () => const OtpScreen(),
        binding: OptBinding()),
    GetPage(
      name: Routes.forgetPassword,
      page: () => const ForgetPassowrdScreen(),
      binding: ForgetPasswordBindings(),
    ),
    GetPage(
      name: Routes.forgetPhone,
      page: () => const ForgetPhoneScreen(),
      binding: ForgetPasswordBindings(),
    ),
    GetPage(
      name: Routes.forgetOTPScreen,
      page: () => const ForgetOtpScreen(),
      binding: ForgetPasswordBindings(),
    ),
    GetPage(
      name: Routes.forgetEmail,
      page: () => ForgetEmailScreen(),
      binding: ForgetPasswordBindings(),
    ),
    GetPage(
      name: Routes.resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
      binding: ResetPasswordBinding(),
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
      name: Routes.doctorOffersDetails,
      page: () => DoctorOfferDetailScreen(),
    ),
    GetPage(
      name: Routes.doctorAppointmentDetail,
      page: () => const AppointmentDetailScreen(),
    ),
    GetPage(
      name: Routes.doctorAddOffers,
      page: () => const DoctorAddOfferScreen(),
      binding: DoctorOffersBinding(),
    ),
    GetPage(
      name: Routes.doctorEditOffers,
      page: () => DoctorEditOfferScreen(),
      binding: DoctorOffersBinding(),
    ),
    GetPage(
      name: Routes.addOfferAddress,
      page: () => const AddOfferAddress(),
      binding: DoctorOffersBinding(),
    ),
    GetPage(
      name: Routes.editOfferAddress,
      page: () => EditOfferAddress(),
      binding: DoctorOffersBinding(),
    ),
    GetPage(
      name: Routes.addOfferSuccessfully,
      page: () => OfferAddSuccesfully(),
    ),
    GetPage(
      name: Routes.cancelAppointment,
      page: () => const CancelAppointmentDetail(),
      binding: DoctorAppointmentBinding(),
    ),
    GetPage(
      name: Routes.doctorAssistant,
      page: () => const DoctorAssistantsScreen(),
      binding: DoctorAssistantBinding(),
    ),
    GetPage(
      name: Routes.changeAssistantAddress,
      page: () => ChangeAssistantAddress(),
      binding: DoctorAssistantBinding(),
    ),
    GetPage(
      name: Routes.doctorAssistantDetail,
      page: () => DoctorAssistantDetailScreen(),
      binding: DoctorAssistantBinding(),
    ),
    GetPage(
      name: Routes.doctorAssistantEditAddress,
      page: () => const DoctorAssistentEditAddress(),
      binding: DoctorAssistantBinding(),
    ),
    GetPage(
      name: Routes.doctorAssistantEditProfile,
      page: () => const EditAssistantProfile(),
    ),
    GetPage(
      name: Routes.adddoctorAssistant,
      page: () => const AddAssistantScreen(),
      binding: DoctorAssistantBinding(),
    ),
    GetPage(
      name: Routes.adddoctorAssistantPremission,
      page: () => const AddAssistantPremission(),
      binding: DoctorAssistantBinding(),
    ),
    GetPage(
      name: Routes.selectDoctorAssistant,
      page: () => const SelectAssistantAddress(),
      binding: DoctorAssistantBinding(),
    ),
    GetPage(
      name: Routes.searchUser,
      page: () => const SearchUserScreen(),
      binding: DoctorAssistantBinding(),
    ),
    GetPage(
      name: Routes.doctorProfile,
      page: () => const DoctorProfileScreen(),
      binding: DoctorHomeBinding(),
    ),
    GetPage(
      name: Routes.doctorEditProfile,
      page: () => const DoctorEditProfile(),
      binding: DoctorProfileBinding(),
    ),
    ///////////////// Chnage binding
    GetPage(
      name: Routes.doctorchangeLanguage,
      page: () => const DoctorLanguageScreen(),
      binding: DoctorProfileBinding(),
    ),

    GetPage(
      name: Routes.doctorEditSpeciality,
      page: () => const DoctorEditSpeciality(),
      binding: DoctorEditProfileBinding(),
    ),
    GetPage(
      name: Routes.doctorEditLevel,
      page: () => const DoctorEditLevel(),
      binding: DoctorEditProfileBinding(),
    ),
    GetPage(
      name: Routes.doctorChangeEmail,
      page: () => const DoctorChangeEmail(),
      binding: DoctorEditProfileBinding(),
    ),
    GetPage(
      name: Routes.doctorChangeUserName,
      page: () => const DoctorChangeUsername(),
      binding: DoctorEditProfileBinding(),
    ),
    /////////////////
    GetPage(
      name: Routes.doctorMessage,
      page: () => const DoctorMessageScreen(),
    ),
    GetPage(
      name: Routes.doctorChatRoom,
      page: () => const DoctorChatRoom(),
    ),
    GetPage(
      name: Routes.doctorNotification,
      page: () => const DoctorNotificationScreen(),
    ),
    GetPage(
      name: Routes.addDoctorAdress,
      page: () => const AddDoctorAddressScreen(),
      binding: DoctorAddressBinding(),
    ),
    GetPage(
      name: Routes.addDoctorAdressDetail,
      page: () => const AddAdressDetailScreen(),
      binding: DoctorAddressBinding(),
    ),
    GetPage(
      name: Routes.doctorAdressDetail,
      page: () => const DoctorAddressDetailsScreen(),
      binding: DoctorDetailBinding(),
    ),
    GetPage(
      name: Routes.editdoctorAdress,
      page: () => EditAddressDoctor(),
      binding: EditDoctorAddressBinding(),
    ),
    GetPage(
      name: Routes.editdoctorSchedule,
      page: () => EditDoctorSchedule(),
      binding: EditDoctorScheduleBinding(),
    ),
    GetPage(
      name: Routes.postUpdate,
      page: () => DoctorUpdatePost(),
      binding: DoctorPostBinding(),
    ),
    GetPage(
        name: Routes.addEducation,
        page: () => const AddDoctorEducation(),
        binding: DoctorEditProfileBinding()),
    GetPage(
      name: Routes.seeOnMapOffices,
      page: () => const SeeOnMapOffices(),
      binding: DoctorOfficeBinding(),
    ),
    GetPage(
      name: Routes.postLikeUserDetail,
      page: () => const PostLikeUserDetail(),
    ),

    ///
    /////////////// User Side Screens///
    // GetPage(
    //   name: Routes.userdrawerScreen,
    //   page: () => const UserDrawerScreen(),
    //   binding: UserHomeBinding(),
    // ),
    // GetPage(
    //   name: Routes.userOfferScreen,
    //   page: () => const UserOfferScreen(),
    //   binding: UserOffersBinding(),
    // ),
    // GetPage(
    //   name: Routes.userOffersDetails,
    //   page: () => const UserOfferDetailScreen(),
    // ),
    // GetPage(
    //   name: Routes.filterScreen,
    //   page: () => const FilterScreen(),
    //   binding: UserTopDoctorBinding(),
    // ),
  ];
}
