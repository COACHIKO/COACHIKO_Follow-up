
import 'package:get/get.dart';
import '../../../data/model/routine_models/routine_model.dart';
import '../../../core/utils/helpers/network_manager.dart';
import '../../../data/model/routine_models/workout_data_model.dart';
import '../../../data/source/web_services/client_web_services/client_routines_get_service.dart';
import '../../../view/screens/client_area/routine_screens/routine_log_page.dart';

enum RoutinesState { loading,loaded, error, noData }

class RoutinesPageController extends GetxController {
  static RoutinesPageController get instance => Get.find();
  final NetworkManager networkManager = Get.put(NetworkManager());
  var routineName = ''.obs;
  Rx<RoutinesState> state = RoutinesState.noData.obs;
  Rx<WorkoutData?> routines = Rx<WorkoutData?>(null);
  @override
  void onInit() {
    fetchRoutineData();
    // requestPermission();
    super.onInit();
  }

  // requestPermission()async{
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;
  //
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  //
  //   print('User granted permission: ${settings.authorizationStatus}');
  // }
  //e0xPAXwyQkyctGwmwLIOsw:APA91bF3X3_AZ7eEQzh04t9v1B0TRTF_kdWWX91JArOYhqXlPE5jOQkDsc-LknPoEyNM1lOFqh5bHYGW-aEjOdvZjXTuCnNgXANsdsaJTHNGYzjRR00kBcPLdcUy8l6uEzZBGqkmvkcg
  void fetchRoutineData() async {
    try {
      state.value = RoutinesState.loading;

      final clientRoutinesGetService = ClientRoutinesGetService();
      final data = await clientRoutinesGetService.getRoutineData(state);

      if (data.routines.isNotEmpty) {
        routines.value = data;
        state.value = RoutinesState.loaded;
        update();
      } else {
        state.value = RoutinesState.noData;
      }
    } catch (e) {
      if (e is FormatException && e.toString() == "No data found for the user.") {
        state.value = RoutinesState. error;
        update();
      } else {
        // Handle other exceptions
        print('Unhandled exception: $e');
        state.value = RoutinesState.noData;
      }
    }
  }
  void startRoutine(Routine routine) {
    Get.to(() => ExerciseLoggingPage(routine: routine), transition: Transition.size,duration: const Duration(milliseconds: 250),);
  }
}
