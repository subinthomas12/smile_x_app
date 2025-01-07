import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';

class WorkInProgress extends StatelessWidget {
  WorkInProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.contents),
          onPressed: () {
            Get.back();
          },
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/workInProgress.png',
                // width: screenHeight10,
                // height: screenHeight10,
                // fit: BoxFit.contain,
              ),
              Text(
                'Work In Progress..',
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
