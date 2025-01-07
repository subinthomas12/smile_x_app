import 'package:get/get.dart';
import 'package:smile_x/routes/app_routes.dart';

class SignupController extends GetxController {
  var isPasswordHidden = true.obs;
  var isRememberMe = false.obs;

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Navigation method
  void navigationToLogin() {
    Get.toNamed(AppRoutes.login);
  }
}
