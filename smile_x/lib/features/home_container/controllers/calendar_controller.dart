import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smile_x/core/utils/common_methods.dart';
import 'package:smile_x/services/api_manager.dart';

class CalendarController extends GetxController {
  final ApiManager apiManager;
  CalendarController({required this.apiManager});

  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;

  final CommonMethods commonMethods = CommonMethods();

  RxMap<String, dynamic> dailyAlignerData = <String, dynamic>{}.obs;
  RxBool isCalendarLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    DateTime now = DateTime.now();
    DateTime focusedDay = now;
    DateTime selectedDay = now;
    onDaySelected(selectedDay, focusedDay);
  }

// Method to fetch daily aligner data based on selected day
  Future<void> fetchDailyAlignerData() async {
    try {
      isCalendarLoading.value = true;

      int? patientId = await commonMethods.getPatientId();
      if (patientId == null) {
        debugPrint('No patient ID found.');
        isCalendarLoading.value = false;
        return;
      }

      String selectedDate = DateFormat('yyyy-MM-dd').format(selectedDay.value);

      var response =
          await apiManager.fetchDailyAlignerData(patientId, selectedDate);

      if (response == null) {
        debugPrint('Failed to fetch daily aligner data.');
        // showCustomSnackbar('Error', 'Failed to fetch daily aligner data.');
        return;
      }

      if (response.statusCode == 200) {
        String message = response.data['message'] ?? '';

        if (message == "Tracking found.") {
          dailyAlignerData.value = {
            'wearinghours_upper':
                response.data['wearinghours_upper'] ?? '0:00:00',
            'notwearinghours_upper':
                response.data['notwearinghours_upper'] ?? '0:00:00',
            'wearinghours_lower':
                response.data['wearinghours_lower'] ?? '0:00:00',
            'notwearinghours_lower':
                response.data['notwearinghours_lower'] ?? '0:00:00',
          };
          debugPrint('Daily aligner data: ${dailyAlignerData.value}');
        } else if (message == "Tracking not found for the patient.") {
          dailyAlignerData.value = {};
          debugPrint('No aligner data found for the selected date.');
        } else {
          debugPrint('Unexpected message: $message');
        }
      } else {
        debugPrint('Failed to fetch aligner data: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching daily aligner data: $e');
    } finally {
      isCalendarLoading.value = false;
    }
  }

// Method to handle day selection and fetch aligner data for that day
  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
    fetchDailyAlignerData();
  }
}
