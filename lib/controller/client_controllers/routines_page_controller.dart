import 'package:get/get.dart';
import '../../../data/model/routine_model.dart';
import '../../core/utils/helpers/network_manager.dart';
import '../../data/source/web_services/client_web_services/client_routines_get_service.dart';
import '../../view/screens/client_area/routine_log_page.dart';

enum RoutinesState { loading, loaded, error, noData }

class RoutinesPageController extends GetxController {
  static RoutinesPageController get instance => Get.find();
  final NetworkManager networkManager = Get.put(NetworkManager());

  var routineName = ''.obs;

  Rx<RoutinesState> state = RoutinesState.noData.obs;
  Rx<WorkoutData?> routines = Rx<WorkoutData?>(null);

  @override
  void onInit() {
    fetchRoutineData();
    super.onInit();
  }

  void fetchRoutineData() async {
    try {
      state.value = RoutinesState.loading;

      final clientRoutinesGetService = ClientRoutinesGetService();
      final data = await clientRoutinesGetService.getRoutineData(state);

      if (data.routines.isNotEmpty) {
        routines.value = data;
        state.value = RoutinesState.loaded;
      } else {
        state.value = RoutinesState.noData;
      }
    } catch (e) {
      state.value = RoutinesState.error;
      print('Error fetching routine data: $e');
    }
  }

  void startRoutine(Routine routine) {
    Get.to(
          () => ExerciseLoggingPage(routine: routine),
      transition: Transition.fadeIn,
      duration: const Duration(milliseconds: 500),
    );
  }
}
