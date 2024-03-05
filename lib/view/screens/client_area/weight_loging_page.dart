// import 'package:flutter/material.dart';
//
// import '../../widgets/custom_appbar.dart';
//
// class Home3 extends StatefulWidget {
//
//
//   @override
//   State<Home3> createState() => _Home3State();
// }
//
// class _Home3State extends State<Home3> {
//   @override
//   void initState() {
//     super.initState();
//     tz.initializeTimeZones();
//     initializeNotifications();
//   }
//
//   Widget build(BuildContext context) {
//     return  GetBuilder<HomeController>(init: HomeController(),builder: (controller) =>(
//         Scaffold(backgroundColor: Colors.black,appBar:CustomAppBar(),
//             body:Container(padding: EdgeInsets.symmetric(horizontal: 11,vertical: 30),
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
//                 Text("Here you should enter your weight daily",style: TextStyle(color: Colors.white),),
//                 SizedBox(height: 4.h,),
//                 Text("you can ask for daily alert by pressing below :",style: TextStyle(color: Colors.white),),
//                 SizedBox(height: 25,),
//                 Center(child: CustomMaterialButton(onPressed: (){selectTime(context);}, buttonText: "Daily Reminder"))
//
//               ],),
//             )
//         )
//
//     ));
//   }
// }