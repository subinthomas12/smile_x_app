class PatientModal {
  final int id;
  final int clinicId;
  final String registrationDate;
  final String patientCode;
  final String patientName;
  final String patientAge;
  final int genderId;
  final String patientPhone;
  final String patientMobile;
  final String patientWhatsapp;
  final String patientEmail;
  final String patientAddress;
  final String patientComplaint;
  final String patientResults;
  final String patientUsername;
  final String patientPassword;

  PatientModal({
    required this.id,
    required this.clinicId,
    required this.registrationDate,
    required this.patientCode,
    required this.patientName,
    required this.patientAge,
    required this.genderId,
    required this.patientPhone,
    required this.patientMobile,
    required this.patientWhatsapp,
    required this.patientEmail,
    required this.patientAddress,
    required this.patientComplaint,
    required this.patientResults,
    required this.patientUsername,
    required this.patientPassword,
  });

  factory PatientModal.fromJson(Map<String, dynamic> json) {
    return PatientModal(
      id: json['id'],
      clinicId: json['clinic_id'],
      registrationDate: json['registration_date'],
      patientCode: json['patient_code'],
      patientName: json['patient_name'],
      patientAge: json['patient_age'],
      genderId: json['gender_id'],
      patientPhone: json['patient_phone'],
      patientMobile: json['patient_mobile'],
      patientWhatsapp: json['patient_whatsapp'],
      patientEmail: json['patient_email'],
      patientAddress: json['patient_address'],
      patientComplaint: json['patient_complaint'],
      patientResults: json['patient_results'],
      patientUsername: json['patient_username'],
      patientPassword: json['patient_password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clinic_id': clinicId,
      'registration_date': registrationDate,
      'patient_code': patientCode,
      'patient_name': patientName,
      'patient_age': patientAge,
      'gender_id': genderId,
      'patient_phone': patientPhone,
      'patient_mobile': patientMobile,
      'patient_whatsapp': patientWhatsapp,
      'patient_email': patientEmail,
      'patient_address': patientAddress,
      'patient_complaint': patientComplaint,
      'patient_results': patientResults,
      'patient_username': patientUsername,
      'patient_password': patientPassword,
    };
  }
}
