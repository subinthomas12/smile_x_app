import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/features/home_container/view/widgets/calendar.dart';
import 'package:smile_x/features/home_container/view/widgets/home.dart';
import 'package:smile_x/features/home_container/view/widgets/profile.dart';
import 'package:smile_x/features/home_container/view/widgets/status.dart';

import '../../../../core/constants/colors.dart';
import '../../controllers/home_controller.dart';

class HomeContainer extends StatelessWidget {
  final NavigationController _navController = Get.put(NavigationController());

  HomeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Obx(
        () {
          switch (_navController.selectedIndex.value) {
            case 0:
              return const HomeScreen();
            case 1:
              return const CalenderScreen();
            case 2:
              return StatusScreen();
            default:
              return ProfileScreen();
          }
        },
      ),
      bottomNavigationBar: Obx(() {
        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth2, vertical: screenHeight3),
              child: Container(
                height: screenHeight7,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(color: AppColors.primary, width: 1)),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  unselectedItemColor: AppColors.contents,
                  selectedItemColor: AppColors.secondary,
                  currentIndex: _navController.selectedIndex.value,
                  onTap: (index) {
                    _navController.changeTabIndex(index);
                  },
                  elevation: 0,
                  backgroundColor: AppColors.primary,
                  selectedFontSize: smallFontSize,
                  selectedLabelStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                  unselectedFontSize: smallFontSize,
                  unselectedLabelStyle:
                      GoogleFonts.poppins(fontWeight: FontWeight.w300),
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home, size: iconSize),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.calendar_month, size: iconSize),
                      label: 'Calendar',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.auto_graph_rounded, size: iconSize),
                      label: 'Status',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person, size: iconSize),
                      label: 'Profile',
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 65,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: _navController.requestCameraPermission,
                backgroundColor: AppColors.primary,
                child: Icon(
                  Icons.add_a_photo_rounded,
                  size: screenWidth6,
                  color: AppColors.secondary,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
