import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smile_x/core/utils/common_methods.dart';
import 'package:smile_x/core/widgets/custom_snackbar.dart';
import 'package:smile_x/services/api_manager.dart';

class TreatmentController extends GetxController {
  final ApiManager apiManager;

  TreatmentController({required this.apiManager});
  RxList<Map<String, dynamic>> alignersList = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var initialStartDate = ''.obs;
  var retainerDays = ''.obs;
  var errorMessage = ''.obs;

  final CommonMethods commonMethods = CommonMethods();

// Fetch treatment schedule based on type (upper/lower)
  Future<void> fetchTreatmentSchedule(String type) async {
    isLoading(true);
    try {
      int? patientId = await commonMethods.getPatientId();
      if (patientId == null) {
        debugPrint('No patient ID found.');
        return;
      }

      var response = await apiManager.fetchTreatmentSchedule(patientId, type);

      debugPrint('API Response: ${response.data}');

      if (response.statusCode == 200) {
        // initialStartDate.value = DateFormat('dd-MM-yyy')
        //     .format(DateTime.parse(response.data['patient']['startdate']));
        initialStartDate.value = response.data['patient']['startdate'];
        retainerDays.value = response.data['retainer_days'];

        List<dynamic> schedules = response.data['patient']['scheduledetails'];

        List<Map<String, dynamic>> alignerList = [];
        for (var i = 0; i < schedules.length; i++) {
          var schedule = schedules[i];
          if (schedule['type'] == type) {
            String? dateString = schedule['sdate'];
            String alignerDays = '';

            if (dateString != null) {
              DateTime currentDate = DateTime.parse(dateString);
              DateTime nextDate;

              // String formattedDate =
              //     DateFormat('dd-MM-yyyy').format(currentDate);

              // In the case of retainer
              if (schedule['label'] == 'Retainer') {
                alignerDays = response.data['retainer_days'];
              } else if (dateString != null) {
                DateTime currentDate = DateTime.parse(dateString);
                DateTime nextDate;

                if (i + 1 < schedules.length &&
                    schedules[i + 1]['sdate'] != null) {
                  nextDate = DateTime.parse(schedules[i + 1]['sdate']);
                } else {
                  nextDate = currentDate;
                }

                int daysDifference = nextDate.difference(currentDate).inDays;
                alignerDays = '$daysDifference days';
              }

              // Ensure aligner_id and alignerType are valid before adding them
              var alignerId = schedule['id'];
              var alignerType = schedule['type'];

              if (alignerId != null && alignerType != null) {
                var alignerData = {
                  'alignerId': alignerId,
                  'aligners': schedule['label'],
                  'alignerDays': alignerDays,
                  'startDate': schedule['sdate'],
                  'alignerType': alignerType,
                };

                debugPrint('Aligner Data to Add: $alignerData');

                alignerList.add(alignerData);
              }
            } else {
              debugPrint('Skipping schedule with null date.');
            }
          }
        }
        alignersList.value = alignerList;
        errorMessage.value = '';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // Method to update the schedule (start date)
  Future<void> updateSchedule(
    int alignerId,
    String alignerType,
    DateTime selectedDate,
  ) async {
    isLoading(true);

    try {
      int? patientId = await commonMethods.getPatientId();
      if (patientId == null) {
        debugPrint('No patient ID found.');
        return;
      }

      String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);

      var response = await apiManager.updateSchedule(
        patientId: patientId,
        scheduledetailsId: alignerId,
        startDate: formattedDate,
        type: alignerType,
      );

      if (response is Map<String, dynamic>) {
        if (response.containsKey('message')) {
          await Future.delayed(
              const Duration(seconds: 1)); // Delay for 1 second

          await fetchTreatmentSchedule(alignerType);

          String message = response['message'];
          debugPrint('Schedule updated successfully: $message');

          Get.back();
          // Show the Snackbar after the delay
          showCustomSnackbar('Success', message);
        } else {
          debugPrint('Unexpected response format: $response');
          showCustomSnackbar('Error', 'Unexpected response format');
        }
      } else if (response is String) {
        debugPrint('Failed to update schedule: $response');
        showCustomSnackbar('Error', response);
      } else {
        debugPrint('Unknown response format: $response');
        showCustomSnackbar('Error', 'Unknown response format');
      }
    } catch (e) {
      debugPrint('Error updating schedule: $e');
      showCustomSnackbar('Error', 'Error updating schedule');
    } finally {
      isLoading(false);
    }
  }
}
