import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/features/splash/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/splash_loader.gif',
                width: screenHeight10,
                height: screenHeight10,
                fit: BoxFit.contain,
              ),
              Text(
                'Please wait...',
                style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.w600,
                    color: AppColors.contents),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
