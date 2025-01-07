import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/core/constants/const.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/widgets/logo_image_widget.dart';
import '../../controllers/status_controller.dart';

class StatusScreen extends StatelessWidget {
  StatusScreen({super.key});
  final TabControllerController _tabController =
      Get.put(TabControllerController());

  @override
  Widget build(BuildContext context) {
    final List<String> items =
        List.generate(10, (index) => 'Item #${index + 1}');

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth5, vertical: screenHeight3),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: screenHeight2),
                child: Row(
                  children: [
                    const LogoImageWidget(),
                    const Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.share,
                        color: AppColors.contents,
                        size: iconSize,
                      ),
                      onPressed: () {
                        debugPrint("share.....");
                      },
                    ),
                  ],
                ),
              ),
              kHeight1,
              _buildCustomButton(),
              Obx(() {
                return Text(_tabController.data.string);
              }),
              GraphWidget(
                title: 'Status Monitor',
                dropdownItems: const ['Last 7 days', 'Last day'],
                onDropdownChanged: onDropdownChanged,
              ),
              kHeight1,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Wear Time',
                    style: GoogleFonts.poppins(
                      color: AppColors.contents,
                      fontSize: subTitleSize,
                    ),
                  ),
                  Text(
                    'Aligner #1',
                    style: GoogleFonts.poppins(
                      color: AppColors.contents,
                      fontSize: subTitleSize,
                    ),
                  ),
                ],
              ),
              kHeight1,
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return buildContainer(index + 1);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainer(int index) {
    String hours = '${index * 2} hours';
    return Container(
      height: screenHeight3,
      width: screenWidth4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.secondary, AppColors.blueShade.withOpacity(0.6)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '#$index',
            style: GoogleFonts.poppins(
                fontSize: contentSize,
                fontWeight: FontWeight.w500,
                color: AppColors.primary),
          ),
          Text(
            hours,
            style: GoogleFonts.poppins(
              fontSize: contentSize,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void onDropdownChanged(String? value) {
    debugPrint("Selected dropdown value: $value");
  }

  SizedBox _buildCustomButton() {
    return SizedBox(
      height: screenHeight5,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          List<String> tabNames = ['Daily', 'Weekly', 'Monthly'];
          return InkWell(
            onTap: () {
              debugPrint("Tab $index");
              _tabController.textChange(index); // Call this method here
            },
            child: Obx(
              () {
                bool isSelected =
                    _tabController.selectedTabIndex.toInt() == index;
                return Padding(
                  padding: EdgeInsets.all(screenWidth1),
                  child: Container(
                    decoration: BoxDecoration(
                      color: _tabController.selectedTabIndex.toInt() == index
                          ? AppColors.secondary
                          : AppColors.primary,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? Colors.transparent
                            : AppColors.contents,
                      ),
                    ),
                    padding: EdgeInsets.zero,
                    width: screenWidth * 0.290,
                    child: Center(
                      child: Text(
                        tabNames[index],
                        style: GoogleFonts.poppins(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.contents,
                          fontSize: contentSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class GraphWidget extends StatelessWidget {
  final String title;
  final List<String> dropdownItems;
  final ValueChanged<String?> onDropdownChanged;

  GraphWidget({
    super.key,
    required this.title,
    required this.dropdownItems,
    required this.onDropdownChanged,
  });

  final TabControllerController _tabController =
      Get.put(TabControllerController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Card(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: AppColors.lightGray,
                spreadRadius: 5,
                blurRadius: 5,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth4,
              vertical: screenHeight2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: subTitleSize,
                        fontWeight: FontWeight.w500,
                        color: AppColors.contents,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: screenHeight1),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: AppColors.lightGray, width: 1),
                      ),
                      child: DropdownButton<String>(
                        value:
                            dropdownItems.isNotEmpty ? dropdownItems[0] : null,
                        onChanged: onDropdownChanged,
                        items: dropdownItems
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                ))
                            .toList(),
                        underline: const SizedBox(),
                      ),
                    ),
                  ],
                ),
                kHeight1,
                Center(
                  child: Text(
                    "From Sun to Sat",
                    style: GoogleFonts.poppins(
                      fontSize: contentSize,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
                kHeight2,
                SizedBox(
                  height: screenHeight * 0.25,
                  width: double.infinity,
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    primaryYAxis: NumericAxis(
                      labelFormat: '{value} hrs',
                      minimum: 0,
                      maximum: 24,
                      interval: 6,
                      majorGridLines: const MajorGridLines(width: 1),
                      minorGridLines: const MinorGridLines(width: 0),
                    ),
                    series: <ChartSeries>[
                      ColumnSeries<ChartData, String>(
                        dataSource: _tabController.getChartData(
                            _tabController.selectedTabIndex.value),
                        xValueMapper: (ChartData data, _) => data.day,
                        yValueMapper: (ChartData data, _) => data.value,
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [AppColors.secondary, AppColors.primary],
                          stops: [0.0, 2.0],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class ChartData {
  ChartData(this.day, this.value);

  final String day;
  final double value;
}
