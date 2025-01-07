import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/features/login/controller/login_controller.dart';
import 'package:smile_x/services/api_client.dart';
import 'package:smile_x/services/api_manager.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(
        LoginController(apiManager: ApiManager(apiClient: ApiClient(Dio()))));

    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth7, vertical: screenHeight2),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                Image.asset(
                  'assets/images/logo.png',
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.15,
                  fit: BoxFit.contain,
                ),

                Column(
                  children: [
                    Text(
                      'Welcome',
                      style: GoogleFonts.aBeeZee(
                        fontSize: mainTitleSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Login to your account',
                      style: GoogleFonts.poppins(
                        fontSize: contentSize,
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkGray,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    kHeight3,
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
                          color: AppColors.darkGray,
                          size: smallIconSize,
                        ),
                        hintText: 'Username',
                        hintStyle: GoogleFonts.poppins(
                            fontSize: contentSize,
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkGray),
                        filled: true,
                        fillColor: AppColors.lightGray,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: screenHeight2, horizontal: screenWidth2),
                      ),
                      validator: (value) {
                        return loginController.validateUsername(value);
                      },
                    ),
                    kHeight1,
                    Obx(
                      () => TextFormField(
                          controller: passwordController,
                          obscureText: loginController.isPasswordHidden.value,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: AppColors.darkGray,
                              size: smallIconSize,
                            ),
                            hintText: 'Password',
                            hintStyle: GoogleFonts.poppins(
                                fontSize: contentSize,
                                fontWeight: FontWeight.w400,
                                color: AppColors.contents),
                            filled: true,
                            fillColor: AppColors.lightGray,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: screenHeight2,
                                horizontal: screenWidth2),
                            suffixIcon: IconButton(
                              icon: Icon(
                                loginController.isPasswordHidden.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: AppColors.contents,
                                size: smallIconSize,
                              ),
                              onPressed: () {
                                loginController.togglePasswordVisibility();
                              },
                            ),
                          ),
                          validator: (value) {
                            return loginController.validatePassword(value);
                          }),
                    ),
                  ],
                ),
                Obx(
                  () {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            String username = usernameController.text;
                            String password = passwordController.text;

                            loginController.loginUser(username, password);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.02),
                        ),
                        child: loginController.isLoading.value
                            ? SizedBox(
                                width: screenHeight3,
                                height: screenHeight3,
                                child: CupertinoActivityIndicator(
                                  color: AppColors.primary,
                                  radius: screenHeight2,
                                ),
                              )
                            : Text(
                                'Login',
                                style: GoogleFonts.poppins(
                                  fontSize: contentSize,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primary,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
