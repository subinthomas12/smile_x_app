import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x/core/constants/colors.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    super.key,
    this.title,
    this.fontSize,
    this.fontWeight,
    this.color,
  });
  final String? title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? "",
      style: TextStyle(
        color: color ?? AppColors.secondary,
        fontSize: fontSize ?? Get.height * 0.018,
        fontWeight: fontWeight ?? FontWeight.normal,
      ),
      // overflow: TextOverflow.ellipsis,
      // maxLines: 1,
    );
  }
}
