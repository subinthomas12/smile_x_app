import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/features/login/view_models/patient_modal.dart';
import 'package:smile_x/routes/app_routes.dart';

class ProfileScreenController extends GetxController {
  // Observable variable for patient data
  Rx<PatientModal?> patient = Rx<PatientModal?>(null);

  // Observable variable for password visibility
  RxBool isPasswordVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchPatientData();
  }

  // Fetch the patient data from SharedPreferences
  Future<void> _fetchPatientData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? patientDataJson = prefs.getString('patientData');

    if (patientDataJson != null) {
      patient.value = PatientModal.fromJson(jsonDecode(patientDataJson));
    }
  }

  // Method to map genderId to string
  String getGenderString(int genderId) {
    switch (genderId) {
      case 1:
        return 'Male';
      case 2:
        return 'Female';
      case 3:
        return 'Others';
      default:
        return 'N/A'; // Default value for unrecognized genderId
    }
  }

  // Method to map genderId to string and return the corresponding icon
  IconData getGenderIcon(int genderId) {
    switch (genderId) {
      case 1:
        return Icons.male;
      case 2:
        return Icons.female;
      case 3:
        return Icons.transgender;
      default:
        return Icons.person;
    }
  }

  // Method to format the registration date
  String formatRegistrationDate(String? registrationDate) {
    if (registrationDate == null || registrationDate.isEmpty) {
      return 'N/A';
    }
    try {
      DateFormat inputFormat = DateFormat('dd-MM-yyyy');
      DateTime date = inputFormat.parse(registrationDate);
      return DateFormat('dd-MM-yyyy').format(date);
    } catch (e) {
      return 'Invalid Date';
    }
  }

  // Method to get the profile image based on gender
  ImageProvider getProfileImage() {
    if (patient.value != null) {
      int genderId = patient.value?.genderId ?? 0;

      switch (genderId) {
        case 1:
          return const AssetImage(
              'assets/images/front-view-man-posing-outdoors.jpg');
        case 2:
          return const AssetImage('assets/images/girl_smile.jpg');
        case 3:
          return const AssetImage('assets/images/Profile_avatar.png');
        default:
          return const AssetImage(
              'assets/images/front-view-man-posing-outdoors.jpg');
      }
    }
    return const AssetImage('assets/images/front-view-man-posing-outdoors.jpg');
  }

  // Method to navigate to Adjust treatment
  void navigateToAdjustTreatment() {
    Get.toNamed(AppRoutes.adjustTreatment);
  }

  // Method to navigate to Adjust treatment start date
  void navigateToAdjustTreatmentStartDate() {
    Get.toNamed(AppRoutes.adjustTreatmentStartDate);
  }

  // Method to navigate to user profile details
  void navigateToUserProfileDetails() {
    Get.toNamed(AppRoutes.userProfileDetails);
  }

  // Method to navigate to Work in progress screen
  void navigateToWorkInProgress() {
    Get.toNamed(AppRoutes.workInProgress);
  }

  void navigateToSupportAndHelp() {
    Get.toNamed(AppRoutes.supportAndHelp);
  }

  void navigateToUploadsHistory() {
    Get.toNamed(AppRoutes.uploadsHistory);
  }

  // Method for navigate to Treatment update screen
  void navigateToTreatmentUpdate({
    required int alignerId,
    required String alignerType,
  }) {
    Get.toNamed(
      AppRoutes.adjustTreatmentUpdate,
      arguments: {
        'alignerId': alignerId,
        'alignerType': alignerType,
      },
    );
  }

  // Method to toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

// Logout method with shared preferences clearing
  void userLogout() async {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Logout',
          style: GoogleFonts.poppins(
            fontSize: subTitleSize,
            color: AppColors.secondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: GoogleFonts.poppins(
            fontSize: contentSize,
            color: AppColors.contents,
          ),
          textAlign: TextAlign.justify,
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Close the dialog
              Get.back();
            },
            child: Text(
              'No',
              style: GoogleFonts.poppins(
                fontSize: smallFontSize,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('username');
              await prefs.remove('password');
              Get.offNamed(AppRoutes.login);
            },
            child: Text(
              'Yes',
              style: GoogleFonts.poppins(fontSize: smallFontSize),
            ),
          ),
        ],
      ),
    );
  }
}
