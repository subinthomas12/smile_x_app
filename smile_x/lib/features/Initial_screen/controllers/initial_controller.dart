import 'package:get/get.dart';

class InitialScreenController extends GetxController {
  var isSwiped = false.obs; // Rx variable to track swipe state

  @override
  void onInit() {
    super.onInit();
    navigateToHome();
  }

  // This function will be called to navigate after a delay
  void navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      if (isSwiped.value) {
        // Using GetX to navigate
        Get.offAllNamed('/login');
      }
    });
  }

  // Method to trigger swipe action
  void swipe() {
    isSwiped.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      if (isSwiped.value) {
        Get.offAllNamed('/login');
      }
    });
  }
}
