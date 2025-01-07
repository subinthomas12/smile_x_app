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
}
