import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/features/forgotPassword/controllers/forgotPassword_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = Get.height;
    double screenWidth = Get.width;

    // Get the instance of ForgotPasswordController
    final ForgotPasswordController forgotPasswordController =
        Get.put(ForgotPasswordController());

    // Create text controllers
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    // Focus nodes for password fields
    final FocusNode newPasswordFocusNode = FocusNode();
    final FocusNode confirmPasswordFocusNode = FocusNode();

    // GetX observable for password visibility
    RxBool isNewPasswordVisible = false.obs;
    RxBool isConfirmPasswordVisible = false.obs;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          'Email Verification',
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.w600,
            color: AppColors.darkGray,
          ),
        ),
        leading: Stack(
          children: [
            Positioned(
              left: 10,
              top: 8,
              bottom: 8,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.lightGray,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColors.darkGray,
                    size: screenWidth * 0.05,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: AppColors.primary,
        width: screenWidth,
        height: screenHeight,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter New Password',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Your new password must be different \n from previously used password',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: AppColors.darkGray,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.02),

              // New Password Text Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Obx(() {
                  return TextField(
                    controller: newPasswordController,
                    focusNode: newPasswordFocusNode,
                    obscureText:
                        !forgotPasswordController.isNewPasswordVisible.value,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: AppColors.darkGray,
                        size: screenWidth * 0.05,
                      ),
                      labelText: 'New Password',
                      labelStyle: TextStyle(
                        color: newPasswordFocusNode.hasFocus
                            ? AppColors.secondary
                            : AppColors.darkGray,
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.1,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 230, 227, 227),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: AppColors.darkGray,
                          width: 1.0,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.primary,
                      suffixIcon: IconButton(
                        icon: Icon(
                          forgotPasswordController.isNewPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.darkGray,
                        ),
                        onPressed: forgotPasswordController
                            .toggleNewPasswordVisibility,
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Confirm Password Text Field
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Obx(() {
                  return TextField(
                    controller: confirmPasswordController,
                    focusNode: confirmPasswordFocusNode,
                    obscureText: !forgotPasswordController
                        .isConfirmPasswordVisible.value,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: AppColors.darkGray,
                        size: screenWidth * 0.05,
                      ),
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                        color: confirmPasswordFocusNode.hasFocus
                            ? AppColors.secondary
                            : AppColors.darkGray,
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.02,
                        horizontal: screenWidth * 0.1,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 230, 227, 227),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: AppColors.darkGray,
                          width: 1.0,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColors.primary,
                      suffixIcon: IconButton(
                        icon: Icon(
                          forgotPasswordController
                                  .isConfirmPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.darkGray,
                        ),
                        onPressed: forgotPasswordController
                            .toggleConfirmPasswordVisibility,
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    forgotPasswordController.navigateToPasswordSuccess();
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
                    'Continue',
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
