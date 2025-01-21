import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/core/widgets/common_header.dart';
import 'package:smile_x/features/forgotPassword/controllers/forgot_password_controller.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController forgotPasswordController =
        Get.put(ForgotPasswordController());

    // Create a FocusNode to manage focus state
    final FocusNode emailFocusNode = FocusNode();
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth5, vertical: screenHeight4),
          child: Column(
            children: [
              const CommonHeader(title: 'Verify Email'),
              kHeight(0.05),
              Center(
                child: Container(
                  color: AppColors.primary,
                  child: Column(
                    children: [
                      Text(
                        'Email',
                        style: GoogleFonts.poppins(
                          fontSize: mainTitleSize,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondary,
                        ),
                      ),
                      kHeight(0.01),
                      Text(
                        'Enter the email address associated with your account',
                        style: GoogleFonts.poppins(
                          fontSize: contentSize,
                          color: AppColors.contents,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      kHeight(0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth5),
                        child: TextField(
                          focusNode: emailFocusNode,
                          controller: emailController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: AppColors.contents,
                              size: smallIconSize,
                            ),
                            labelText: 'Email',
                            labelStyle: GoogleFonts.poppins(
                              color: emailFocusNode.hasFocus
                                  ? AppColors.secondary
                                  : AppColors.contents,
                              fontSize: contentSize,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: screenHeight2,
                              horizontal: screenWidth7,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: AppColors.lightGray,
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: AppColors.darkGray,
                                width: 1.0,
                              ),
                            ),
                            filled: true,
                            fillColor: AppColors.primary,
                          ),
                        ),
                      ),
                      kHeight(0.02),
                      ElevatedButton(
                        onPressed: () {
                          forgotPasswordController
                              .sendOtp(emailController.text);
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
                          return forgotPasswordController.isSendOtpLoading.value
                              ? const CupertinoActivityIndicator(
                                  color: AppColors.primary,
                                )
                              : Text(
                                  'Get OTP',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
