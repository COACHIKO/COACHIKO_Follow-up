import 'package:followupapprefactored/controller/routines_page_controller.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/model/exercise_model.dart';
import '../../data/model/routine_model.dart';

class CacheController extends GetxController {
  static CacheController get instance =>Get.find();
  final coachHomeController = Get.put(RoutinesPageController());


}