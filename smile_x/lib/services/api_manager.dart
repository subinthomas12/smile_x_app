import 'package:flutter/foundation.dart';
import 'package:smile_x/services/api_client.dart';
import 'package:dio/dio.dart';

import '../core/widgets/custom_snackbar.dart';

class ApiManager {
  final ApiClient apiClient;
  ApiManager({required this.apiClient});

  static String baseUrl =
      'https://liveweare.com/newdemo/smileexcelnew/api/patientapp';

  // Authentication
  Future<dynamic> loginUser(String username, String password) async {
    try {
      final formData = FormData.fromMap({
        'username': username,
        'password': password,
      });

      final response = await apiClient.request(
        '$baseUrl/login',
        formData,
      );

      // Check if response is null before accessing statusCode
      if (response != null) {
        if (response.statusCode == 200) {
          // Successful login
          debugPrint('Response: ${response}');
          // Process and return relevant information
          final message = response.data['message'];
          return response ??
              'Login successful'; // You can return a custom message
        } else if (response.statusCode == 401) {
          debugPrint('Unauthorized: ${response.data['message']}');
          showCustomSnackbar("Unauthorized", response.data['message']);
        } else {
          debugPrint('Error Response: ${response.statusCode}');
          return 'Failed to login, please try again later.';
        }
      } else {
        return 'No response from the server';
      }
    } catch (e) {
      debugPrint('Error for login: $e');
      return 'Error for login: $e';
    }
  }

  // Schedule treatment
  Future<dynamic> fetchTreatmentSchedule(int patientId, String type) async {
    try {
      final formData = FormData.fromMap({
        'patient_id': patientId,
        'type': type,
      });

      final response = await apiClient.request(
        '$baseUrl/schedule',
        formData,
      );

      if (response != null && response.statusCode == 200) {
        return response;
      } else {
        return 'Failed to fetch treatment schedule';
      }
    } catch (e) {
      debugPrint('Error fetching treatment schedule: $e');
      return 'Error fetching treatment schedule';
    }
  }

  // List aligners for selection
  Future<dynamic> fetchAligners(int patientId, String type) async {
    try {
      final formData = FormData.fromMap({
        'patient_id': patientId,
        'type': type,
      });

      final response = await apiClient.request(
        '$baseUrl/schedule',
        formData,
      );

      if (response != null && response.statusCode == 200) {
        return response;
      } else {
        return 'Failed to fetch Aligners';
      }
    } catch (e) {
      debugPrint('Error fetching Aligners: $e');
      return 'Error fetching Aligners';
    }
  }
}
