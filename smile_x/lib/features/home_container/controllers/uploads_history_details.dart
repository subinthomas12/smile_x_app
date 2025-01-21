import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/core/widgets/common_header.dart';

class UploadsHistoryDetails extends StatelessWidget {
  // Dummy data for demonstration purposes
  final Map<String, String> upload = {
    "alignerLabel": "Aligner 1",
    "date": "2025-01-18",
    "time": "12:30 PM",
    "comment":
        "This is a dummy comment for testing purposes. The aligner looks good and the adjustment seems perfect. Please proceed with the next steps.",
    "imageUrl":
        "https://i.postimg.cc/6QV9VRdb/360-F-638561458-g-Yp-OX6-IEUOw-Woaa6-Kk-Sg-Qju-F8-DW8-QL7-C.jpg"
  };

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CommonHeader(title: "Uploads History Details"),
              kHeight(0.02),
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  upload['imageUrl']!,
                  height: screenHeight * 0.3,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              kHeight(0.02),
              // Aligner Label, Date & Time
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Upload date & time:',
                    style: GoogleFonts.poppins(
                      fontSize: contentSize,
                      color: const Color.fromARGB(
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
                      fontWeight: FontWeight.w400,
                      color: AppColors.contents,
                    ),
                  ),
                ],
              ),
              kHeight(0.03),
              // Comment Section
              Text(
                'Comment:',
                style: GoogleFonts.poppins(
                  fontSize: contentSize,
                  color: const Color.fromARGB(255, 196, 194, 194),
                ),
              ),
              kHeight(0.005),
              Text(
                upload['comment']!,
                style: GoogleFonts.poppins(
                  fontSize: contentSize,
                  color: AppColors.contents,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
