import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/core/widgets/common_header.dart';
import 'select_aligner_controller.dart';

class SelectAligner extends StatelessWidget {
  const SelectAligner({super.key});

  @override
  Widget build(BuildContext context) {
    final SelectAlignerController controller =
        Get.put(SelectAlignerController());

    final TextEditingController upperAlignerController =
        TextEditingController();
    final TextEditingController lowerAlignerController =
        TextEditingController();

    controller.selectedUpperAligner.listen((value) {
      upperAlignerController.text = value;
    });
    controller.selectedLowerAligner.listen((value) {
      lowerAlignerController.text = value;
    });

    Future.microtask(() => controller.fetchAligners('upper'));
    Future.microtask(() => controller.fetchAligners('lower'));

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
              const CommonHeader(title: 'Choose your Aligners'),
              kHeight(0.02),
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(width: 2, color: AppColors.secondary),
                      ),
                      child: TabBar(
                        dividerColor: Colors.transparent,
                        labelColor: AppColors.secondary,
                        unselectedLabelColor: AppColors.contents,
                        indicatorColor: AppColors.secondary,
                        indicatorWeight: 4,
                        indicatorPadding:
                            EdgeInsets.symmetric(horizontal: screenWidth2),
                        labelStyle: GoogleFonts.poppins(
                          fontSize: contentSize,
                          fontWeight: FontWeight.w500,
                        ),
                        unselectedLabelStyle: GoogleFonts.poppins(
                          fontSize: contentSize,
                          fontWeight: FontWeight.normal,
                        ),
                        tabs: const [
                          Tab(text: 'Upper Aligners'),
                          Tab(text: 'Lower Aligners'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .5,
                      child: Obx(
                        () {
                          if (controller.isLoading.value) {
                            return const Center(
                              child: CupertinoActivityIndicator(
                                color: AppColors.secondary,
                                radius: 15,
                              ),
                            );
                          } else {
                            return TabBarView(
                              children: [
                                AlignersList(
                                  aligners: controller.upperAligners,
                                  onSelectAligner:
                                      controller.selectUpperAligner,
                                  selectedAligner:
                                      controller.selectedUpperAligner,
                                  currentAligner:
                                      controller.currentUpperAligner.value,
                                ),
                                AlignersList(
                                  aligners: controller.lowerAligners,
                                  onSelectAligner:
                                      controller.selectLowerAligner,
                                  selectedAligner:
                                      controller.selectedLowerAligner,
                                  currentAligner:
                                      controller.currentLowerAligner.value,
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Current Selected Aligners',
                style: TextStyle(
                  fontSize: contentSize,
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.start,
              ),
              buildSelectAlignerField(
                controller: upperAlignerController,
                labelText: controller.currentUpperAligner.value.isEmpty
                    ? 'Select Upper Aligner'
                    : controller.currentUpperAligner.value,
              ),
              buildSelectAlignerField(
                controller: lowerAlignerController,
                labelText: controller.currentLowerAligner.value.isEmpty
                    ? 'Select Lower Aligner'
                    : controller.currentLowerAligner.value,
              ),
              SizedBox(
                width: double.infinity,
                child: Obx(() {
                  return ElevatedButton(
                    onPressed: () async {
                      await controller.saveAlignerTracking("select");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: screenHeight2),
                    ),
                    child: controller.isTrackingSaveLoading.value
                        ? const CupertinoActivityIndicator(
                            color: AppColors.primary,
                          )
                        : Text(
                            'Save',
                            style: GoogleFonts.poppins(
                              fontSize: contentSize,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                          ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class AlignersList extends StatelessWidget {
//   final List<String> aligners;
//   final Function(String) onSelectAligner;
//   final RxString selectedAligner;

//   const AlignersList({
//     super.key,
//     required this.aligners,
//     required this.onSelectAligner,
//     required this.selectedAligner,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: screenWidth1, vertical: screenHeight * 0.005),
//       child: ListView.builder(
//         itemCount: aligners.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               onSelectAligner(aligners[index]);
//             },
//             child: Obx(
//               () => Container(
//                 margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
//                 padding: EdgeInsets.symmetric(
//                     vertical: screenHeight1, horizontal: screenWidth2),
//                 decoration: BoxDecoration(
//                   color: selectedAligner.value == aligners[index]
//                       ? AppColors.secondary
//                       : AppColors.lightGray.withOpacity(0.7),
//                   borderRadius: BorderRadius.circular(10.0),
//                   border: Border.all(
//                     color: selectedAligner.value == aligners[index]
//                         ? AppColors.secondary
//                         : AppColors.lightGray,
//                     width: 1.5,
//                   ),
//                 ),
//                 child: Text(
//                   aligners[index],
//                   style: GoogleFonts.poppins(
//                     fontSize: contentSize,
//                     color: selectedAligner.value == aligners[index]
//                         ? AppColors.primary
//                         : AppColors.contents.withOpacity(0.7),
//                     fontWeight: selectedAligner.value == aligners[index]
//                         ? FontWeight.w500
//                         : FontWeight.normal,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class AlignersList extends StatelessWidget {
  final List<String> aligners;
  final Function(String) onSelectAligner;
  final RxString selectedAligner;
  final String currentAligner;

  const AlignersList({
    super.key,
    required this.aligners,
    required this.onSelectAligner,
    required this.selectedAligner,
    required this.currentAligner,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth1,
        vertical: screenHeight * 0.005,
      ),
      child: Obx(() {
        return ListView.builder(
            itemCount: aligners.length,
            itemBuilder: (context, index) {
              final isCurrent = currentAligner == aligners[index];

              return GestureDetector(
                onTap: () {
                  onSelectAligner(aligners[index]);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: screenHeight * 0.005),
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight1,
                    horizontal: screenWidth2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightGray.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: AppColors.lightGray,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      if (isCurrent)
                        Icon(
                          Icons.check_circle,
                          color: AppColors.secondary,
                          size: smallIconSize,
                        ),
                      kWidth(0.02),
                      Text(
                        aligners[index],
                        style: GoogleFonts.poppins(
                          fontSize: contentSize,
                          color: AppColors.contents.withOpacity(0.7),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}

Widget buildSelectAlignerField({
  required TextEditingController controller,
  required String labelText,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: labelText,
        // labelText: labelText,
        labelStyle: GoogleFonts.poppins(
            fontSize: smallFontSize, color: AppColors.contents),
        filled: true,
        fillColor: AppColors.lightGray.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.secondary,
            width: 1,
          ),
        ),
      ),
      enabled: false,
    ),
  );
}
