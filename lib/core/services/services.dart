import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../localization/changelocal.dart';

class MyServices extends GetxService {

  late  SharedPreferences sharedPreferences ;

  Future<MyServices> init() async {
   //  await Firebase.initializeApp();
  sharedPreferences =  await SharedPreferences.getInstance() ;
  return this ;
  }

}
LocaleController localeController = LocaleController();


initialServices() async  {
  await Get.putAsync(() => MyServices().init()) ;
  Get.put(()=>localeController.onInit());
}