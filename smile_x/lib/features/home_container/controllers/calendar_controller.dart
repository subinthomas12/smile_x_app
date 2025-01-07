import 'package:get/get.dart';
import 'package:smile_x/routes/app_routes.dart';

class CalendarController extends GetxController {
  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
  }

  // void navigateToReminderUpdate() {
  //   Get.toNamed(AppRoutes.reminderUpdation);
  // }
}
