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
                vertical: screenHeight4, horizontal: screenWidth5),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: screenHeight3,
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
                    kWidth(0.05),
                    // ignore: prefer_const_constructors
                    LogoImageWidget(),
                  ],
                ),
                kHeight(0.04),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What are Aligners',
                      style: GoogleFonts.poppins(
                        fontSize: subTitleSize,
                        color: AppColors.contents,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    kHeight(0.01),
                    Text(
                      "Invisible Teeth Aligners Are Custom Trays That Gradually Shift Teeth Into Position. They're A Comfortable, Removable Alternative To Braces, Effectively Treating Most Misalignments.",
                      style: GoogleFonts.poppins(
                        fontSize: contentSize,
                        fontWeight: FontWeight.w400,
                        color: AppColors.contents,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    kHeight(0.02),
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
                                      fontSize: contentSize,
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  kHeight(0.01),
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
