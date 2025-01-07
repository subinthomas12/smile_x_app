import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/core/widgets/logo_image_widget.dart';
import 'package:smile_x/features/home_container/controllers/profile_screen_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileScreenController profileController =
      Get.put(ProfileScreenController());

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'prefixIcon': Icons.account_circle,
        'title': 'Personal Info',
        'suffixIcon': Icons.arrow_forward_ios,
        'onPressed': () {
          profileController.navigateToUserProfileDetails();
        },
      },
      {
        'prefixIcon': Icons.sync,
        'title': 'Adjust Current Treatment',
        'suffixIcon': Icons.arrow_forward_ios,
        'onPressed': () {
          profileController.navigateToAdjustTreatment();
        },
      },
      {
        'prefixIcon': Icons.notifications_active,
        'title': 'Notifications',
        'suffixIcon': Icons.arrow_forward_ios,
        'onPressed': () {
          debugPrint("notification......");
        },
      },
      {
        'prefixIcon': Icons.settings,
        'title': 'Settings',
        'suffixIcon': Icons.arrow_forward_ios,
        'onPressed': () {
          profileController.navigateToWorkInProgress();
        },
      },
      {
        'prefixIcon': Icons.support_agent,
        'title': 'Support & Help',
        'suffixIcon': Icons.arrow_forward_ios,
        'onPressed': () {
          profileController.navigateToSupportAndHelp();
        },
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth5, vertical: screenHeight3),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(screenWidth2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const LogoImageWidget(),
                                SizedBox(height: screenHeight1),
                                Text(
                                  'Hello!',
                                  style: GoogleFonts.poppins(
                                    fontSize: contentSize,
                                    color: AppColors.contents,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Obx(() {
                                  return Text(
                                    profileController
                                            .patient.value?.patientName ??
                                        'Loading...',
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: mainTitleSize,
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(screenWidth2),
                            child: CircleAvatar(
                              radius: screenWidth * 0.10,
                              // backgroundImage: const AssetImage(
                              //     'assets/images/front-view-man-posing-outdoors.jpg'),
                              backgroundImage:
                                  profileController.getProfileImage(),
                            ),
                          ),
                        ],
                      ),
                      kHeight2,
                      Row(
                        children: [
                          // _profileCustomButton(
                          //   screenWidth,
                          //   'Start New \n Treatment',
                          //   Icons.add,
                          //   () {
                          //     profileController.navigateToWorkInProgress();
                          //   },
                          // ),
                          // kWidth2,
                          // _profileCustomButton(
                          //   screenWidth,
                          //   'Adjust Current Treatment',
                          //   Icons.sync,
                          //   () {
                          //     profileController.navigateToAdjustTreatment();
                          //   },
                          // ),
                        ],
                      ),
                      kHeight1,
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: menuItems.length,
                        itemBuilder: (context, index) {
                          final item = menuItems[index];
                          return _buildProfileMenuButton(
                            item['prefixIcon'],
                            item['title'],
                            item['suffixIcon'],
                            item['onPressed'],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              kHeight3,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.danger,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                onPressed: () {
                  profileController.userLogout();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      color: AppColors.primary,
                      size: smallIconSize,
                    ),
                    kWidth2,
                    Text(
                      'Logout',
                      style: GoogleFonts.poppins(
                        fontSize: contentSize,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileMenuButton(IconData prefixIcon, String title,
      IconData suffixIcon, Callback? onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight05),
      child: SizedBox(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.lightGray, width: 2),
            ),
          ),
          onPressed: onPressed,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight2),
            child: Row(
              children: [
                Icon(
                  prefixIcon,
                  size: screenWidth6,
                  color: AppColors.contents,
                ),
                kWidth2,
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color: AppColors.contents,
                    fontSize: contentSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(
                  suffixIcon,
                  size: smallIconSize,
                  color: AppColors.contents,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _profileCustomButton(
      double screenWidth, String title, IconData icon, Callback? onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: screenHeight10,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.lightGray,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: screenWidth6,
                color: AppColors.contents,
              ),
              kHeight1,
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: contentSize,
                  color: AppColors.contents,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
