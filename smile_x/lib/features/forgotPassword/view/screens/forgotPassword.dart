import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/features/forgotPassword/controllers/forgotPassword_controller.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    final ForgotPasswordController forgotPasswordController =
        Get.put(ForgotPasswordController());

    // Create a FocusNode to manage focus state
    final FocusNode emailFocusNode = FocusNode();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          'Forgot Password',
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
                'Mail Address Here',
                style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondary),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Enter the email address associated \n with your account',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: AppColors.darkGray,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight * 0.02),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
              //   child: TextField(
              //     decoration: InputDecoration(
              //       prefixIcon: Icon(
              //         Icons.email_outlined,
              //         color: AppColors.darkGray,
              //         size: screenWidth * 0.05,
              //       ),
              //       hintText: 'Email',
              //       hintStyle: TextStyle(
              //         fontSize: screenWidth * 0.04,
              //         color: AppColors.darkGray,
              //       ),
              //       filled: true,
              //       fillColor: AppColors.lightGray,
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(30),
              //           borderSide: BorderSide.none),
              //       contentPadding: EdgeInsets.symmetric(
              //           vertical: screenHeight * 0.02,
              //           horizontal: screenWidth * 0.02),
              //     ),
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: TextField(
                  focusNode: emailFocusNode,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: AppColors.darkGray,
                      size: screenWidth * 0.05,
                    ),
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: emailFocusNode.hasFocus
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
                  ),
                  // style: TextStyle(
                  //   color: AppColors.secondary,
                  //   fontSize: screenWidth * 0.04,
                  //   height: 1.5,
                  // ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.1,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    forgotPasswordController.navigateToEmailVerification();
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
                    'Recover Password',
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
