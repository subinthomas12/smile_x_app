import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/core/widgets/common_header.dart';
import 'package:smile_x/features/home_container/controllers/profile_screen_controller.dart';

class UserProfileDetails extends StatelessWidget {
  UserProfileDetails({super.key});

  final ProfileScreenController profileController =
      Get.put(ProfileScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth5, vertical: screenHeight3),
            child: Column(
              children: [
                const CommonHeader(title: 'Profile'),
                kHeight3,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      final patient = profileController.patient.value;
                      if (patient == null) {
                        return const Center(
                            child: CupertinoActivityIndicator());
                      }
                      return _buildUsernameContainer(
                          'Registration Date',
                          profileController
                              .formatRegistrationDate(patient.registrationDate),
                          Icons.app_registration_sharp);
                    }),
                    kHeight1,
                    Obx(() {
                      final patient = profileController.patient.value;
                      if (patient == null) {
                        return const Center(
                            child: CupertinoActivityIndicator());
                      }
                      return _buildUsernameContainer(
                          'Code', patient.patientCode, Icons.code);
                    }),
                  ],
                ),
                kHeight2,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Info',
                      style: GoogleFonts.poppins(
                        fontSize: contentSize,
                        color: AppColors.secondary,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                kHeight1,
                Obx(() {
                  final patient = profileController.patient.value;
                  if (patient == null) {
                    return const Center(child: CupertinoActivityIndicator());
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildUsernameContainer(
                          'Name', patient.patientName, Icons.person),
                      kHeight1, // Adjust spacing if needed
                      _buildUsernameContainer(
                          'Age', patient.patientAge, Icons.cake),
                      kHeight1,

                      _buildUsernameContainer(
                          'Mobile', patient.patientMobile, Icons.phone),
                      kHeight1,
                      // _buildUsernameContainer('WhatsApp',
                      //     patient.patientWhatsapp ?? 'N/A', Icons.chat),
                      // kHeight2,
                      _buildUsernameContainer(
                          'Email', patient.patientEmail, Icons.email),
                    ],
                  );
                }),
                kHeight1,
                Obx(() {
                  final patient = profileController.patient.value;
                  if (patient == null) {
                    return const Center(child: CupertinoActivityIndicator());
                  }
                  return _buildUsernameContainer(
                    'Gender',
                    profileController.getGenderString(patient.genderId),
                    profileController.getGenderIcon(patient.genderId),
                  );
                }),
                kHeight1,
                Obx(() {
                  final patient = profileController.patient.value;
                  if (patient == null) {
                    return const Center(child: CupertinoActivityIndicator());
                  }
                  return _buildAddressContainer('Address',
                      patient.patientAddress, Icons.location_city_outlined);
                }),
                kHeight2,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Security',
                      style: GoogleFonts.poppins(
                        fontSize: contentSize,
                        color: AppColors.secondary,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                kHeight1,
                Column(
                  children: [
                    Obx(() {
                      final patient = profileController.patient.value;
                      if (patient == null) {
                        return const Center(
                            child: CupertinoActivityIndicator());
                      }
                      return _buildUsernameContainer(
                          'Username', patient.patientUsername, Icons.person);
                    }),
                    kHeight1,
                    Obx(() {
                      final patient = profileController.patient.value;
                      if (patient == null) {
                        return const Center(
                            child: CupertinoActivityIndicator());
                      }
                      return _buildPasswordContainer(
                          'Password', patient.patientPassword);
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressContainer(String label, String value, IconData icon) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth2, vertical: screenHeight2),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGray, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.contents.withOpacity(0.1),
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Column for the label and value vertically
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label text
              Text(
                '$label:',
                style: GoogleFonts.poppins(
                  color: AppColors.contents,
                  fontSize: smallFontSize,
                ),
              ),
              kHeight1, // Add spacing between label and value
              // Value text
              Text(
                value,
                style: GoogleFonts.poppins(
                  color: AppColors.contents,
                  fontWeight: FontWeight.w500,
                  fontSize: contentSize,
                ),
              ),
            ],
          ),

          Icon(
            icon,
            color: AppColors.contents,
            size: smallIconSize,
          ),
        ],
      ),
    );
  }

  Widget _buildUsernameContainer(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth2, vertical: screenHeight1),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGray, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.contents.withOpacity(0.1),
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$label: ',
                style: GoogleFonts.poppins(
                  color: AppColors.contents,
                  fontSize: smallFontSize,
                ),
              ),
              kHeight2,
              Text(
                value,
                style: GoogleFonts.poppins(
                  color: AppColors.contents,
                  fontWeight: FontWeight.w500,
                  fontSize: contentSize,
                ),
              ),
            ],
          ),
          Icon(
            icon,
            color: AppColors.contents,
            size: smallIconSize,
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordContainer(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth2, vertical: screenHeight1),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGray, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.contents.withOpacity(0.1),
            blurRadius: 3,
            spreadRadius: 1,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label text
              Text(
                '$label: ',
                style: GoogleFonts.poppins(
                  color: AppColors.contents,
                  fontSize: smallFontSize,
                ),
              ),
              kHeight2,
              Obx(() {
                return Text(
                  profileController.isPasswordVisible.value ? value : '******',
                  style: GoogleFonts.poppins(
                    color: AppColors.contents,
                    fontWeight: FontWeight.w500,
                    fontSize: contentSize,
                  ),
                );
              }),
            ],
          ),
          Obx(() {
            return IconButton(
              icon: Icon(
                profileController.isPasswordVisible.value
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: AppColors.contents,
                size: smallIconSize,
              ),
              onPressed: profileController.togglePasswordVisibility,
            );
          }),
        ],
      ),
    );
  }
}
