import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:smile_x/core/widgets/custom_snackbar.dart';
import 'package:smile_x/routes/app_routes.dart';
import 'package:smile_x/services/api_client.dart';
import 'package:smile_x/services/api_manager.dart';

class ForgotPasswordController extends GetxController {
  final ApiManager apiManager = ApiManager(apiClient: ApiClient(Dio()));

  RxBool isNewPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  var isSendOtpLoading = false.obs;
  var isOtpVerifying = false.obs;
  var isChangingPassword = false.obs;

// Forgot password screen

  // Method to validate email format
  bool isValidEmail(String email) {
    final regex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return regex.hasMatch(email);
  }

  // Method to send OTP for email validation
  void sendOtp(String email) async {
    if (email.isEmpty) {
      showCustomSnackbar('Error', 'Email is required.');
      return;
    }

    if (!isValidEmail(email)) {
      showCustomSnackbar('Error', 'Please enter a valid email address');
      return;
    }

    isSendOtpLoading.value = true;
    debugPrint("Sending OTP for email: $email");

    try {
      final result = await apiManager.sendOtpForForgotPassword(email);

      debugPrint("API Response: $result");

      if (result['statusCode'] == 200) {
        showCustomSnackbar('Success', result['message']);
        Get.toNamed(AppRoutes.emailVerification, arguments: email);
      } else if (result['statusCode'] == 404) {
        showCustomSnackbar('Error', 'Email not found.');
      } else if (result['statusCode'] == 422) {
        String errorMessage = '';

        if (result['message'] == 'Validation failed' &&
            result['errors']['email'] != null) {
          errorMessage = result['errors']['email'].join(', ');
        }

        if (errorMessage.isEmpty) {
          errorMessage = 'Invalid email address';
        }

        showCustomSnackbar('Error', errorMessage);
      } else {
        showCustomSnackbar('Error', result['message']);
      }
    } catch (e) {
      debugPrint("Error sending OTP: $e");
      showCustomSnackbar('Error', 'An error occurred while sending OTP');
    } finally {
      isSendOtpLoading.value = false;
    }
  }

// Email verification screen

  // Method to verify OTP
  Future<void> verifyOtp(String email, String otp) async {
    if (otp.isEmpty) {
      showCustomSnackbar('Error', 'OTP is required');
      return;
    }

    isOtpVerifying.value = true;

    try {
      final result = await apiManager.verifyOtp(email, otp);

      debugPrint('API Response: $result');
      debugPrint('Response Status Code: ${result['statusCode']}');
      debugPrint('Response Message: ${result['message']}');

      if (result['statusCode'] == 200) {
        showCustomSnackbar('Success', result['message']);
        final patientId = result['patient_id'];
        debugPrint('Patient ID retrieved: $patientId');

        Get.toNamed(AppRoutes.resetPassword, arguments: patientId);
        // if (patientId != null && patientId != 0) {
        //   Get.toNamed(AppRoutes.resetPassword, arguments: patientId);
        // } else {
        //   showCustomSnackbar('Error', 'Patient ID not found');
        // }
      } else if (result['statusCode'] == 401) {
        showCustomSnackbar('Error', result['message']);
      } else if (result['statusCode'] == 422) {
        showCustomSnackbar('Error', result['message']);
      } else {
        showCustomSnackbar('Error', result['message']);
      }
    } catch (e) {
      debugPrint('Error verifying OTP: $e');
      showCustomSnackbar('Error', 'An error occurred while verifying OTP');
    } finally {
      isOtpVerifying.value = false;
    }
  }

  // Reset password screen

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

  // Method to change/reset the password
  void changePassword(String patientId, String newPassword) async {
    try {
      isChangingPassword.value = true;

      final result = await apiManager.changePassword(patientId, newPassword);

      if (result['statusCode'] == 200) {
        showCustomSnackbar('Success', result['message']);
        navigateToPasswordSuccess();
      } else {
        showCustomSnackbar('Error', result['message']);
      }
    } catch (e) {
      debugPrint('Error resetting password: $e');
      showCustomSnackbar(
          'Error', 'An error occurred while resetting the password');
    } finally {
      isChangingPassword.value = false;
    }
  }

  // password success screen
  void navigateToLogin() {
    Get.toNamed(AppRoutes.login);
  }
}
