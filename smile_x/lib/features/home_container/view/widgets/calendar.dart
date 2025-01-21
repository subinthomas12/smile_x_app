import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/features/home_container/controllers/calendar_controller.dart';
import 'package:smile_x/features/home_container/controllers/home_controller.dart';
import 'package:smile_x/services/api_client.dart';
import 'package:smile_x/services/api_manager.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatelessWidget {
  CalenderScreen({super.key});
  final NavigationController _navController = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    final CalendarController controller = Get.put(CalendarController(
        apiManager: ApiManager(apiClient: ApiClient(Dio()))));

    // Function to format DateTime to string
    String formatDate(DateTime date) {
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }

    return WillPopScope(
      onWillPop: () async {
        _navController.selectedIndex.value = 0;
        // This will navigate to the "/home" route when the back button is pressed
        Get.offNamed("/home");
        return false; // Returning false so the default back navigation is prevented
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth5, vertical: screenHeight5),
            child: Obx(() {
              return Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth2, vertical: screenHeight1),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 252, 252, 151),
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.lightGray,
                              blurRadius: 8.0,
                              spreadRadius: 2.0,
                            ),
                          ],
                        ),
                        child: TableCalendar(
                          firstDay: DateTime(2020, 1, 1),
                          lastDay: DateTime(2030, 12, 31),
                          focusedDay: controller.focusedDay.value,
                          selectedDayPredicate: (day) {
                            return isSameDay(controller.selectedDay.value, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            debugPrint([selectedDay, focusedDay].toString());
                            controller.onDaySelected(selectedDay, focusedDay);
                          },
                          calendarStyle: CalendarStyle(
                            todayDecoration: const BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                            ),
                            selectedDecoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                            defaultTextStyle: GoogleFonts.poppins(
                              fontSize: contentSize,
                              color: Colors.black,
                            ),
                            weekendTextStyle: GoogleFonts.poppins(
                              fontSize: contentSize,
                              color: Colors.red,
                            ),
                          ),
                          headerStyle: HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                            titleTextStyle: GoogleFonts.poppins(
                              fontSize: subTitleSize,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            leftChevronIcon: Icon(
                              Icons.chevron_left,
                              color: Colors.black,
                              size: iconSize,
                            ),
                            rightChevronIcon: Icon(
                              Icons.chevron_right,
                              color: Colors.black,
                              size: iconSize,
                            ),
                          ),
                        ),
                      ),
                      kHeight(0.02),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Obx(() {
                                final isCalendarLoading =
                                    controller.isCalendarLoading.value;
                                final dailyAlignerData =
                                    controller.dailyAlignerData.value;

                                if (isCalendarLoading) {
                                  return _loadingCard();
                                }

                                if (dailyAlignerData.isEmpty) {
                                  return _noAlignerCard();
                                }

                                return Column(
                                  children: [
                                    if (dailyAlignerData[
                                            'wearinghours_upper'] !=
                                        '0:00:00')
                                      _alignerContainer(
                                        title: 'Upper Aligner',
                                        alignerData: dailyAlignerData,
                                        isUpper: true,
                                      ),
                                    kHeight(0.02),
                                    if (dailyAlignerData[
                                            'wearinghours_lower'] !=
                                        '0:00:00')
                                      _alignerContainer(
                                        title: 'Lower Aligner',
                                        alignerData: dailyAlignerData,
                                        isUpper: false,
                                      ),
                                    if (dailyAlignerData[
                                                'wearinghours_upper'] ==
                                            '0:00:00' &&
                                        dailyAlignerData[
                                                'wearinghours_lower'] ==
                                            '0:00:00')
                                      _noAlignerCard(),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _loadingCard() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: screenHeight2, horizontal: screenWidth4),
      margin: EdgeInsets.symmetric(vertical: screenHeight05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: CupertinoActivityIndicator(
          color: AppColors.secondary,
        ),
      ),
    );
  }

  Widget _alignerContainer({
    required String title,
    required dynamic alignerData,
    required bool isUpper,
  }) {
    String wearTime = isUpper
        ? alignerData['wearinghours_upper']
        : alignerData['wearinghours_lower'];
    String nonWearTime = isUpper
        ? alignerData['notwearinghours_upper']
        : alignerData['notwearinghours_lower'];

    return Container(
      padding: EdgeInsets.symmetric(
          vertical: screenHeight2, horizontal: screenWidth4),
      margin: EdgeInsets.symmetric(vertical: screenHeight05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.lightGray,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: subTitleSize,
              fontWeight: FontWeight.w400,
              color: AppColors.secondary,
            ),
          ),
          kHeight(0.01),
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: AppColors.contents,
                size: smallIconSize,
              ),
              kWidth(0.02),
              Text(
                'Wear time: $wearTime hours',
                style: GoogleFonts.poppins(
                  fontSize: contentSize,
                  color: AppColors.contents,
                ),
              ),
            ],
          ),
          kHeight(0.01),
          Row(
            children: [
              Icon(
                Icons.access_time,
                color: AppColors.contents,
                size: smallIconSize,
              ),
              kWidth(0.02),
              Text(
                'Non-wear time: $nonWearTime hours',
                style: GoogleFonts.poppins(
                  fontSize: contentSize,
                  color: AppColors.contents,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _noAlignerCard() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: screenHeight1, horizontal: screenWidth4),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.lightGray,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
            horizontal: screenWidth1, vertical: screenHeight1),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'No Aligner Worn',
              style: GoogleFonts.poppins(
                fontSize: subTitleSize,
                fontWeight: FontWeight.w400,
                color: AppColors.secondary,
              ),
            ),
            kHeight(0.01)
          ],
        ),
        subtitle: Text(
          'You did not wear the aligner on this day.',
          style: GoogleFonts.poppins(
            fontSize: contentSize,
            fontWeight: FontWeight.w400,
            color: AppColors.contents,
          ),
        ),
      ),
    );
  }
}
