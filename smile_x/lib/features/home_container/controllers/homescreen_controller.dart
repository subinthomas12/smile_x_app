import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/routes/app_routes.dart';

class HomeScreenController extends GetxController {
  // Toggle between 'Wearing' and 'Not Wearing'
  RxBool isWearing = true.obs;

  RxDouble wearingProgress = 0.0.obs;
  RxDouble notWearingProgress = 0.0.obs;
  Timer? _wearingProgressTimer;
  Timer? _notWearingProgressTimer;

  double wearingProgressValue = 0.0;
  double notWearingProgressValue = 0.0;
  double increment = 1.0 / (24 * 60.0);

  int selectedUpperIndex = 0;
  int selectedLowerIndex = 0;
  final List<String> upperAligners =
      List.generate(10, (index) => 'Upper Aligner #${index + 1}');
  final List<String> lowerAligners =
      List.generate(10, (index) => 'Lower Aligners #${index + 1}');

  @override
  void onInit() {
    super.onInit();
    startWearingProgress();
  }

  // Method to start or resume progress for wearing
  void startWearingProgress() {
    isWearing.value = true;
    if (_wearingProgressTimer?.isActive ?? false) return;

    // Start a periodic timer for wearing progress
    _wearingProgressTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isWearing.value) {
        // Track wearing progress
        if (wearingProgressValue < 1.0) {
          wearingProgressValue += increment;
          wearingProgress.value = wearingProgressValue;
        } else {
          // Switch to not wearing once wearing reaches 1.0
          isWearing.value = false;
          startNotWearingProgress(); // Start not wearing progress when wearing reaches 1.0
        }
      }
    });
  }

  // Method to start or resume progress for not wearing
  void startNotWearingProgress() {
    isWearing.value = false;
    if (_notWearingProgressTimer?.isActive ?? false) return;

    // Start a periodic timer for not wearing progress
    _notWearingProgressTimer =
        Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isWearing.value) {
        // Track not wearing progress
        if (notWearingProgressValue < 1.0) {
          notWearingProgressValue += increment;
          notWearingProgress.value = notWearingProgressValue;
        }
      }
    });
  }

// method for show set reminder for wearing
  void showReminderDialogIfWearing() async {
    if (!isWearing.value) {
      await Future.delayed(const Duration(seconds: 1));

      Get.dialog(
        barrierDismissible: false,
        Container(
          constraints: BoxConstraints(maxWidth: screenWidth10),
          child: AlertDialog(
            contentPadding: EdgeInsets.zero,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'Set Reminder for Wear',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: screenHeight2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: AppColors.lightGray,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.contents,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
            content: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02, horizontal: screenWidth1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildPicker(
                              label: 'Hour',
                              values: List.generate(
                                  12, (index) => (index + 1).toString()),
                              initialValue: 1,
                              onSelected: (selectedValue) {
                                // Handle Hour selected value
                              },
                            ),
                            kWidth3,
                            _buildPicker(
                              label: 'Minute',
                              values: List.generate(60,
                                  (index) => index.toString().padLeft(2, '0')),
                              initialValue: 0,
                              onSelected: (selectedValue) {
                                // Handle Minute selected value
                              },
                            ),
                          ],
                        ),
                      ),
                      kHeight1,
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildPicker(
                              label: 'AM/PM',
                              values: ['AM', 'PM'],
                              initialValue: 0,
                              onSelected: (selectedValue) {},
                            ),
                          ],
                        ),
                      ),
                      kHeight1,
                      // Time Interval Buttons
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildTimeButton('5 min'),
                            _buildTimeButton('15 min'),
                            _buildTimeButton('30 min'),
                            _buildTimeButton('1 hr'),
                          ],
                        ),
                      ),
                      kHeight1,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildConfirmCancelButton(
                              'Confirm',
                              AppColors.secondary,
                              AppColors.primary,
                              AppColors.secondary, () {
                            debugPrint('Confirm clcked');
                          }),
                          _buildConfirmCancelButton('Cancel', AppColors.primary,
                              AppColors.secondary, AppColors.lightGray, () {
                            Get.back();
                          })
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

// Helper widget to build each picker (Hour, Minute, AM/PM)
  Widget _buildPicker({
    required String label,
    required List<String> values,
    required int initialValue,
    required Function(String) onSelected,
  }) {
    int selectedIndex = initialValue;

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: AppColors.contents,
                fontSize: screenHeight * 0.016,
                fontWeight: FontWeight.w500,
              ),
            ),
            kHeight1,
            Container(
              width: screenWidth * 0.2,
              height: screenHeight * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.lightGray.withOpacity(0.5),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.lightGray.withOpacity(0.1),
                    blurRadius: 8.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: ListWheelScrollView.useDelegate(
                itemExtent: 50.0,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                  onSelected(values[index]);
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    return Center(
                      child: Text(
                        values[index],
                        style: TextStyle(
                          fontSize: screenHeight * 0.025,
                          fontWeight: FontWeight.w500,
                          color: selectedIndex == index
                              ? AppColors.secondary
                              : AppColors.contents,
                        ),
                      ),
                    );
                  },
                  childCount: values.length,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Helper widget for time interval buttons
  Widget _buildTimeButton(String label) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(
        Icons.timer,
        color: AppColors.secondary,
        size: screenHeight * 0.015,
      ),
      label: Text(
        label,
        style: TextStyle(
          color: AppColors.secondary,
          fontSize: screenHeight * 0.015,
        ),
      ),
    );
  }

  // Helper widget for Confirm and Cancel buttons
  Widget _buildConfirmCancelButton(String label, Color bgColor, Color textColor,
      Color borderColor, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: bgColor,
            side: BorderSide(color: borderColor, width: 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: screenHeight * 0.015,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  // Method to pause the current progress
  void pauseProgress() {
    if (_wearingProgressTimer?.isActive ?? false) {
      _wearingProgressTimer?.cancel(); // Stop the wearing timer
    }

    if (_notWearingProgressTimer?.isActive ?? false) {
      _notWearingProgressTimer?.cancel(); // Stop the not wearing timer
    }
  }

  // Method to reset progress (both wearing and not wearing)
  void resetProgress() {
    // Reset both timers and progress values
    wearingProgressValue = 0.0;
    notWearingProgressValue = 0.0;
    wearingProgress.value = 0.0;
    notWearingProgress.value = 0.0;
    isWearing.value = true; // Start with wearing again

    // Restart the wearing progress
    startWearingProgress();
  }

  // Method to manually start progress (if needed)
  void manualStartProgress() {
    // Start wearing progress manually when the user clicks to start the process
    startWearingProgress();
  }

// Navigate to select aligner screen
  void navigateToSelectAligner() {
    Get.toNamed(AppRoutes.selectAligner);
  }

  // Helper method to build aligner section for Upper/Lower
  Widget _buildAlignerSection(String title, List<String> aligners,
      int selectedIndex, Function(int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: screenHeight * 0.015,
              color: AppColors.secondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        kHeight2,
        SizedBox(
          height: screenHeight * 0.12,
          child: ListWheelScrollView.useDelegate(
            itemExtent: screenHeight * 0.06,
            diameterRatio: 1.5,
            onSelectedItemChanged: onChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                bool isSelected = index == selectedIndex;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isSelected
                          ? AppColors.secondary
                          : AppColors.lightGray,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          aligners[index],
                          style: GoogleFonts.poppins(
                            fontSize: screenHeight * 0.015,
                            fontWeight: FontWeight.w500,
                            color:
                                isSelected ? Colors.white : AppColors.contents,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
              childCount: aligners.length,
            ),
          ),
        ),
      ],
    );
  }
}
