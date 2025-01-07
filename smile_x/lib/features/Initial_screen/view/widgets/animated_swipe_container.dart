import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slider_button/slider_button.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/features/Initial_screen/controllers/initial_controller.dart';

import '../../../../core/constants/colors.dart';

class AnimatedSwipeButton extends StatelessWidget {
  final InitialScreenController controller = Get.put(InitialScreenController());

  AnimatedSwipeButton({super.key});

  @override
  Widget build(BuildContext context) {
    // return Obx(
    //   () {
    // Using Obx to listen to isSwiped and rebuild widget when it changes
    return SliderButton(
      action: () async {
        controller.swipe();
        return true;
      },
      height: 60,
      alignLabel: Alignment.center,
      label: Text(
        "Swipe to Start",
        style: GoogleFonts.aBeeZee(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
          fontSize: contentSize,
        ),
      ),
      icon: Icon(
        Icons.fingerprint,
        color: AppColors.contents,
        size: screenHeight4,
        semanticLabel: 'Swipe icon',
      ),
      buttonSize: 40,
      buttonColor: AppColors.primary,
      backgroundColor: AppColors.secondary,
      highlightedColor: Colors.white,
      baseColor: AppColors.primary,
    );
    //     AnimatedContainer(
    //       duration: const Duration(milliseconds: 300),
    //       width: controller.isSwiped.value ? 60 : screenWidth * 0.8,
    //       height: controller.isSwiped.value ? 60 : 60,
    //       decoration: BoxDecoration(
    //         color: AppColors.secondary,
    //         borderRadius:
    //             BorderRadius.circular(controller.isSwiped.value ? 45 : 50),
    //       ),
    //       child: Stack(
    //         children: [
    //           // If not swiped, show the swipe button
    //           if (!controller.isSwiped.value)
    //             SliderButton(
    //               action: () async {
    //                 controller.swipe();
    //                 return true;
    //               },
    //               alignLabel: Alignment.center,
    //               label: Text(
    //                 "Swipe to Start",
    //                 style: GoogleFonts.aBeeZee(
    //                   color: AppColors.primary,
    //                   fontWeight: FontWeight.w500,
    //                   fontSize: screenHeight2,
    //                 ),
    //               ),
    //               icon: Icon(
    //                 Icons.fingerprint,
    //                 color: AppColors.contents,
    //                 size: screenHeight4,
    //                 semanticLabel: 'Swipe icon',
    //               ),
    //               buttonSize: 45,
    //               buttonColor: AppColors.primary,
    //               backgroundColor: AppColors.secondary,
    //               highlightedColor: Colors.white,
    //               baseColor: AppColors.primary,
    //             ),
    //           // If swiped, show check icon
    //           if (controller.isSwiped.value)
    //             Center(
    //               child: Icon(
    //                 Icons.check,
    //                 color: Colors.white,
    //                 size: screenHeight3,
    //               ),
    //             ),
    //           Visibility(
    //             visible: controller.isSwiped.value != true,
    //             child: Padding(
    //               padding: EdgeInsets.only(right: screenWidth2),
    //               child: Align(
    //                 heightFactor: 2.5,
    //                 alignment: Alignment.centerRight,
    //                 child: Icon(
    //                   Icons.keyboard_double_arrow_right_rounded,
    //                   color: AppColors.primary,
    //                   size: screenHeight3,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
