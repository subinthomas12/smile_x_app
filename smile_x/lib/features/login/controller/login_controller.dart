import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_x/features/login/view_models/patient_modal.dart';
import 'package:smile_x/routes/app_routes.dart';
import 'package:smile_x/services/api_manager.dart';

class LoginController extends GetxController {
  final ApiManager apiManager;
  LoginController({required this.apiManager});
  var isPasswordHidden = true.obs;
  var isRememberMe = false.obs;

  // Observing login state
  var isLoading = false.obs;
  var loginMessage = ''.obs;

  final Dio dio = Dio();

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    debugPrint("Password visibility toggled: ${isPasswordHidden.value}");
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // Method to toggle "Remember Me" checkbox
  void toggleRememberMe(bool? newValue) {
    isRememberMe.value = newValue ?? false;
  }

  // validate for username and password
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

// Login api
  Future<dynamic> loginUser(String username, String password) async {
    try {
      isLoading.value = true;

      final response = await apiManager.loginUser(username, password);
      if (response != null && response.statusCode == 200) {
        final data = response.data;

        if (data['message'] == 'Login successful') {
          loginMessage.value = 'Login successful';

          // Process and store patient and credentials
          PatientModal patient = PatientModal.fromJson(data['patient']);
          await storePatientData(patient);
          await storeCredentials(username, password);

          navigationToHome();
          return 'Login successful';
        } else {
          loginMessage.value = 'Unexpected response message';
          return 'Unexpected response message';
        }
      } else {
        loginMessage.value = 'Failed to login, please try again later';
        return 'Failed to login, please try again later';
      }
    } catch (e) {
      loginMessage.value = 'An error occurred: $e';
      return 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Login Failed',
      message,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
    );
  }

  // Store patient data in SharedPreferences
  Future<void> storePatientData(PatientModal patient) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('patientData', jsonEncode(patient.toJson()));
  }

  // Store credentials is SharedPreferences
  Future<void> storeCredentials(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setString('password', password);
  }

  //Navigation to home
  void navigationToHome() {
    Get.offNamed(AppRoutes.home);
  }
}
