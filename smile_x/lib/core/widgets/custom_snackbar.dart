import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x/core/constants/colors.dart';

void showCustomSnackbar(String title, String message) {
  Get.snackbar(
    title,
    message,
    backgroundColor: AppColors.greyCard,
    colorText: AppColors.secondary,
    icon: const Icon(Icons.info, color: AppColors.secondary),
    borderRadius: 20.0,
    margin: const EdgeInsets.all(10),
    snackPosition: SnackPosition.TOP,
    duration: const Duration(seconds: 3),
    forwardAnimationCurve: Curves.easeInOut,
    reverseAnimationCurve: Curves.easeInOut,
    shouldIconPulse: true,
  );
}
