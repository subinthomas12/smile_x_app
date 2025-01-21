import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/features/forgotPassword/controllers/forgot_password_controller.dart';

class PasswordSuccessScreen extends StatelessWidget {
  const PasswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ForgotPasswordController forgotPasswordController =
        Get.put(ForgotPasswordController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth5, vertical: screenHeight4),
          child: Container(
            color: AppColors.primary,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/dentist_cal.gif',
                    width: screenWidth * 0.2,
                    height: screenWidth * 0.2,
                  ),
                  kHeight(0.01),
                  Text(
                    'Success',
                    style: GoogleFonts.poppins(
                      fontSize: mainTitleSize,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary,
                    ),
                  ),
                  kHeight(0.01),
                  Text(
                    'Your new password is successfully created',
                    style: GoogleFonts.poppins(
                      fontSize: contentSize,
                      color: AppColors.contents,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  kHeight(0.02),
                  ElevatedButton(
                    onPressed: () {
                      forgotPasswordController.navigateToLogin();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.06,
                      ),
                    ),
                    child: Text(
                      'Back to Login',
                      style: GoogleFonts.poppins(
                        fontSize: contentSize,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
