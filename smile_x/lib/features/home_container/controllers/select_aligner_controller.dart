import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_x/core/utils/common_methods.dart';
import 'package:smile_x/core/widgets/custom_snackbar.dart';
import 'package:smile_x/services/api_client.dart';
import 'package:smile_x/services/api_manager.dart';

class SelectAlignerController extends GetxController {
  var selectedUpperAligner = ''.obs;
  var selectedLowerAligner = ''.obs;

  var upperAligners = <String>[].obs;
  var lowerAligners = <String>[].obs;
  var isLoading = true.obs;
  var isTrackingSaveLoading = false.obs;

  Rx<int> wearingStatus = 0.obs;
  var isTrackingUpdateLoading = false.obs;

  var currentUpperAligner = ''.obs;
  var currentLowerAligner = ''.obs;

  var formattedTotalWearingHours = "00.00".obs;
  var formattedNotWearingHours = "00.00".obs;
  // Flag to track whether an operation is in progress
  var isProcessing = false.obs;

  RxDouble wearingProgress = 0.0.obs;
  RxDouble notWearingProgress = 0.0.obs;

  DateTime? lastFetchTime; // Track the time of the last fetch

  final ApiManager apiManager = ApiManager(apiClient: ApiClient(Dio()));
  final CommonMethods commonMethods = CommonMethods();

  @override
  void onInit() {
    super.onInit();
    fetchAligners('upper');
    fetchAligners('lower');
    fetchCurrentWearingStatus(); // Initial fetch
    startAutoFetch(); // Start the periodic check
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Start the periodic check to fetch status if 1 minute has passed since last refresh
  void startAutoFetch() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      if (lastFetchTime != null) {
        Duration diff = DateTime.now().difference(lastFetchTime!);
        if (diff.inMinutes >= 1) {
          // Check if 1 minute has passed
          fetchCurrentWearingStatus();
        }
      } else {
        fetchCurrentWearingStatus(); // First time fetch if no last fetch time
      }
    });
  }

  Future<void> fetchAligners(String type) async {
    isLoading.value = true;
    debugPrint('Fetching treatment schedule for type: $type');

    try {
      int? patientId = await commonMethods.getPatientId();
      if (patientId == null) {
        debugPrint('Patient ID not found.');
        return;
      }

      final response = await apiManager.fetchAligners(patientId, type);

      if (response != null && response.statusCode == 200) {
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
      } else {
        debugPrint('Failed to fetch aligners or invalid response');
      }
    } catch (e) {
      debugPrint('Error fetching aligners: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // send selected aligners for tracking
  Future<void> saveAlignerTracking(String key) async {
    isTrackingSaveLoading(true);
    isProcessing.value = true;

    try {
      int? patientId = await commonMethods.getPatientId();
      if (patientId == null) {
        debugPrint('Patient ID not found.');
        showCustomSnackbar('Error', 'Patient ID not found.');
        return;
      }

      final upperLabel = key == "home"
          ? currentUpperAligner.value
          : selectedUpperAligner.value;
      final lowerLabel = key == "home"
          ? currentLowerAligner.value
          : selectedLowerAligner.value;
      if (key == "select") {
        if (upperLabel.isEmpty || lowerLabel.isEmpty) {
          debugPrint('Please select both upper and lower aligners.');
          showCustomSnackbar(
              'Alert', 'Please select both upper and lower aligners');
          return;
        }
      }

      final result =
          await apiManager.insertTracking(patientId, upperLabel, lowerLabel);

      if (result != null) {
        final statusCode = result.statusCode;
        debugPrint('Tracking save attempt - Status Code: $statusCode');

        if (statusCode == 200) {
          // Accessing data instead of body
          final responseBody = result.data;
          final String message =
              responseBody['message'] ?? 'Tracking saved successfully';

          debugPrint('Tracking saved successfully: $message');
          await fetchCurrentWearingStatus();
          key == "select" ? Get.back() : null;
          key == "select" ? showCustomSnackbar('Success', message) : null;
        } else {
          final responseBody = result.data;
          final String errorMessage =
              responseBody['message'] ?? 'Failed to aligner tracking';

          debugPrint('Failed to save tracking: $errorMessage');
          showCustomSnackbar('Error', errorMessage);
        }
      } else {
        debugPrint('Failed to save tracking.');
        showCustomSnackbar('Error', 'Failed to aligner tracking.');
      }
    } catch (e) {
      debugPrint('Error saving tracking: $e');
      showCustomSnackbar(
          'Error', 'Failed to aligner tracking due to an exception.');
    } finally {
      isTrackingSaveLoading(false);
      isProcessing.value = false;
    }
  }

  // Fetch the current wearing status of the aligners
  Future<void> fetchCurrentWearingStatus() async {
    try {
      int? patientId = await commonMethods.getPatientId();
      if (patientId == null) {
        debugPrint('Patient ID not found.');
        return;
      }

      final status = await apiManager.fetchWearingStatus(patientId);

      if (status != null && status['wearing_status'] != null) {
        wearingStatus.value = status['wearing_status'] ?? 0;
        String upperAligner = status['upper_aligner'] ?? '';
        String lowerAligner = status['lower_aligner'] ?? '';
        String totalWearingHours = status['totalwearinghours'] ?? '';
        String notWearingHours = status['notwearinghours'] ?? '';

        formattedTotalWearingHours.value = formatTime(totalWearingHours);
        formattedNotWearingHours.value = formatTime(notWearingHours);
        // storeWearingStatus(
        //     formattedTotalWearingHours.value, formattedNotWearingHours.value);

        calculateProgress(
            formattedTotalWearingHours.value, formattedNotWearingHours.value);

        currentUpperAligner.value = upperAligner;
        currentLowerAligner.value = lowerAligner;

        lastFetchTime =
            DateTime.now(); // Update last fetch time after a successful fetch

        debugPrint('Wearing Status: $wearingStatus');
        debugPrint('Upper Aligner: $upperAligner');
        debugPrint('Lower Aligner: $lowerAligner');
        debugPrint('Total Wearing Hours:  $formattedTotalWearingHours');
        debugPrint('Not Wearing Hours: $formattedNotWearingHours');
      } else {
        debugPrint('Error fetching wearing status');
      }
    } catch (e) {
      debugPrint('Error fetching wearing status: $e');
    }
  }

  // Convert time in "hh:mm" format to minutes
  int timeToMinutes(String time) {
    List<String> parts = time.split(":");
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    return (hours * 60) + minutes;
  }

  void calculateProgress(
      String totalWearingHours, String totalNotWearingHours) {
    // Convert the times to minutes
    int totalWearingMinutes = timeToMinutes(totalWearingHours);
    int totalNotWearingMinutes = timeToMinutes(totalNotWearingHours);

    // Total minutes in a day (24 hours = 1440 minutes)
    int totalMinutesInDay = 1440;

    // Calculate the progress for wearing and not wearing
    wearingProgress.value = ((totalWearingMinutes / totalMinutesInDay));
    notWearingProgress.value = ((totalNotWearingMinutes / totalMinutesInDay));

    // Print or update the progress for wearing and not wearing

    debugPrint("Wearing Progress: $wearingProgress%");
    debugPrint("Not Wearing Progress: $notWearingProgress%");
  }

  String formatTime(String time) {
    try {
      List<String> timeParts = time.split(':');
      if (timeParts.length == 3) {
        String hours = timeParts[0];
        String minutes = timeParts[1];
        return '$hours:$minutes'; // Return in the "HH:MM" format
      }
      return time; // Return the original string if it's not in the expected format
    } catch (e) {
      debugPrint('Error formatting time: $e');
      return time; // Return the original string in case of error
    }
  }

// not wearing api call
  Future<void> updateTracking() async {
    isTrackingUpdateLoading(true);
    isProcessing.value = true;

    try {
      int? patientId = await commonMethods.getPatientId();
      if (patientId == null) {
        debugPrint('Patient ID not found.');
        return;
      }

      final result = await apiManager.updateTracking(patientId);

      if (result != null) {
        final statusCode = result.statusCode;
        debugPrint('Tracking update attempt - Status Code: $statusCode');

        if (statusCode == 200) {
          final responseBody = result.data;
          final String message =
              responseBody['message'] ?? 'Tracking updated successfully';

          debugPrint('Tracking updated successfully: $message');
          await fetchCurrentWearingStatus();
          showCustomSnackbar("Success", message);
        } else {
          final responseBody = result.data;
          final String errorMessage =
              responseBody['message'] ?? 'Failed to update tracking';

          debugPrint('Failed to update tracking: $errorMessage');
          showCustomSnackbar("Error", errorMessage);
        }
      } else {
        debugPrint('Failed to update tracking.');
        showCustomSnackbar("Error", "Failed to update tracking.");
      }
    } catch (e) {
      debugPrint('Error updating tracking: $e');
      showCustomSnackbar(
          "Error", "Failed to update tracking due to an exception.");
    } finally {
      isTrackingUpdateLoading(false);
      isProcessing.value = false;
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
