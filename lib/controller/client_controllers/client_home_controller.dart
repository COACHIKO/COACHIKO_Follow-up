import 'package:get/get.dart';
import '../../data/source/web_services/coach_web_services/coach_getAllClients_service.dart';
import '../../features/modules/client/routine/routine_get/ui/workout_plan_page.dart';
import '../../features/modules/coach/all_clients_display/ui/all_clients_display.dart';
import '../../view/screens/coach_area/diet_presentation/diet_making_page.dart';
import '../../view/screens/setting_page.dart';

class ClientHomeController extends GetxController {
  static ClientHomeController get instance => Get.find();
  final Rx<int> selectedIndex = 0.obs;

  GetAllClients getAllClients = GetAllClients();
  //GetAllFoods getAllFoods = GetAllFoods();

  final DietMakingController dietMakingController =
      Get.put(DietMakingController());
  final screens = [
    const WorkoutPlanPage(),
    // const DietPreviewfClient(),
    const MyClients(),
    const SettingScreen(),
  ];

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {} catch (e) {
      //print(e);
    }
  }
}
