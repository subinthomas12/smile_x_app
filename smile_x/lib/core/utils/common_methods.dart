import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommonMethods {
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

  // Future<Map<String, String?>> getWearingStatus() async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();

  //     String? totalWearingHours = prefs.getString('totalWearingHours');
  //     String? notWearingHours = prefs.getString('notWearingHours');

  //     debugPrint('Total Wearing Hours: $totalWearingHours');
  //     debugPrint('Not Wearing Hours: $notWearingHours');

  //     return {
  //       'totalWearingHours': totalWearingHours,
  //       'notWearingHours': notWearingHours,
  //     };
  //   } catch (e) {
  //     debugPrint('Error retrieving wearing status: $e');
  //     return {
  //       'totalWearingHours': null,
  //       'notWearingHours': null,
  //     };
  //   }
  // }
}
