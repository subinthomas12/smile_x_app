// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:smile_x/core/constants/colors.dart';
// import 'package:smile_x/core/constants/const.dart';

// class ReminderUpdation extends StatelessWidget {
//   ReminderUpdation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primary,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: screenWidth4, vertical: screenHeight4),
//           child: Column(
//             children: [
//               Row(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: AppColors.lightGray,
//                     child: IconButton(
//                       icon: Icon(
//                         Icons.arrow_back_ios_new,
//                         color: AppColors.darkGray,
//                         size: screenWidth5,
//                       ),
//                       onPressed: () {
//                         Get.back();
//                       },
//                     ),
//                   ),
//                   Expanded(
//                     child: Center(
//                       child: Text(
//                         'Edit Time',
//                         style: GoogleFonts.poppins(
//                           fontSize: screenHeight2,
//                           color: AppColors.contents,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: AppColors.secondary,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: screenWidth3),
//                       child: TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           'Save',
//                           style: GoogleFonts.poppins(
//                             fontSize: screenHeight2,
//                             color: AppColors.primary,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               kHeight3,
//               _clickableRow(
//                 icon: Icons.fastfood,
//                 label: 'Took Off',
//                 timestamp: '11-08-2023, 10.06 PM',
//                 onTap: () {
//                   debugPrint('Took Off tapped');
//                 },
//               ),
//               kHeight2,
//               _clickableRow(
//                 icon: Icons.thumb_up,
//                 label: 'Put On',
//                 timestamp: '11-08-2023, 10.06 PM',
//                 onTap: () {
//                   debugPrint('Put On tapped');
//                 },
//               ),
//               kHeight4,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   _timerRow(
//                     label: '5min',
//                     onTap: () {
//                       debugPrint('5min tapped');
//                     },
//                   ),
//                   _timerRow(
//                     label: '15min',
//                     onTap: () {
//                       debugPrint('15min tapped');
//                     },
//                   ),
//                   _timerRow(
//                     label: '30min',
//                     onTap: () {
//                       debugPrint('30min tapped');
//                     },
//                   ),
//                   _timerRow(
//                     label: '45min',
//                     onTap: () {
//                       debugPrint('45min tapped');
//                     },
//                   ),
//                   _timerRow(
//                     label: '1hr',
//                     onTap: () {
//                       debugPrint('1hr tapped');
//                     },
//                   ),
//                 ],
//               ),
//               kHeight3,
//               _dateTimeRow(
//                 date: '11-07-2024',
//                 time: 'Out 6 hr 41 min',
//               ),
//               kHeight1,
//               _dateTimeRow(
//                 date: '11-07-2024',
//                 time: 'Out 6 hr 41 min',
//               ),
//               kHeight8,
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     debugPrint('ElevatedButton tapped');
//                   },
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.danger,
//                       minimumSize: Size(screenWidth1, screenHeight5),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(15),
//                       )),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.delete,
//                         color: AppColors.primary,
//                         size: screenHeight * 0.018,
//                       ),
//                       kWidth2,
//                       Text(
//                         'Delete',
//                         style: GoogleFonts.poppins(
//                           fontSize: screenHeight2,
//                           color: AppColors.primary,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget _clickableRow({
//   required IconData icon,
//   required String label,
//   required String timestamp,
//   required VoidCallback onTap,
// }) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: AppColors.lightGray,
//               child: Icon(
//                 icon,
//                 size: screenHeight * 0.018,
//                 color: AppColors.contents,
//               ),
//             ),
//             kWidth1,
//             Text(
//               label,
//               style: GoogleFonts.poppins(
//                 fontSize: screenHeight2,
//                 color: AppColors.contents,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ],
//         ),
//         Text(
//           timestamp,
//           style: GoogleFonts.poppins(
//             fontSize: screenHeight2,
//             color: AppColors.contents,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget _timerRow({
//   required String label,
//   required VoidCallback onTap,
// }) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Row(
//       children: [
//         Icon(
//           Icons.timer,
//           color: AppColors.contents,
//           size: screenHeight * 0.018,
//         ),
//         Text(
//           label,
//           style: GoogleFonts.poppins(
//             fontSize: screenHeight2,
//             color: AppColors.contents,
//             fontWeight: FontWeight.w500,
//           ),
//         )
//       ],
//     ),
//   );
// }

// Widget _dateTimeRow({required String date, required String time}) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       Text(
//         date,
//         style: GoogleFonts.poppins(
//           fontSize: screenHeight2,
//           color: AppColors.contents,
//           fontWeight: FontWeight.w400,
//         ),
//       ),
//       Text(
//         time,
//         style: GoogleFonts.poppins(
//           fontSize: screenHeight2,
//           color: AppColors.contents,
//           fontWeight: FontWeight.w400,
//         ),
//       )
//     ],
//   );
// }
