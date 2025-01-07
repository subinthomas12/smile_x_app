import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/features/home_container/controllers/calendar_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderScreen extends StatelessWidget {
  const CalenderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CalendarController controller = Get.put(CalendarController());

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth5, vertical: screenHeight3),
          child: Column(
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
                child: Obx(() => TableCalendar(
                      firstDay: DateTime(2020, 1, 1),
                      lastDay: DateTime(2030, 12, 31),
                      focusedDay: controller.focusedDay.value,
                      selectedDayPredicate: (day) {
                        return isSameDay(controller.selectedDay.value, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
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
                          )),
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
                    )),
              ),
              kHeight2,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hours: 6hr 53min',
                    style: GoogleFonts.poppins(
                      fontSize: subTitleSize,
                      color: AppColors.contents,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Aligner #1',
                    style: GoogleFonts.poppins(
                      fontSize: subTitleSize,
                      color: AppColors.contents,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Divider(
                color: AppColors.contents,
                thickness: .5,
              ),
              kHeight1,
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _timeInfoDisplay(
                        icon: Icons.thumb_up,
                        time: '10:30 AM',
                        timeRangeStart: '11:00 AM',
                        timeRangeEnd: '12:00 PM  | Out 30min',
                      ),
                      kHeight2,
                      _timeInfoDisplay(
                        icon: Icons.thumb_up,
                        time: '10:30 AM',
                        timeRangeStart: '11:00 AM',
                        timeRangeEnd: '12:00 PM  | Out 3min',
                      ),
                      kHeight2,
                      _timeInfoDisplay(
                        icon: Icons.thumb_up,
                        time: '10:30 AM',
                        timeRangeStart: '11:00 AM',
                        timeRangeEnd: '12:00 PM | Out 20min',
                      ),
                      kHeight2,
                      _timeInfoDisplay(
                        icon: Icons.thumb_up,
                        time: '10:30 AM',
                        timeRangeStart: '11:00 AM',
                        timeRangeEnd: '12:00 PM | Out 1min',
                      ),
                      kHeight2,
                      _timeInfoDisplay(
                        icon: Icons.thumb_up,
                        time: '10:30 AM',
                        timeRangeStart: '11:00 AM',
                        timeRangeEnd: '12:00 PM | Out 30min',
                      ),
                      kHeight2,
                      _timeInfoDisplay(
                        icon: Icons.thumb_up,
                        time: '10:30 AM',
                        timeRangeStart: '11:00 AM',
                        timeRangeEnd: '12:00 PM | Out 30min',
                      ),
                      kHeight2,
                      _timeInfoDisplay(
                        icon: Icons.thumb_up,
                        time: '10:30 AM',
                        timeRangeStart: '11:00 AM',
                        timeRangeEnd: '12:00 PM | Out 30min',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: controller.navigateToReminderUpdate,
      //   backgroundColor: AppColors.secondary,
      //   child: Icon(
      //     Icons.add,
      //     color: AppColors.primary,
      //     size: screenHeight3,
      //   ),
      // ),
    );
  }

  Widget _timeInfoDisplay({
    required IconData icon,
    required String time,
    required String timeRangeStart,
    required String timeRangeEnd,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: smallIconSize,
              color: AppColors.contents.withOpacity(0.5),
            ),
            kWidth1,
            Text(
              time,
              style: GoogleFonts.poppins(
                fontSize: contentSize,
                color: AppColors.contents.withOpacity(0.5),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '$timeRangeStart - $timeRangeEnd',
            style: GoogleFonts.poppins(
              fontSize: contentSize,
              color: AppColors.contents,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
