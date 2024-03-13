import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/view/screens/auth_screens/fork_usering_page.dart';
import 'package:followupapprefactored/view/screens/client_area/client_home_screen.dart';
import 'package:followupapprefactored/view/screens/client_area/starting_form_screens/form_complection_page.dart';
import 'package:followupapprefactored/view/screens/coach_area/coach_home_page.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'core/localization/changelocal.dart';
import 'core/localization/translation.dart';
import 'core/services/services.dart';
import 'core/utils/constants/text_strings.dart';
import 'core/utils/theme/theme.dart';

LocaleController localeController = LocaleController();
MyServices myServices = Get.find();
Box? mybox;
Future<Box> openHiveBox(String boxname, {required String path}) async {
  if (!Hive.isBoxOpen(boxname)) {
    Hive.init((await getApplicationDocumentsDirectory()).path);
  }
  return await Hive.openBox(boxname);
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  // Initialize Hive
  await Hive.initFlutter();
  // Register adapters if not already registered
  // if (!Hive.isAdapterRegistered(0)) {
  //   Hive.registerAdapter(ExerciseAdapter());
  //   Hive.registerAdapter(RoutineAdapter());
  //   Hive.registerAdapter(WorkoutDataAdapter());
  //   // Hive.registerAdapter(FoodDataModelAdapter());
  //   // Hive.registerAdapter(DietModelAdapter());
  //   // Hive.registerAdapter(DietApiGetAdapter());
  //   // Hive.registerAdapter(DietDataAdapter());
  //
  // }
  // Open the Hive box
 // final appDocumentDirectory = await getApplicationDocumentsDirectory();
 //  mybox = await openHiveBox("workout_data", path: appDocumentDirectory.path);

  runApp(COACHIKOFollowApp());
}
class COACHIKOFollowApp extends StatelessWidget {
  COACHIKOFollowApp({super.key});
final LocaleController langController = Get.put(LocaleController());
    @override
  Widget build(BuildContext context) {
      return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, child) {
          return GetMaterialApp(
           title: CTexts.appName,
           themeMode: ThemeMode.system,
           theme: TAppTheme.lightTheme,
           darkTheme: TAppTheme.darkTheme,
           locale: langController.language,
           translations: MyTranslation(),
            initialRoute: myServices.sharedPreferences.getInt("user") == null ||myServices.sharedPreferences.getBool("rememberMe")==false
                ? "/forkUsering"
                : (myServices.sharedPreferences.getInt("isCoach") == 0
                ? "/homepage"
                : "/coach"),
            routes:{
              "/homepage":(context)=>const HomePage(),
              "/forkUsering":(context)=>const ForkUseringPage(),
              "/coach":(context)=> const CoachHome(),
              "/formComplection":(context)=> FormComplection(),
             },
            debugShowCheckedModeBanner: false,

          );
        },
      );
    }}

