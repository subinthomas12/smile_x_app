import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_x/core/utils/core.dart';

class SelectAlignerController extends GetxController {
  var selectedUpperAligner = ''.obs;
  var selectedLowerAligner = ''.obs;

  var upperAligners = <String>[];
  var lowerAligners = <String>[];
  var isLoading = true.obs;

  final Dio _dio = Dio();

  // Function to fetch patient_id
  Future<int?> getPatientId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? patientData = prefs.getString('patientData');
    if (patientData == null) {
      debugPrint('No patient_id found.');
      return null;
    }

    Map<String, dynamic> patientMap = jsonDecode(patientData);
    int? patientId = patientMap['id'];
    debugPrint('Fetched patientId: $patientId');
    return patientId;
  }

  Future<void> fetchAligners(String type) async {
    isLoading.value = true;
    debugPrint('Fetching treatment schedule for type: $type');

    try {
      int? patientId = await getPatientId();
      if (patientId == null) {
        debugPrint('Patient ID not found.');
        return;
      }

      final String apiUrl =
          '$baseUrl/schedule?patient_id=$patientId&type=$type';
      debugPrint('Final API URL: $apiUrl');

      await Future.delayed(Duration(seconds: 2));

      var response = await _dio.get(apiUrl);

      // Print the entire response for debugging
      debugPrint('Response status code: ${response.statusCode}');
      debugPrint('Response data: ${response.data}');

      if (response.statusCode == 200) {
        List<String> alignerList = [];
        var schedules = response.data['patient']['scheduledetails'] ?? [];

        for (var schedule in schedules) {
          if (schedule['type'] == type) {
            alignerList.add(schedule['label']);
          }
        }

        if (type == 'upper') {
          upperAligners.assignAll(alignerList);
        } else {
          lowerAligners.assignAll(alignerList);
        }
        update(); // Trigger UI update
      } else {
        debugPrint('Failed to load aligners: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint('Connection Timeout');
      } else if (e.type == DioExceptionType.sendTimeout) {
        debugPrint('Send Timeout');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        debugPrint('Receive Timeout');
      } else if (e.type == DioExceptionType.badResponse) {
        debugPrint('Error: ${e.response?.statusCode}');
      } else {
        debugPrint('Unexpected error: ${e.message}');
      }
    } finally {
      isLoading.value = false;
    }
  }

  // Function to select an upper aligner
  void selectUpperAligner(String aligner) {
    selectedUpperAligner.value = aligner;
  }

  // Function to select a lower aligner
  void selectLowerAligner(String aligner) {
    selectedLowerAligner.value = aligner;
  }
}
