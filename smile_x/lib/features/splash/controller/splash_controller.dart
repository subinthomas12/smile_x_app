import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_x/features/login/controller/login_controller.dart';
import 'package:smile_x/routes/app_routes.dart';
import 'package:smile_x/services/api_client.dart';
import 'package:smile_x/services/api_manager.dart';

class SplashController extends GetxController {
  final LoginController loginController = Get.put(
      LoginController(apiManager: ApiManager(apiClient: ApiClient(Dio()))));

  @override
  void onInit() {
    super.onInit();
    navigateToInitialScreen();
  }

  // void navigateToInitialScreen() {
  //   Future.delayed(Duration(seconds: 5), () {
  //     Get.offNamed(AppRoutes.initial);
  //   });
  // }

  // Check for saved credentials and auto-login if present
  void navigateToInitialScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');

    if (username != null && password != null) {
      await loginController.loginUser(username, password);
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Get.offNamed(AppRoutes.initial);
      });
    }
  }
}
