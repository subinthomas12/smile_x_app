import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/core/widgets/common_header.dart';
import 'package:smile_x/features/home_container/controllers/profile_screen_controller.dart';
import 'package:smile_x/features/home_container/controllers/treatment_controller.dart';
import 'package:intl/intl.dart';
import 'package:smile_x/services/api_client.dart';
import 'package:smile_x/services/api_manager.dart';

class AdjustTreatment extends StatefulWidget {
  AdjustTreatment({super.key});

  @override
  _AdjustTreatmentState createState() => _AdjustTreatmentState();
}

class _AdjustTreatmentState extends State<AdjustTreatment>
    with SingleTickerProviderStateMixin {
  final ProfileScreenController profileController =
      Get.put(ProfileScreenController());

  final TreatmentController treatmentController = Get.put(
      TreatmentController(apiManager: ApiManager(apiClient: ApiClient(Dio()))));

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Initially fetch schedule for upper
    treatmentController.fetchTreatmentSchedule('upper');

    _tabController.addListener(() {
      if (_tabController.index == 0) {
        treatmentController.fetchTreatmentSchedule('upper');
      } else if (_tabController.index == 1) {
        treatmentController.fetchTreatmentSchedule('lower');
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth2, vertical: screenHeight2),
          child: Column(
            children: [
              const CommonHeader(title: 'Treatment Schedule'),
              kHeight2,
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    profileController.navigateToAdjustTreatmentStartDate();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Obx(() {
                    String formattedDate = '';
                    if (treatmentController.initialStartDate.value.isNotEmpty) {
                      DateTime startDate = DateTime.parse(
                          treatmentController.initialStartDate.value);
                      formattedDate =
                          DateFormat('dd-MM-yyyy').format(startDate);
                    }
                    return RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.edit,
                              color: AppColors.primary,
                              size: smallIconSize,
                            ),
                            alignment: PlaceholderAlignment.middle,
                          ),
                          TextSpan(
                            text: ' Start: ',
                            style: GoogleFonts.poppins(
                              color: AppColors.primary,
                              fontSize: smallFontSize,
                            ),
                          ),
                          TextSpan(
                            text: formattedDate,
                            style: GoogleFonts.poppins(
                              color: AppColors.primary,
                              fontSize: smallFontSize,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              kHeight1,
              Container(
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 2, color: AppColors.secondary)),
                child: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      text: "Upper Aligners",
                    ),
                    Tab(
                      text: "Lower Aligners",
                    ),
                  ],
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
                ),
              ),
              kHeight1,
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Upper Aligners Tab
                    Obx(() {
                      if (treatmentController.isLoading.value) {
                        return const Center(
                          child: CupertinoActivityIndicator(
                            color: AppColors.secondary,
                            radius: 15,
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: treatmentController.alignersList.length,
                          itemBuilder: (context, index) {
                            var item = treatmentController.alignersList[index];

                            return _buildAlignerListingCards(
                                item['aligners'],
                                item['alignerDays'],
                                item['startDate'],
                                profileController);
                          },
                        );
                      }
                    }),

                    // Lower Aligners Tab
                    Obx(() {
                      if (treatmentController.isLoading.value) {
                        return const Center(
                          child: CupertinoActivityIndicator(
                            color: AppColors.secondary,
                            radius: 15,
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: treatmentController.alignersList.length,
                          itemBuilder: (context, index) {
                            var item = treatmentController.alignersList[index];
                            return _buildAlignerListingCards(
                                item['aligners'],
                                item['alignerDays'],
                                item['startDate'],
                                profileController);
                          },
                        );
                      }
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlignerListingCards(String aligners, String alignerDays,
      String startDate, ProfileScreenController profileController) {
    IconData editIcon = Icons.edit;
    String dateTitle = 'Start Date';

    return Card(
      color: AppColors.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth2, vertical: screenHeight2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  aligners,
                  style: GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontSize: contentSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                kHeight1,
                Text(
                  alignerDays,
                  style: GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontSize: contentSize,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  dateTitle,
                  style: GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontSize: contentSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                kHeight1,
                Text(
                  startDate,
                  style: GoogleFonts.poppins(
                    color: AppColors.primary,
                    fontSize: contentSize,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            IconButton(
                onPressed: () {
                  profileController.navigateToTreatmentUpdate();
                },
                icon: Icon(
                  editIcon,
                  color: AppColors.primary,
                  size: smallIconSize,
                ))
          ],
        ),
      ),
    );
  }
}
