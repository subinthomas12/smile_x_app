import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:intl/intl.dart';
import 'package:smile_x/core/widgets/common_header.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final List<Map<String, dynamic>> notifications = [
    {
      "date": "2024-12-12",
      "icon": Icons.notifications,
      "title": "Aligner #1 Reminder",
      "content": "It's time to change your aligner.",
      "onTap": () {
        debugPrint("Aligner reminder tapped");
      },
    },
    {
      "date": "2024-12-12",
      "icon": Icons.notifications,
      "title": "Aligner #1 Reminder",
      "content": "It's time to change your aligner.",
      "onTap": () {
        debugPrint("Aligner reminder tapped");
      },
    },
    {
      "date": "2024-12-13",
      "icon": Icons.calendar_today,
      "title": "Consultation Reminder",
      "content": "Don't forget your consultation tomorrow at 3:00 PM.",
      "onTap": () {
        debugPrint("Consultation reminder tapped");
      },
    },
    {
      "date": "2024-12-15",
      "icon": Icons.access_alarm,
      "title": "Appointment Scheduled",
      "content": "You have an appointment with the dentist on December 15th.",
      "onTap": () {
        debugPrint("Appointment scheduled tapped");
      },
    },
    {
      "date": "2024-12-10",
      "icon": Icons.access_alarm,
      "title": "Appointment Scheduled",
      "content": "You have an appointment with the dentist on December 15th.",
      "onTap": () {
        debugPrint("Appointment scheduled tapped");
      },
    },
  ];

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    Map<String, List<Map<String, dynamic>>> groupedNotifications = {
      'Today': [],
      'Yesterday': [],
      'Tomorrow': [],
    };

    // method for formate date
    String formateDate(DateTime date) {
      return DateFormat('yyyy-MM-dd').format(date);
    }

    for (var notification in notifications) {
      DateTime notificationDate = DateTime.parse(notification['date']);
      String formattedNotificationDate = formateDate(notificationDate);

      if (formattedNotificationDate == formateDate(currentDate)) {
        groupedNotifications['Today']?.add(notification);
      } else if (formattedNotificationDate ==
          formateDate(currentDate.subtract(const Duration(days: 1)))) {
        groupedNotifications['Yesterday']?.add(notification);
      } else if (formattedNotificationDate ==
          formateDate(currentDate.add(const Duration(days: 1)))) {
        groupedNotifications['Tomorrow']?.add(notification);
      } else if (notificationDate.isBefore(currentDate)) {
        String pastDateKey = formateDate(notificationDate);
        if (groupedNotifications[pastDateKey] == null) {
          groupedNotifications[pastDateKey] = [];
        }
        groupedNotifications[pastDateKey]?.add(notification);
      } else if (notificationDate.isAfter(currentDate)) {
        String upcomingDateKey = formateDate(notificationDate);
        if (groupedNotifications[upcomingDateKey] == null) {
          groupedNotifications[upcomingDateKey] = [];
        }
        groupedNotifications[upcomingDateKey]?.add(notification);
      }
    }

    bool isEmpty = groupedNotifications.values
        .every((notificationsList) => notificationsList.isEmpty);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth4, vertical: screenHeight2),
            child: Column(
              children: [
                const CommonHeader(title: 'Notifications'),
                kHeight1,
                if (isEmpty)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: _buildEmptyState()),
                    ],
                  ),
                if (!isEmpty) ...[
                  if (groupedNotifications['Today']!.isNotEmpty)
                    _buildCategoryHeader('Today'),
                  ...groupedNotifications['Today']!.map((notification) {
                    return _buildNotificationCard(
                      notification['date'],
                      notification['icon'],
                      notification['title'],
                      notification['content'],
                      notification['onTap'],
                    );
                  }).toList(),
                  if (groupedNotifications['Yesterday']!.isNotEmpty)
                    _buildCategoryHeader('Yesterday'),
                  ...groupedNotifications['Yesterday']!.map((notification) {
                    return _buildNotificationCard(
                      notification['date'],
                      notification['icon'],
                      notification['title'],
                      notification['content'],
                      notification['onTap'],
                    );
                  }).toList(),
                  if (groupedNotifications['Tomorrow']!.isNotEmpty)
                    _buildCategoryHeader('Tomorrow'),
                  ...groupedNotifications['Tomorrow']!.map((notification) {
                    return _buildNotificationCard(
                      notification['date'],
                      notification['icon'],
                      notification['title'],
                      notification['content'],
                      notification['onTap'],
                    );
                  }).toList(),
                  ...groupedNotifications.keys
                      .where((key) =>
                          !['Today', 'Yesterday', 'Tomorrow'].contains(key) &&
                          DateTime.tryParse(key) != null)
                      .map((dateKey) {
                    return Column(
                      children: [
                        _buildCategoryHeader(dateKey),
                        ...groupedNotifications[dateKey]!.map((notification) {
                          return _buildNotificationCard(
                            notification['date'],
                            notification['icon'],
                            notification['title'],
                            notification['content'],
                            notification['onTap'],
                          );
                        }).toList(),
                      ],
                    );
                  }).toList(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildCategoryHeader(String title) {
  return Padding(
    padding: EdgeInsets.only(top: screenHeight2),
    child: Align(
      alignment: Alignment.center,
      child: Text(
        title,
        style: TextStyle(
          fontSize: smallFontSize,
          color: AppColors.contents,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Widget _buildNotificationCard(String date, IconData icon, String title,
    String content, VoidCallback? onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(),
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.lightGray, width: 1),
      ),
      elevation: 0,
      color: AppColors.lightGray,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(screenWidth3),
          child: Row(
            children: [
              CircleAvatar(
                radius: screenHeight3,
                backgroundColor: AppColors.primary,
                child: Icon(
                  icon,
                  color: AppColors.contents,
                  size: iconSize,
                ),
              ),
              SizedBox(width: screenWidth3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: subTitleSize,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      content,
                      style: GoogleFonts.poppins(
                        fontSize: contentSize,
                        color: AppColors.contents,
                        fontWeight: FontWeight.w400,
                      ),
                    )
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

Widget _buildEmptyState() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset('assets/images/bell.gif',
          width: screenHeight10, height: screenHeight10, fit: BoxFit.contain),
      Text(
        "You're all caught up",
        style: GoogleFonts.poppins(
            fontSize: screenHeight2,
            color: AppColors.secondary,
            fontWeight: FontWeight.w500),
      ),
      kHeight1,
      Text(
        "Come back later for Reminders, Teeth \n tips, Timing and Monitoring",
        style: GoogleFonts.poppins(
          fontSize: screenHeight2,
          color: AppColors.contents,
        ),
        textAlign: TextAlign.center,
      )
    ],
  );
}
