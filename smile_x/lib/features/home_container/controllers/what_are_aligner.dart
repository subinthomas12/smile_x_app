import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/core/widgets/logo_image_widget.dart';

class WhatAreAligners extends StatelessWidget {
  const WhatAreAligners({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight2, horizontal: screenWidth2),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: screenHeight2,
                      backgroundColor: AppColors.lightGray,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.darkGray,
                          size: smallIconSize,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: LogoImageWidget(),
                      ),
                    ),
                  ],
                ),
                kHeight2,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'What are Aligners',
                      style: GoogleFonts.poppins(
                        fontSize: subTitleSize,
                        color: AppColors.contents,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    kHeight1,
                    Text(
                      "Invisible Teeth Aligners Are Custom Trays That Gradually Shift Teeth Into Position. They're A Comfortable, Removable Alternative To Braces, Effectively Treating Most Misalignments.",
                      style: GoogleFonts.poppins(
                        fontSize: contentSize,
                        fontWeight: FontWeight.w400,
                        color: AppColors.contents,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    kHeight2,
                    ListView.builder(
                        itemCount: 8,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Card(
                            surfaceTintColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: const BorderSide(
                                color: AppColors.lightGray,
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Visit a Dentist',
                                    style: GoogleFonts.poppins(
                                      fontSize: subTitleSize,
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  kHeight1,
                                  Text(
                                    'Visit a dentist near you for a Clinical examinations. He/She will evaluate your general oral health status, malocclusion, bite etc. X-rays and other diagnostic procedures will be conducted by him/her',
                                    style: GoogleFonts.poppins(
                                      fontSize: contentSize,
                                      color: AppColors.contents,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.justify,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
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
