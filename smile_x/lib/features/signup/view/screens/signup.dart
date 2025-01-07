import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x/core/constants/colors.dart';

import 'package:smile_x/features/signup/controllers/signup_controller.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    // Using GetX to manage password visibility state
    final SignupController signupController = Get.put(SignupController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            children: [
              // Logo
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.00),
                child: Center(
                  child: Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.3,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/xlogo.png.pagespeed.ic.5Ym489GxiS.webp',
                      width: screenWidth * 0.7,
                      height: screenHeight * 0.3,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              // Title "Register"
              SizedBox(height: screenHeight * 0.03),
              Text(
                'Register',
                style: TextStyle(
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
                textAlign: TextAlign.center,
              ),
              // Subtitle "Create your account"
              SizedBox(height: screenHeight * 0.00),
              Text(
                'Create your account',
                style: TextStyle(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkGray,
                ),
                textAlign: TextAlign.center,
              ),
              // Username Input Field
              SizedBox(height: screenHeight * 0.03),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: AppColors.darkGray,
                  ),
                  hintText: 'Username',
                  hintStyle: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkGray),
                  filled: true,
                  fillColor: AppColors.lightGray,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                ),
              ),
              // Email or Mobile Input Field
              SizedBox(height: screenHeight * 0.03),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: AppColors.darkGray,
                  ),
                  hintText: 'Mobile or Email',
                  hintStyle: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkGray),
                  filled: true,
                  fillColor: AppColors.lightGray,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                ),
              ),
              // Password Input Field with Eye Icon
              SizedBox(height: screenHeight * 0.03),
              Obx(
                () => TextField(
                  obscureText: signupController.isPasswordHidden.value,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.darkGray,
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w400,
                        color: AppColors.contents),
                    filled: true,
                    fillColor: AppColors.lightGray,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 20),
                    suffixIcon: IconButton(
                      icon: Icon(
                        signupController.isPasswordHidden.value
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: AppColors.contents,
                        size: screenWidth * 0.06,
                      ),
                      onPressed: () {
                        signupController.togglePasswordVisibility();
                      },
                    ),
                  ),
                ),
              ),
              // Sign Up Button
              SizedBox(height: screenHeight * 0.13),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w400,
                      color: AppColors.darkGray,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      signupController.navigationToLogin();
                    },
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 1.5,
                            color: AppColors.secondary,
                          ),
                        ),
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
