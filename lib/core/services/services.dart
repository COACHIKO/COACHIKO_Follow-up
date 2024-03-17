import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../localization/changelocal.dart';
import '../notification/notfication.dart';

class MyServices extends GetxService {
   late  SharedPreferences sharedPreferences ;
   NotificationService notificationService = NotificationService();
  Future<MyServices> init() async {
   sharedPreferences =  await SharedPreferences.getInstance() ;
   notificationService.initializeNotification();
   FirebaseMessaging.onMessage.listen((event) {
     if(event.notification!=null){
       //print("======= Forground Message =======");

        notificationService.showNotification(title: event.notification!.title.toString(), body: event.notification!.body.toString());

     }
   });
  return this ;
  }

}
LocaleController localeController = LocaleController();


initialServices() async  {
  await Get.putAsync(() => MyServices().init()) ;
  Get.put(()=>localeController.onInit());


}

