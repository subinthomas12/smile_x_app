import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_x/services/api_manager.dart';

class TreatmentController extends GetxController {
  final ApiManager apiManager;
  TreatmentController({required this.apiManager});
  RxList<Map<String, dynamic>> alignersList = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var initialStartDate = ''.obs;
  var retainerDays = ''.obs;
  var errorMessage = ''.obs; // For error messages

  // fetch patient_id from SharedPreferences
  Future<int?> getPatientId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? patientData = prefs.getString('patientData');
    if (patientData == null) {
      debugPrint('No patient data found.');
      return null;
    }

    Map<String, dynamic> patientMap = jsonDecode(patientData);
    int? patientId = patientMap['id'];
    debugPrint('Fetched patient_id: $patientId');
    return patientId;
  }

// Fetch treatment schedule based on type (upper/lower)
  Future<void> fetchTreatmentSchedule(String type) async {
    isLoading(true);
    try {
      int? patientId = await getPatientId();
      if (patientId == null) {
        debugPrint('No patient ID found.');
        return;
      }

      // Fetch treatment schedule
      var response = await apiManager.fetchTreatmentSchedule(patientId, type);

      // Check if the response is successful
      if (response.statusCode == 200) {
        initialStartDate.value = response.data['patient']['startdate'];
        retainerDays.value = response.data['retainer_days'];

        List<dynamic> schedules = response.data['patient']['scheduledetails'];

        List<Map<String, dynamic>> alignerList = [];
        for (var i = 0; i < schedules.length; i++) {
          var schedule = schedules[i];
          if (schedule['type'] == type) {
            String? dateString = schedule['sdate'];
            if (dateString != null) {
              DateTime currentDate = DateTime.parse(dateString);
              DateTime nextDate;

              if (i + 1 < schedules.length &&
                  schedules[i + 1]['sdate'] != null) {
                nextDate = DateTime.parse(schedules[i + 1]['sdate']);
              } else {
                nextDate = currentDate;
              }

              int daysDifference = nextDate.difference(currentDate).inDays;
              alignerList.add({
                'aligners': schedule['label'],
                'alignerDays': '$daysDifference days',
                'startDate': schedule['sdate'],
              });
            } else {
              debugPrint('Skipping schedule with null date.');
            }
          }
        }
        alignersList.value = alignerList;
        errorMessage.value = ''; // Clear any previous error
      }
    } catch (e) {
      errorMessage.value = 'Error: $e'; // Set error message if any error occurs
      // Clear data
    } finally {
      // Set loading to false after API call is complete
      isLoading.value = false;
    }
  }
}
