import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio) {
    _dio.options.connectTimeout = const Duration(seconds: 20);
    _dio.options.receiveTimeout = const Duration(seconds: 20);
    _dio.options.responseType = ResponseType.json;

    // Modify the validateStatus function to allow 401 status code to not throw an exception
    _dio.options.validateStatus = (status) {
      return status != null &&
          status < 500; // Allow status codes below 500, including 401
    };
  }

  Future<Response?> request(String url, FormData data, {String? method}) async {
    try {
      final response = await _dio.request(
        url,
        data: data,
        options: Options(method: method ?? 'post'),
      );
      return response;
    } on DioException catch (e) {
      debugPrint('Dio Error: ${e.message}');

      if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint('Connection Timeout!');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        debugPrint('Receive Timeout!');
      } else if (e.type == DioExceptionType.badResponse) {
        debugPrint('Bad response: ${e.response?.statusCode}');
      } else if (e.type == DioExceptionType.connectionError) {
        debugPrint('Connection error');
        _showNetworkErrorPage();
      }

      return e
          .response; // Return the response even on error (instead of throwing)
    } catch (e) {
      debugPrint('Unexpected error: $e');
      throw Exception('Failed to make POST request: $e');
    }
  }

  // Method to show a network error page or dialog
  void _showNetworkErrorPage() {
    debugPrint('Showing network error page...');
    // Trigger the error page or dialog
  }
}
