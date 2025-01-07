import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/core/widgets/common_header.dart';

class SupportAndHelp extends StatelessWidget {
  SupportAndHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth5, vertical: screenHeight3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonHeader(title: 'Support & Help'),
                kHeight2,
                Text(
                  'Need assistance?',
                  style: GoogleFonts.poppins(
                    color: AppColors.secondary,
                    fontSize: subTitleSize,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.start,
                ),
                kHeight1,
                Text(
                  'We are here to assist you with any dental-related concerns. '
                  'Whether you need help booking an appointment, understanding treatment options, or managing your care, '
                  'our team is ready to provide the guidance you need.',
                  style: GoogleFonts.poppins(
                    color: AppColors.contents,
                    fontSize: contentSize,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.justify,
                ),
                kHeight3,
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          debugPrint('tap icon');
                        },
                        child: CircleAvatar(
                          radius: screenHeight3,
                          backgroundColor: AppColors.lightGray,
                          child: Icon(
                            Icons.call,
                            color: AppColors.contents,
                            size: screenHeight3,
                          ),
                        ),
                      ),
                      kWidth5,
                      GestureDetector(
                        onTap: () {
                          debugPrint('tap icon');
                        },
                        child: CircleAvatar(
                          radius: screenHeight3,
                          backgroundColor: AppColors.lightGray,
                          child: Icon(
                            Icons.chat,
                            color: AppColors.contents,
                            size: screenHeight3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
