import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/core/widgets/common_header.dart';
import 'package:smile_x/features/home_container/controllers/uploads_history_controller.dart';

class UploadsHistory extends StatelessWidget {
  UploadsHistory({super.key});

  final UploadsHistoryController uploadController =
      Get.put(UploadsHistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth5,
            vertical: screenHeight4,
          ),
          child: Column(
            children: [
              const CommonHeader(title: 'Uploads History'),
              kHeight(0.02),
              Expanded(
                child: Obx(
                  () {
                    return ListView.builder(
                      itemCount: uploadController.uploadsHistory.length,
                      itemBuilder: (context, index) {
                        final upload = uploadController.uploadsHistory[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: screenHeight2),
                          child: GestureDetector(
                            onTap: () {
                              uploadController
                                  .navigateToUploadsHistoryDetailsScreen();
                            },
                            child: Card(
                              elevation: 5,
                              shadowColor: AppColors.greyCard.withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: AppColors.lightGray,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth4,
                                  vertical: screenHeight2,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        // Image Thumbnail

                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                upload['alignerLabel']!,
                                                style: GoogleFonts.poppins(
                                                  fontSize: mainTitleSize,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.secondary,
                                                ),
                                              ),
                                              kHeight(0.01),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Upload date & time:',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: contentSize,
                                                      color:
                                                          const Color.fromARGB(
                                                        255,
                                                        196,
                                                        194,
                                                        194,
                                                      ),
                                                    ),
                                                  ),
                                                  kHeight(0.005),
                                                  Text(
                                                    '${upload['date']} at ${upload['time']}',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: subTitleSize,
                                                      color: AppColors.contents,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        kWidth(0.02),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            upload['imageUrl']!,
                                            height: screenHeight9,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                    kHeight(0.01),
                                    Text(
                                      'Comment:',
                                      style: GoogleFonts.poppins(
                                        fontSize: contentSize,
                                        color: const Color.fromARGB(
                                            255, 196, 194, 194),
                                      ),
                                    ),
                                    kHeight(0.005),
                                    Text(
                                      upload['comment']!,
                                      style: GoogleFonts.poppins(
                                        fontSize: contentSize,
                                        color: AppColors.contents,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
