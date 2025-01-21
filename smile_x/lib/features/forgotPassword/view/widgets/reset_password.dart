import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/core/widgets/common_header.dart';
import 'package:smile_x/core/widgets/custom_snackbar.dart';
import 'package:smile_x/features/forgotPassword/controllers/forgot_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the instance of ForgotPasswordController
    final ForgotPasswordController forgotPasswordController =
        Get.put(ForgotPasswordController());

    final int patientId = Get.arguments as int;
    debugPrint('Received Patient ID in ResetPasswordScreen: $patientId');

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
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth5, vertical: screenHeight4),
          child: Column(
            children: [
              const CommonHeader(title: 'Reset Password'),
              kHeight(0.05),
              SizedBox(
                child: Column(
                  children: [
                    Text(
                      'Enter New Password',
                      style: GoogleFonts.poppins(
                        fontSize: mainTitleSize,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondary,
                      ),
                    ),
                    kHeight(0.01),
                    Text(
                      'Your new password must be different from previously used password',
                      style: GoogleFonts.poppins(
                        fontSize: contentSize,
                        color: AppColors.contents,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    kHeight(0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth5),
                      child: Obx(() {
                        return TextField(
                          controller: newPasswordController,
                          focusNode: newPasswordFocusNode,
                          obscureText: !forgotPasswordController
                              .isNewPasswordVisible.value,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: AppColors.contents,
                              size: smallIconSize,
                            ),
                            labelText: 'New Password',
                            labelStyle: GoogleFonts.poppins(
                              color: newPasswordFocusNode.hasFocus
                                  ? AppColors.secondary
                                  : AppColors.darkGray,
                              fontSize: contentSize,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: screenHeight2,
                              horizontal: screenWidth * 0.1,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 230, 227, 227),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: AppColors.lightGray,
                                width: 1.0,
                              ),
                            ),
                            filled: true,
                            fillColor: AppColors.primary,
                            suffixIcon: IconButton(
                              icon: Icon(
                                forgotPasswordController
                                        .isNewPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.contents,
                                size: smallIconSize,
                              ),
                              onPressed: forgotPasswordController
                                  .toggleNewPasswordVisibility,
                            ),
                          ),
                        );
                      }),
                    ),
                    kHeight(0.02),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth5),
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
                            labelStyle: GoogleFonts.poppins(
                              color: confirmPasswordFocusNode.hasFocus
                                  ? AppColors.secondary
                                  : AppColors.darkGray,
                              fontSize: contentSize,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: screenHeight2,
                              horizontal: screenWidth * 0.1,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 230, 227, 227),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: AppColors.lightGray,
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
                                color: AppColors.contents,
                                size: smallIconSize,
                              ),
                              onPressed: forgotPasswordController
                                  .toggleConfirmPasswordVisibility,
                            ),
                          ),
                        );
                      }),
                    ),
                    kHeight(0.02),
                    ElevatedButton(
                      // onPressed: () {
                      //   forgotPasswordController.navigateToPasswordSuccess();
                      // },
                      onPressed: () {
                        if (newPasswordController.text !=
                            confirmPasswordController.text) {
                          showCustomSnackbar('Error', 'Passwords do not match');
                        } else {
                          forgotPasswordController.changePassword(
                            patientId.toString(),
                            newPasswordController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: screenHeight * 0.015,
                          horizontal: screenWidth8,
                        ),
                      ),
                      child: Obx(() {
                        return forgotPasswordController.isChangingPassword.value
                            ? const CupertinoActivityIndicator(
                                color: AppColors.primary,
                              )
                            : Text(
                                'Save',
                                style: GoogleFonts.poppins(
                                  fontSize: contentSize,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary,
                                ),
                              );
                      }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
