import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/core/widgets/common_header.dart';
import 'package:smile_x/features/forgotPassword/controllers/forgot_password_controller.dart';
import 'package:pinput/pinput.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController forgotPasswordController =
        Get.put(ForgotPasswordController());

    final String email = Get.arguments ?? '';
    debugPrint("Received email: $email");
    final TextEditingController pinController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth5, vertical: screenHeight4),
          child: Column(
            children: [
              const CommonHeader(title: 'Verify OTP'),
              kHeight(0.05),
              Center(
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        'Get Your Code',
                        style: GoogleFonts.poppins(
                          fontSize: mainTitleSize,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondary,
                        ),
                      ),
                      kHeight(0.01),
                      Text(
                        'Please Enter the 6 digit code that  send to your email address',
                        style: GoogleFonts.poppins(
                          fontSize: contentSize,
                          color: AppColors.contents,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      kHeight(0.02),
                      Pinput(
                        controller: pinController,
                        length: 6,
                        keyboardType: TextInputType.number,
                        onCompleted: (pin) {
                          debugPrint('OTP Completed: $pin');
                        },
                        onChanged: (pin) {
                          debugPrint('OTP changed: $pin');
                        },
                        focusedPinTheme: PinTheme(
                          width: screenWidth10,
                          height: screenHeight5,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.secondary,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        submittedPinTheme: PinTheme(
                          width: screenWidth10,
                          height: screenHeight5,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.contents,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        followingPinTheme: PinTheme(
                          width: screenWidth10,
                          height: screenHeight5,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.lightGray,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "If you don't receive code!",
                            style: GoogleFonts.poppins(
                              fontSize: contentSize,
                              color: AppColors.contents,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 1.5,
                                    color: AppColors.danger,
                                  ),
                                ),
                                Text(
                                  'Resend',
                                  style: GoogleFonts.poppins(
                                    fontSize: contentSize,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.danger,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Obx(() {
                        return ElevatedButton(
                          onPressed: () {
                            final otp = pinController.text;
                            forgotPasswordController.verifyOtp(email, otp);
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
                          child: forgotPasswordController.isOtpVerifying.value
                              ? const CupertinoActivityIndicator(
                                  color: AppColors.primary,
                                )
                              : Text(
                                  'Verify',
                                  style: GoogleFonts.poppins(
                                    fontSize: contentSize,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primary,
                                  ),
                                ),
                        );
                      }),
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

// Function to build OTP TextField
  Widget buildOtpTextField(TextEditingController controller,
      FocusNode currentFocus, FocusNode nextFocus) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextField(
        controller: controller,
        focusNode: currentFocus,
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          counterText: "",
          filled: true,
          fillColor: Colors.white,
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
              color: AppColors.secondary,
              width: 2.0,
            ),
          ),
        ),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.darkGray,
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(currentFocus.context!).requestFocus(nextFocus);
          }
        },
      ),
    );
  }
}
