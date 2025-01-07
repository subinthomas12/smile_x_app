import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/features/forgotPassword/controllers/forgotPassword_controller.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    final ForgotPasswordController forgotPasswordController =
        Get.put(ForgotPasswordController());

    // Focus nodes to manage focus state of each OTP input field
    final FocusNode focusNode1 = FocusNode();
    final FocusNode focusNode2 = FocusNode();
    final FocusNode focusNode3 = FocusNode();
    final FocusNode focusNode4 = FocusNode();

    // TextEditingControllers to handle input data
    final TextEditingController controller1 = TextEditingController();
    final TextEditingController controller2 = TextEditingController();
    final TextEditingController controller3 = TextEditingController();
    final TextEditingController controller4 = TextEditingController();

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
                'Get Your Code',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Please Enter the 4 digit code that \n send to your email address',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: AppColors.darkGray,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildOtpTextField(controller1, focusNode1, focusNode2),
                  SizedBox(width: screenWidth * 0.03),
                  buildOtpTextField(controller2, focusNode2, focusNode3),
                  SizedBox(width: screenWidth * 0.03),
                  buildOtpTextField(controller3, focusNode3, focusNode4),
                  SizedBox(width: screenWidth * 0.03),
                  buildOtpTextField(controller4, focusNode4, FocusNode()),
                ],
              ),
              SizedBox(height: screenHeight * 0.00),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "If you don't receive code!",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: AppColors.darkGray,
                      fontWeight: FontWeight.w500,
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
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w400,
                            color: AppColors.danger,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    forgotPasswordController.navigateToResetPassword();
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
                    'Verify',
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

// Function to build OTP TextField
  Widget buildOtpTextField(TextEditingController controller,
      FocusNode currentFocus, FocusNode nextFocus) {
    return Container(
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
            borderSide: BorderSide(
              color: AppColors.lightGray,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: AppColors.secondary, // Focus color changes to secondary
              width: 2.0,
            ),
          ),
        ),
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.darkGray,
        ),
        onChanged: (value) {
          if (value.isNotEmpty && nextFocus != null) {
            FocusScope.of(currentFocus.context!)
                .requestFocus(nextFocus); // Fix context
          }
        },
      ),
    );
  }
}
