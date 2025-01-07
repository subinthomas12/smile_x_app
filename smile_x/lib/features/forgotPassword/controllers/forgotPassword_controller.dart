import 'package:get/get.dart';
import 'package:smile_x/routes/app_routes.dart';

class ForgotPasswordController extends GetxController {
// forgot password screen

  // Navigate method for navigate to email verification screen
  void navigateToEmailVerification() {
    Get.toNamed(AppRoutes.emailVerification);
  }

// email verification screen

  // Navigate method for navigate to reset password
  void navigateToResetPassword() {
    Get.toNamed(AppRoutes.resetPassword);
  }

  // reset password screen

  // Observable for password visibility
  RxBool isNewPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  // Toggle visibility of the new password field
  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  // Toggle visibility of the confirm password field
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  // Navigate method for navigate to password success
  void navigateToPasswordSuccess() {
    Get.toNamed(AppRoutes.passwordSuccess);
  }

  // password success screen
  void navigateToLogin() {
    Get.toNamed(AppRoutes.login);
  }
}
