import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import '../view/widgets/status.dart';

class TabControllerController extends GetxController {
  var selectedTabIndex = 0.obs;
  var data = ''.obs;

  List<ChartData> getChartData(int index) {
    switch (index) {
      case 0:
        // data.value = 'Daily Data';
        return [
          ChartData('Mon', 6),
          ChartData('Tue', 12),
          ChartData('Wed', 18),
          ChartData('Thu', 24),
          ChartData('Fri', 7),
          ChartData('Sat', 10),
          ChartData('Sun', 6),
        ];
      case 1:
        // data.value = 'Weekly Data';
        return [
          ChartData('Mon', 5),
          ChartData('Tue', 10),
          ChartData('Wed', 8),
          ChartData('Thu', 20),
          ChartData('Fri', 17),
          ChartData('Sat', 11),
          ChartData('Sun', 10),
        ];
      case 2:
        // data.value = 'Monthly Data';
        return [
          ChartData('Mon', 6),
          ChartData('Tue', 12),
          ChartData('Wed', 18),
          ChartData('Thu', 24),
          ChartData('Fri', 7),
          ChartData('Sat', 10),
          ChartData('Sun', 6),
        ];
      default:
        data.value = '';
        return [];
    }
  }

  // Initialize the chart data on controller initialization
  @override
  void onInit() {
    super.onInit();
    // Initialize with the first tab's data (for example, Daily Data)
    getChartData(selectedTabIndex.value);
  }

  // Update the selected tab index and refresh data
  void textChange(int index) {
    selectedTabIndex.value = index;
    getChartData(index);
  }
}
