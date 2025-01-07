import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/features/forgotPassword/controllers/forgotPassword_controller.dart';

class PasswordSuccessScreen extends StatelessWidget {
  const PasswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = Get.height;
    double screenWidth = Get.width;

     // Get the instance of ForgotPasswordController
     ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());

    return Scaffold(
      body: Container(
        color: AppColors.primary,
        width: screenWidth,
        height: screenHeight,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/dentist_cal.gif',
                width: screenWidth * 0.3,
                height: screenWidth * 0.3,
                fit: BoxFit.cover,
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Success',
                style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondary),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Your new password is successfully \n created',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: AppColors.darkGray,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                ),
                child: ElevatedButton(
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
                          horizontal: screenWidth * 0.06)),
                  child: Text(
                    'Back to Login',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
