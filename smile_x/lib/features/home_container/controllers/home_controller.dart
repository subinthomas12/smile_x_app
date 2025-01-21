import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/utils/common_methods.dart';
import 'package:smile_x/core/widgets/custom_snackbar.dart';
import 'package:smile_x/services/api_client.dart';
import 'dart:io';

import 'package:smile_x/services/api_manager.dart';

import '../../../core/constants/const.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;
  var pickedFile = Rx<File?>(null);

  final ApiManager apiManager = ApiManager(apiClient: ApiClient(Dio()));
  final CommonMethods commonMethods = CommonMethods();

  var isImageUploadLoading = false.obs;

  // Camera Permission Request
  Future<void> requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      pickImageFromCamera();
    } else if (status.isDenied) {
      Get.snackbar("Permission Denied", "Camera permission is required.");
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  // Pick Image from Camera
  Future<void> pickImageFromCamera() async {
    try {
      final ImagePicker picker = ImagePicker();
      final image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        pickedFile.value = File(image.path);
        var uploadedFile = File(image.path);
        // await navigateToEditor(image);
        uploadPhoto(uploadedFile);
      } else {
        Get.snackbar("No Image", "No image was captured.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
    }
  }

  // upload image
  Future<void> uploadPhoto(File imageFile) async {
    isImageUploadLoading(true); // Set loading state

    try {
      int? patientId = await commonMethods.getPatientId();
      if (patientId == null) {
        debugPrint('Patient ID not found.');
        showCustomSnackbar("Error", "Patient ID not found.");
        return;
      }

      // Call API to upload image
      final uploadResult = await apiManager.uploadImage(patientId, imageFile);

      if (uploadResult != null) {
        final statusCode = uploadResult['statusCode'];
        debugPrint('Upload progress photo attempt - Status Code: $statusCode');

        if (statusCode == 200) {
          final String message =
              uploadResult['message'] ?? 'Image uploaded successfully';
          final String photoUrl = uploadResult['photo'] ?? '';

          debugPrint('Image uploaded successfully: $message');

          // Display success message with photo URL in the snackbar
          showCustomSnackbar(
              "Success", "Image uploaded successfully: $photoUrl");
        } else {
          final String errorMessage =
              uploadResult['message'] ?? 'Failed to upload image';
          debugPrint('Failed to upload image: $errorMessage');

          // Display error message in the snackbar
          showCustomSnackbar("Error", errorMessage);
        }
      } else {
        debugPrint('Failed to upload image.');
        showCustomSnackbar(
            "Error", "Failed to upload image. Please try again.");
      }
    } catch (e) {
      debugPrint('Error uploading progress photo: $e');
      showCustomSnackbar(
          "Error", "Failed to upload image due to an exception.");
    } finally {
      isImageUploadLoading(false); // Reset loading state
    }
  }

  // Tab index change method
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  Future<bool> onWillPop() async {
    return await Get.dialog(
          AlertDialog(
            title: Text(
              'Exit',
              style: GoogleFonts.poppins(
                fontSize: subTitleSize,
                color: AppColors.secondary,
                fontWeight: FontWeight.w400,
              ),
            ),
            content: Text(
              'Are you sure want to exit app?',
              style: GoogleFonts.poppins(
                fontSize: contentSize,
                color: AppColors.contents,
              ),
              textAlign: TextAlign.justify,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Get.back(result: false),
                child: Text(
                  'No',
                  style: GoogleFonts.poppins(
                    fontSize: smallFontSize,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: Text(
                  'Yes',
                  style: GoogleFonts.poppins(fontSize: smallFontSize),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
