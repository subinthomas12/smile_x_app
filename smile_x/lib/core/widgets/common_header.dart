import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';

class CommonHeader extends StatelessWidget {
  final String title;

  const CommonHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: screenHeight3,
          backgroundColor: AppColors.lightGray,
          child: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.contents,
              size: smallIconSize,
            ),
          ),
        ),
        kWidth5,
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: subTitleSize,
            color: AppColors.contents,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
