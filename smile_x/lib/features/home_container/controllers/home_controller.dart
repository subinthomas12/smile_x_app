import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs;
  var pickedFile = Rx<File?>(null);

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
        // await navigateToEditor(image);
      } else {
        Get.snackbar("No Image", "No image was captured.");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
    }
  }

  // Tab index change method
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
