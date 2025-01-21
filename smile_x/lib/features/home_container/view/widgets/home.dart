import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/features/home_container/controllers/homescreen_controller.dart';
import 'package:smile_x/features/home_container/controllers/profile_screen_controller.dart';
import 'package:smile_x/features/home_container/controllers/select_aligner_controller.dart';
import 'package:smile_x/features/home_container/view/widgets/custom_progress_indicator.dart';
import 'package:smile_x/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController());
  final SelectAlignerController selectAlignerController =
      Get.put(SelectAlignerController());

  final ProfileScreenController profileController =
      Get.put(ProfileScreenController());
  HomeScreen({super.key});

  Future<bool> _onWillPop() async {
    return await Get.dialog(
          AlertDialog(
            title: Text(
              'Exit',
              style: GoogleFonts.poppins(
                fontSize: subTitleSize,
                color: AppColors.secondary,
                fontWeight: FontWeight.w400,
              ),
            ),
            content: Text(
              'Are you sure want to exit app?',
              style: GoogleFonts.poppins(
                fontSize: contentSize,
                color: AppColors.contents,
              ),
              textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Get.back(result: false),
                child: Text(
                  'No',
                  style: GoogleFonts.poppins(
                    fontSize: smallFontSize,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: Text(
                  'Yes',
                  style: GoogleFonts.poppins(fontSize: smallFontSize),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth5, vertical: screenHeight3),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Hello!',
                            style: GoogleFonts.poppins(
                              fontSize: contentSize,
                              fontWeight: FontWeight.w500,
                              color: AppColors.contents,
                            ),
                          ),
                          Obx(() {
                            return Text(
                              profileController.patient.value?.patientName ??
                                  'Loading...',
                              style: GoogleFonts.aBeeZee(
                                fontSize: mainTitleSize,
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondary,
                              ),
                            );
                          }),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Monitoring',
                            style: GoogleFonts.poppins(
                              fontSize: contentSize,
                              fontWeight: FontWeight.w500,
                              color: AppColors.contents,
                            ),
                          ),
                          kWidth(0.02),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightGray,
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.notifications_none,
                                size: iconSize,
                                color: AppColors.darkGray,
                              ),
                              onPressed: () {
                                Get.toNamed(AppRoutes.notifications);
                              },
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth2,
                                  vertical: screenHeight1),
                              iconSize: screenHeight2,
                            ),
                          )
                        ],
                      ),
                      // Second Section
                    ],
                  ),
                  kHeight(0.04),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Obx(() {
                        return CircularProgressWithPointer(
                          radius: 0.6,
                          progress:
                              selectAlignerController.wearingProgress.value,
                          progressColor: AppColors.yellowlight,
                          iconData: Icons.thumb_up_rounded,
                          iconSize: smallIconSize,
                          strokeWidth: screenHeight * 0.016,
                          pointerAvatarRadius: screenHeight * 0.014,
                          nonProgressColor: AppColors.lightGray,
                          pointerAvatarColor: AppColors.yellowlight,
                          pointerIconColor: AppColors.primary,
                        );
                      }),
                      // Obx(() {
                      //   return CircularProgressWithPointer(
                      //     radius: 0.55,
                      //     progress:
                      //         selectAlignerController.notWearingProgress.value,
                      //     progressColor: AppColors.secondary,
                      //     iconData: Icons.fastfood_rounded,
                      //     iconSize: smallIconSize,
                      //     strokeWidth: screenHeight * 0.016,
                      //     pointerAvatarRadius: screenHeight * 0.014,
                      //     nonProgressColor: AppColors.lightGray,
                      //     pointerAvatarColor: AppColors.secondary,
                      //     pointerIconColor: AppColors.primary,
                      //   );
                      // }),
                      Obx(
                        () {
                          if (selectAlignerController.isProcessing.value) {
                            return const Center(
                              child: CupertinoActivityIndicator(
                                color: AppColors.secondary,
                              ),
                            );
                          }
                          return Container(
                            width: screenWidth * 0.47,
                            height: screenWidth * 0.47,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary,
                              boxShadow: [
                                BoxShadow(
                                  color: selectAlignerController
                                              .wearingStatus.value ==
                                          1
                                      ? AppColors.lightGray.withOpacity(0.5)
                                      : AppColors.danger.withOpacity(0.2),
                                  spreadRadius: 8,
                                  blurRadius: 5,
                                ),
                              ],
                              border: Border.all(
                                color: selectAlignerController
                                            .wearingStatus.value ==
                                        1
                                    ? AppColors.lightGray.withOpacity(0.5)
                                    : AppColors.danger.withOpacity(0.1),
                                width: 2.0,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                if (selectAlignerController
                                    .isProcessing.value) {
                                  // If a process is already running, do nothing or show a loading indicator
                                  return; // Skip if already processing
                                }

                                // Proceed with the action if not processing
                                if (selectAlignerController
                                        .wearingStatus.value ==
                                    1) {
                                  await selectAlignerController
                                      .updateTracking();
                                } else {
                                  await selectAlignerController
                                      .saveAlignerTracking("home");
                                }
                              },
                              child: CircleAvatar(
                                radius: screenWidth * 0.2,
                                backgroundColor: AppColors.primary,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      selectAlignerController
                                                  .wearingStatus.value ==
                                              1
                                          ? 'Wearing'
                                          : 'Not Wearing',
                                      style: GoogleFonts.poppins(
                                        color: AppColors.blueShade,
                                        fontSize: subTitleSize,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.001),
                                    Text(
                                      'Smilexcel',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: screenHeight * 0.015,
                                        color: const Color.fromARGB(
                                            160, 30, 30, 30),
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.001),
                                    Text(
                                      selectAlignerController
                                          .formattedTotalWearingHours.value,
                                      style: GoogleFonts.poppins(
                                        fontSize: wearTimer,
                                        color: AppColors.secondary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.001),
                                    Text(
                                      'Out ${selectAlignerController.formattedNotWearingHours.value} Hrs',
                                      style: GoogleFonts.poppins(
                                        color: AppColors.greyShade,
                                        fontSize: contentSize,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  kHeight(0.05),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          return _buildCardItem(Icons.sync,
                              "${selectAlignerController.currentUpperAligner}\n${selectAlignerController.currentLowerAligner}",
                              () {
                            homeScreenController.navigateToSelectAligner();
                          });
                        }),
                        SizedBox(width: screenWidth2),
                        _buildCardItem(Icons.calendar_month,
                            '23 days: Keep Your Smile Bright!', () {
                          debugPrint("Remaining days.....");
                          // int countdown = profileController
                          //         .patient.value?.scheduleCountDown ??
                          //     0;
                          // debugPrint("Remaining days: $countdown");
                        }),
                      ],
                    ),
                  ),
                  kHeight(0.05),
                  Card(
                    color: AppColors.lightGray,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth2, vertical: screenHeight1),
                      child: SizedBox(
                        width: double.infinity,
                        height: screenHeight7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    'assets/images/dental-teeth.gif',
                                    width: screenWidth * 0.15,
                                    height: screenHeight * 0.15,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: screenWidth3),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Smilexcel',
                                      style: GoogleFonts.aBeeZee(
                                        fontSize: subTitleSize,
                                        color: AppColors.secondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'What are Aligners',
                                      style: GoogleFonts.poppins(
                                        fontSize: contentSize,
                                        color: AppColors.darkGray,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.whatAreAligners);
                              },
                              child: Icon(
                                Icons.keyboard_arrow_right_outlined,
                                size: iconSize,
                                color: AppColors.blueShade,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildCardItem(IconData icon, String title, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Card(
      color: AppColors.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: screenWidth * 0.4,
        height: screenHeight * 0.15,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth1,
          vertical: screenHeight3,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: smallIconSize,
              color: AppColors.primary,
            ),
            kHeight(0.01),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: contentSize,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
