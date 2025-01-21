import 'package:get/get.dart';
import 'package:smile_x/routes/app_routes.dart';

class UploadsHistoryController extends GetxController {
  var uploadsHistory = [
    {
      "alignerLabel": "Aligner 1",
      "date": "2025-01-18",
      "time": "12:30 PM",
      "comment": "Initial Upload, looks good.",
      "imageUrl":
          "https://i.postimg.cc/6QV9VRdb/360-F-638561458-g-Yp-OX6-IEUOw-Woaa6-Kk-Sg-Qju-F8-DW8-QL7-C.jpg"
    },
    {
      "alignerLabel": "Aligner 2",
      "date": "2025-01-19",
      "time": "3:45 PM",
      "comment": "Updated image, slightly adjusted.",
      "imageUrl":
          "https://i.postimg.cc/6QV9VRdb/360-F-638561458-g-Yp-OX6-IEUOw-Woaa6-Kk-Sg-Qju-F8-DW8-QL7-C.jpg"
    },
    {
      "alignerLabel": "Aligner 3",
      "date": "2025-01-20",
      "time": "5:00 PM",
      "comment": "Final upload, ready for review.",
      "imageUrl":
          "https://i.postimg.cc/6QV9VRdb/360-F-638561458-g-Yp-OX6-IEUOw-Woaa6-Kk-Sg-Qju-F8-DW8-QL7-C.jpg"
    },
    {
      "alignerLabel": "Aligner 1",
      "date": "2025-01-18",
      "time": "12:30 PM",
      "comment": "Initial Upload, looks good.",
      "imageUrl":
          "https://i.postimg.cc/6QV9VRdb/360-F-638561458-g-Yp-OX6-IEUOw-Woaa6-Kk-Sg-Qju-F8-DW8-QL7-C.jpg"
    },
    {
      "alignerLabel": "Aligner 2",
      "date": "2025-01-19",
      "time": "3:45 PM",
      "comment":
          "Updated image, slightly adjusted. Updated image, slightly adjusted. Updated image, slightly adjusted. Updated image, slightly adjusted.",
      "imageUrl":
          "https://i.postimg.cc/6QV9VRdb/360-F-638561458-g-Yp-OX6-IEUOw-Woaa6-Kk-Sg-Qju-F8-DW8-QL7-C.jpg"
    },
    {
      "alignerLabel": "Aligner 3",
      "date": "2025-01-20",
      "time": "5:00 PM",
      "comment":
          "Final upload, ready for review. Updated image, slightly adjusted. Updated image, slightly adjusted.",
      "imageUrl":
          "https://i.postimg.cc/6QV9VRdb/360-F-638561458-g-Yp-OX6-IEUOw-Woaa6-Kk-Sg-Qju-F8-DW8-QL7-C.jpg"
    },
    {
      "alignerLabel": "Aligner 1",
      "date": "2025-01-18",
      "time": "12:30 PM",
      "comment": "Initial Upload, looks good.",
      "imageUrl":
          "https://i.postimg.cc/6QV9VRdb/360-F-638561458-g-Yp-OX6-IEUOw-Woaa6-Kk-Sg-Qju-F8-DW8-QL7-C.jpg"
    },
    {
      "alignerLabel": "Aligner 2",
      "date": "2025-01-19",
      "time": "3:45 PM",
      "comment":
          "Updated image, slightly adjusted. Updated image, slightly adjusted. Updated image, slightly adjusted. Updated image, slightly adjusted.",
      "imageUrl":
          "https://i.postimg.cc/6QV9VRdb/360-F-638561458-g-Yp-OX6-IEUOw-Woaa6-Kk-Sg-Qju-F8-DW8-QL7-C.jpg"
    },
    {
      "alignerLabel": "Aligner 3",
      "date": "2025-01-20",
      "time": "5:00 PM",
      "comment": "Final upload, ready for review.",
      "imageUrl":
          "https://i.postimg.cc/6QV9VRdb/360-F-638561458-g-Yp-OX6-IEUOw-Woaa6-Kk-Sg-Qju-F8-DW8-QL7-C.jpg"
    },
  ].obs;

  // Method for navigate to uploads details screen
  void navigateToUploadsHistoryDetailsScreen() {
    Get.toNamed(AppRoutes.uploadsHistoryDetails);
  }
}
