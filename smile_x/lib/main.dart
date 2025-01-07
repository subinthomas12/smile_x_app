import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smile_x/core/constants/colors.dart';
import 'package:smile_x/features/home_container/view/screens/home_container.dart';
import 'package:smile_x/features/home_container/view/widgets/home.dart';
import 'package:smile_x/routes/app_pages.dart';

void main() {
  runApp(
    const MyApp(),
    // DevicePreview(
    //   enabled: true,
    //   tools: const [
    //     ...DevicePreview.defaultTools,
    //   ],
    //   builder: (context) => const MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Smile X',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.secondary),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      // home: HomeContainer(),
      initialRoute: "/",
      getPages: AppPages.pages,
    );
  }
}
