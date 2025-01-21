import 'package:get/get.dart';
import '../view/widgets/status.dart';

class TabControllerController extends GetxController {
  var selectedTabIndex = 0.obs;
  var data = ''.obs;

  // Dropdown items for each tab type
  List<String> getDropdownItems(int index) {
    switch (index) {
      case 0:
        return ['Last 7 days', 'Last day'];
      case 1:
        return ['Last Week', 'This Week'];
      case 2:
        return ['Last Month', 'This Month'];
      default:
        return [];
    }
  }

  List<ChartData> getChartData(int index) {
    switch (index) {
      case 0: // Daily
        return [
          ChartData('12:00 AM - 4:00 AM', 6),
          ChartData('4:00 AM - 8:00 AM', 12),
          ChartData('8:00 AM - 12:00 PM', 18),
          ChartData('12:00 PM - 4:00 PM', 24),
          ChartData('4:00 PM - 8:00 PM', 7),
          ChartData('8:00 PM - 12:00 AM', 6),
        ];

      case 1: // Weekly
        return [
          ChartData('Mon', 6),
          ChartData('Tue', 12),
          ChartData('Wed', 18),
          ChartData('Thu', 24),
          ChartData('Fri', 7),
          ChartData('Sat', 10),
          ChartData('Sun', 6),
        ];
      case 2: // Monthly
        return [
          ChartData('Jan', 0),
          ChartData('Feb', 30),
          ChartData('Mar', 40),
          ChartData('Apr', 50),
          ChartData('May', 10),
          ChartData('Jun', 1),
          ChartData('Jul', 95),
          ChartData('Aug', 35),
          ChartData('Sep', 72),
          ChartData('Oct', 5),
          ChartData('Nov', 15),
          ChartData('Dec', 10),
        ];
      default:
        data.value = '';
        return [];
    }
  }

  // Update the selected tab index and refresh data
  void textChange(int index) {
    selectedTabIndex.value = index;
    getChartData(index);
  }

  @override
  void onInit() {
    super.onInit();
    getChartData(selectedTabIndex.value);
  }
}
