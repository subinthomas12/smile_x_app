import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';

import '../widgets/animated_swipe_container.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            // height: Get.height,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              image: DecorationImage(
                image: AssetImage('assets/images/splash.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: screenHeight5,
            left: screenWidth5,
            right: screenWidth5,
            child: Card(
              color: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(33),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth4, vertical: screenHeight3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome',
                      style: GoogleFonts.aBeeZee(
                        fontSize: mainTitleSize,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondary,
                      ),
                    ),
                    kHeight1,
                    Text(
                      '"Smile Brighter, Live Healthier! Your personal guide to dental care at your fingertips."',
                      style: GoogleFonts.aBeeZee(
                        fontSize: contentSize,
                        fontWeight: FontWeight.w500,
                        color: AppColors.contents,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    kHeight2,
                    AnimatedSwipeButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
