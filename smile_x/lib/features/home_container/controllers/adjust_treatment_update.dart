import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:smile_x/core/widgets/common_header.dart';
import 'package:table_calendar/table_calendar.dart';

// Controller to manage TableCalendar state
class TableCalendarController extends GetxController {
  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;

  // When a day is selected, update both the focused and selected day
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
  }
}

class AdjustTreatmentUpdate extends StatelessWidget {
  AdjustTreatmentUpdate({super.key});

  final TableCalendarController controller = Get.put(TableCalendarController());

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
              const CommonHeader(title: 'U1'),
              kHeight2,
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth2, vertical: screenHeight1),
                decoration: BoxDecoration(
                  color: AppColors.brownShade,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.lightGray,
                      blurRadius: 8.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: Obx(
                  () => TableCalendar(
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
                        color: AppColors.primary,
                      ),
                      weekendTextStyle: GoogleFonts.poppins(
                        fontSize: contentSize,
                        color: AppColors.primary,
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: GoogleFonts.poppins(
                        fontSize: subTitleSize,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                      leftChevronIcon: Icon(
                        Icons.chevron_left,
                        color: AppColors.primary,
                        size: iconSize,
                      ),
                      rightChevronIcon: Icon(
                        Icons.chevron_right,
                        color: AppColors.primary,
                        size: iconSize,
                      ),
                    ),
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: GoogleFonts.poppins(
                        color: AppColors.primary,
                        fontSize: contentSize,
                      ),
                      weekendStyle: GoogleFonts.poppins(
                        color: AppColors.primary,
                        fontSize: contentSize,
                      ),
                    ),
                  ),
                ),
              ),
              kHeight2,
              // Use the updated selectedDay for displaying in the date picker
              Obx(() => _buildDatePicker(
                  'Start Date:', formatDate(controller.selectedDay.value))),
              Spacer(),
              Column(
                children: [
                  _buildBottomButtons(
                    label: 'Save',
                    buttonBgColor: AppColors.secondary,
                    textColor: AppColors.primary,
                    onPressed: () {
                      debugPrint('Submit button pressed');
                    },
                  ),
                  kHeight1,
                  _buildBottomButtons(
                    label: 'Cancel',
                    buttonBgColor: AppColors.primary,
                    textColor: AppColors.secondary,
                    onPressed: () {
                      debugPrint('Cancel button pressed');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDatePicker(String label, String selectedDate) {
  return Container(
    width: double.infinity,
    padding:
        EdgeInsets.symmetric(horizontal: screenWidth2, vertical: screenHeight2),
    decoration: BoxDecoration(
      color: AppColors.primary,
      border: Border.all(color: AppColors.lightGray, width: 1.0),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: const [
        BoxShadow(
          color: AppColors.lightGray,
          blurRadius: 4.0,
          offset: Offset(2, 2),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: contentSize,
            fontWeight: FontWeight.w400,
            color: AppColors.contents,
          ),
        ),
        Text(
          selectedDate,
          style: GoogleFonts.poppins(
            fontSize: contentSize,
            fontWeight: FontWeight.w400,
            color: AppColors.contents,
          ),
        ),
      ],
    ),
  );
}

Widget _buildBottomButtons(
    {required String label,
    required Color buttonBgColor,
    required Color textColor,
    required VoidCallback onPressed}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(
      horizontal: screenWidth2,
    ),
    decoration: BoxDecoration(
        color: buttonBgColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.lightGray,
            blurRadius: 4.0,
            offset: Offset(2, 2),
          )
        ]),
    child: TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: contentSize,
          color: textColor,
        ),
      ),
    ),
  );
}

// Function to format the date in 'dd-MMMM-yyyy' format
String formatDate(DateTime date) {
  return "${date.day.toString().padLeft(2, '0')}-${getMonthName(date.month)}-${date.year}";
}

// Function to get the month name
String getMonthName(int month) {
  const monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  return monthNames[month - 1];
}
