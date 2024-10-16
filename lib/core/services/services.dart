import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../notification/notfication.dart';

// class MyServices {
//   static final MyServices _instance = MyServices._internal();

//   late SharedPreferences sharedPreferences;
//   NotificationService notificationService = NotificationService();

//   factory MyServices() {
//     return _instance;
//   }

//   MyServices._internal();

//   Future<void> init() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     notificationService.initializeNotification();
//     FirebaseMessaging.onMessage.listen((event) {
//       if (event.notification != null) {
//         notificationService.showNotification(
//           title: event.notification!.title.toString(),
//           body: event.notification!.body.toString(),
//         );
//       }
//     });
//   }
// }

// Future<void> initialServices() async {
//   MyServices myServices = MyServices();
//   await myServices.init();
// }
