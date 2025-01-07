import 'package:get/get.dart';
import 'package:smile_x/core/widgets/work_in_progress.dart';
import 'package:smile_x/features/forgotPassword/view/screens/forgotPassword.dart';
import 'package:smile_x/features/forgotPassword/view/widgets/emailVerification.dart';
import 'package:smile_x/features/forgotPassword/view/widgets/passwordSuccess.dart';
import 'package:smile_x/features/forgotPassword/view/widgets/resetPassword.dart';
import 'package:smile_x/features/home_container/controllers/adjust_treatment.dart';
import 'package:smile_x/features/home_container/controllers/adjust_treatment_start_date.dart';
import 'package:smile_x/features/home_container/controllers/adjust_treatment_update.dart';
import 'package:smile_x/features/home_container/controllers/notifications.dart';
import 'package:smile_x/features/home_container/controllers/select_aligner.dart';
import 'package:smile_x/features/home_container/controllers/support_and_help.dart';
import 'package:smile_x/features/home_container/controllers/user_profile_details.dart';
import 'package:smile_x/features/home_container/controllers/what_are_aligner.dart';
import 'package:smile_x/features/home_container/view/screens/home_container.dart';
import 'package:smile_x/features/login/view/screens/login.dart';
import 'package:smile_x/features/signup/view/screens/signup.dart';
import 'package:smile_x/features/Initial_screen/view/screens/initial_screen.dart';
import 'package:smile_x/features/splash/view/screens/splash_screen.dart';

import 'app_routes.dart';

//app pages
class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.initial,
      page: () => const InitialScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeContainer(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => const SignupScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPassword(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.emailVerification,
      page: () => const EmailVerificationScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const ResetPasswordScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.passwordSuccess,
      page: () => const PasswordSuccessScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.whatAreAligners,
      page: () => const WhatAreAligners(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => NotificationScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.userProfileDetails,
      page: () => UserProfileDetails(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.adjustTreatment,
      page: () => AdjustTreatment(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.workInProgress,
      page: () => WorkInProgress(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.adjustTreatmentUpdate,
      page: () => AdjustTreatmentUpdate(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.adjustTreatmentStartDate,
      page: () => AdjustTreatmentStartDate(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.selectAligner,
      page: () => SelectAligner(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.supportAndHelp,
      page: () => SupportAndHelp(),
      transition: Transition.fadeIn,
    ),
  ];
}
