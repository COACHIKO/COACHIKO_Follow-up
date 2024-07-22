// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../../../../core/utils/constants/text_strings.dart';
// import '../../../logic/signup_controller.dart';

// class CoachFormField extends StatelessWidget {
//   const CoachFormField({
//     super.key,
//     required this.dark,
//     required this.signUpController,
//   });

//   final bool dark;
//   final SignUpController signUpController;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: dark ? const Color(0xff1f1f1F) : Colors.white,
//           borderRadius: BorderRadius.circular(12)),
//       child: SizedBox(
//         width: 337.1,
//         height: 65,
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 12.w),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 CTexts.youCoach,
//               ),
//               InkWell(
//                 enableFeedback: false, // Disable the splash effect
//                 splashColor: Colors.transparent,
//                 onTap: () {
//                   signUpController.toggleCoach();
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: signUpController.isCoach.value == false
//                         ? const Color(0xff797979)
//                         : Colors.blueAccent,
//                     border: Border.all(
//                       width: 0,
//                     ),
//                   ),
//                   width: 25,
//                   height: 25,
//                   child: const Center(
//                     child: Icon(Icons.check, color: Color(0xfff6f6f6)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
