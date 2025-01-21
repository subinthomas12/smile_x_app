import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
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

      if (response != null) {
        if (response.statusCode == 200) {
          debugPrint('Response: $response');
          final message = response.data['message'];
          return response ?? 'Login successful';
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

  // Update Schedule
  Future<dynamic> updateSchedule({
    required int patientId,
    required int scheduledetailsId,
    required String startDate,
    required String type,
  }) async {
    try {
      final formData = FormData.fromMap({
        'patient_id': patientId,
        'scheduledetails_id': scheduledetailsId,
        'startdate': startDate,
        'type': type,
      });

      final response = await apiClient.request(
        '$baseUrl/scheduleupdate',
        formData,
      );
      if (response != null && response.statusCode == 200) {
        return response.data;
      } else {
        return 'Failed to update schedule';
      }
    } catch (e) {
      debugPrint('Error updating schedule: $e');
      return 'Error updating schedule';
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

  // send selected aligners for tracking
  Future<dynamic> insertTracking(
      int patientId, String upperLabel, String lowerLabel) async {
    try {
      final formData = FormData.fromMap({
        'patient_id': patientId,
        'upperlabel': upperLabel,
        'lowerlabel': lowerLabel,
      });

      final response = await apiClient.request(
        '$baseUrl/insert_tracking',
        formData,
        method: 'POST',
      );

      if (response != null && response.statusCode == 200) {
        debugPrint('Tracking saved successfully.');
        return response;
      } else {
        debugPrint('Failed to save tracking: ${response?.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error saving tracking: $e');
      return null;
    }
  }

  // Method to fetch current wearing status of the aligners
  Future<Map<String, dynamic>?> fetchWearingStatus(int patientId) async {
    try {
      final formData = FormData.fromMap({
        'patient_id': patientId,
      });

      final response = await apiClient.request(
        '$baseUrl/wearing_status',
        formData,
        method: 'POST',
      );

      if (response != null && response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        debugPrint('Failed to fetch wearing status');
        return null;
      }
    } catch (e) {
      debugPrint('Error fetching wearing status: $e');
      return null;
    }
  }

  // Method to fetch update tracking
  Future<dynamic> updateTracking(int patientId) async {
    try {
      final formData = FormData.fromMap({'patient_id': patientId});

      final response = await apiClient.request(
        '$baseUrl/update_tracking',
        formData,
        method: 'POST',
      );

      if (response != null && response.statusCode == 200) {
        debugPrint('Tracking updated successfully.');
        return response;
      } else {
        debugPrint('Failed to update tracking: ${response?.statusCode}');
        return null;
      }
    } catch (e) {
      debugPrint('Error updating tracking: $e');
      return null;
    }
  }

  // Method to fetch aligner daily data based on date
  Future<Response?> fetchDailyAlignerData(
      int patientId, String selectedDate) async {
    try {
      final formData = FormData.fromMap({
        'patient_id': patientId,
        'selected_date': selectedDate,
      });

      final response = await apiClient.request(
        '$baseUrl/dailyhours_tracking',
        formData,
      );

      // Log the API Response for debugging purposes
      debugPrint('API Response: ${response?.data}');
      debugPrint('API Status Code: ${response?.statusCode}');

      if (response != null && response.statusCode == 200) {
        return response;
      } else {
        debugPrint(
            'Error: Failed to fetch data. Status Code: ${response?.statusCode}');
        debugPrint('Error Message: ${response?.statusMessage}');
        return null;
      }
    } catch (e) {
      debugPrint('Error in API request: $e');
      return null;
    }
  }

// Image upload
  Future<Map<String, dynamic>?> uploadImage(
      int patientId, File imageFile) async {
    try {
      String extension = imageFile.path.split('.').last;

      String fileName =
          '${patientId}_progress_photo_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.$extension';

      if (!await imageFile.exists()) {
        debugPrint("Image file does not exist at ${imageFile.path}");
        return {
          'statusCode': 404,
          'message': 'Image file not found.',
          'photo': '',
        };
      }

      final imageFilePart =
          await MultipartFile.fromFile(imageFile.path, filename: fileName);

      final formData = FormData.fromMap({
        'patient_id': patientId,
        'image': imageFilePart,
      });

      debugPrint("Uploading Image:");
      debugPrint("Patient ID: $patientId");
      debugPrint("Image Path: ${imageFile.path}");
      debugPrint("Filename: $fileName");

      formData.fields.forEach((element) {
        debugPrint("FormData Field: ${element.key} = ${element.value}");
      });

      formData.files.forEach((element) {
        debugPrint("FormData File: ${element.key} = ${element.value.filename}");
      });

      // Make the API call to upload the image
      final response = await apiClient.request(
        '$baseUrl/uploadprogressphoto',
        formData,
        method: 'POST',
      );

      // Handle the response
      if (response != null && response.statusCode == 200) {
        final responseData = response.data;

        // Return success data
        return {
          'statusCode': response.statusCode,
          'message': responseData['message'] ?? 'Image uploaded successfully',
          'photo': responseData['photo'] ?? '',
        };
      } else {
        debugPrint("Response Data: ${response?.data}");
        debugPrint(
            "Error uploading image: Status Code: ${response?.statusCode}, Message: ${response?.statusMessage}");
        return {
          'statusCode': response?.statusCode ?? 500,
          'message': 'Failed to upload image. ${response?.statusMessage ?? ''}',
          'photo': '',
        };
      }
    } catch (e) {
      debugPrint('Error uploading image: $e');
      return {
        'statusCode': 500,
        'message': 'Error uploading image due to an exception',
        'photo': '',
      };
    }
  }

  // Method to send OTP for forgot password
  Future<Map<String, dynamic>> sendOtpForForgotPassword(String email) async {
    try {
      final formData = FormData.fromMap({'email': email});

      final response = await apiClient.request(
        '$baseUrl/forgotOtp',
        formData,
      );

      debugPrint('API Response: ${response?.data}');
      debugPrint('API Status Code: ${response?.statusCode}');

      if (response != null && response.statusCode == 200) {
        final responseData = response.data;
        return {
          'statusCode': response.statusCode,
          'message': responseData['message'] ?? 'OTP sent successfully',
          'otp': responseData['otp'],
        };
      } else if (response != null && response.statusCode == 422) {
        final responseData = response.data;
        return {
          'statusCode': response.statusCode,
          'message': responseData['message'] ?? 'Validation failed',
          'errors': responseData['errors'] ?? {},
        };
      } else {
        return {
          'statusCode': response?.statusCode ?? 500,
          'message': 'Failed to send OTP',
          'otp': null,
        };
      }
    } catch (e) {
      debugPrint('Error sending OTP: $e');
      return {
        'statusCode': 500,
        'message': 'Error sending OTP due to an exception',
        'otp': null,
      };
    }
  }

  // Method to verify OTP
  Future<Map<String, dynamic>> verifyOtp(String email, String otp) async {
    try {
      // Prepare the data to send with the POST request
      final formData = FormData.fromMap({
        'email': email,
        'otp': otp,
      });
      debugPrint('Request Payload: $formData');

      // Make the API request
      final response = await apiClient.request(
        '$baseUrl/verifyOtp',
        formData,
      );

      debugPrint('Response of verify otp: $response');
      debugPrint('Response Status Code: ${response?.statusCode}');

      // Check if the response is valid and return appropriate data
      if (response != null && response.statusCode == 200) {
        final responseData = response.data;
        debugPrint('Response Data: $responseData');

        return {
          'statusCode': response.statusCode,
          'message': responseData['message'] ?? 'OTP verified successfully',
          'patient_id': responseData['patient_id'],
        };
      } else if (response != null && response.statusCode == 401) {
        final responseData = response.data;
        debugPrint('Error Response Data: $responseData');

        return {
          'statusCode': response.statusCode,
          'message': responseData['message'] ?? 'Invalid or expired OTP',
        };
      } else if (response != null && response.statusCode == 422) {
        final responseData = response.data;
        debugPrint('Error Response Data: $responseData');

        return {
          'statusCode': response.statusCode,
          'message': responseData['message'] ?? 'OTP is required',
          'errors': responseData['errors'] ?? {},
        };
      } else {
        debugPrint('Unexpected Error Response: ${response?.data}');
        return {
          'statusCode': response?.statusCode ?? 500,
          'message': 'Failed to verify OTP',
        };
      }
    } catch (e) {
      debugPrint('Error verifying OTP: $e');
      return {
        'statusCode': 500,
        'message': 'Error verifying OTP due to an exception',
      };
    }
  }

  // Method to change/reset the password
  Future<Map<String, dynamic>> changePassword(
      String patientId, String newPassword) async {
    try {
      final formData = FormData.fromMap({
        'patient_id': patientId,
        'new_password': newPassword,
      });

      final response = await apiClient.request(
        '$baseUrl/changePassword',
        formData,
      );

      debugPrint('Response of change password: $response');
      debugPrint('Response Status Code: ${response?.statusCode}');

      if (response != null && response.statusCode == 200) {
        final responseData = response.data;
        return {
          'statusCode': response.statusCode,
          'message': responseData['message'] ?? 'Password changed successfully',
        };
      } else if (response != null && response.statusCode == 422) {
        final responseData = response.data;
        return {
          'statusCode': response.statusCode,
          'message': responseData['message'] ?? 'Validation failed',
          'errors': responseData['errors'] ?? {},
        };
      } else {
        return {
          'statusCode': response?.statusCode ?? 500,
          'message': 'Failed to change password',
        };
      }
    } catch (e) {
      debugPrint('Error changing password: $e');
      return {
        'statusCode': 500,
        'message': 'Error changing password due to an exception',
      };
    }
  }
}
