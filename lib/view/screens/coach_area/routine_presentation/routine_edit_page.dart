import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/client_controllers/routines_controllers/routines_page_controller.dart';
import '../../../../core/utils/helpers/helper_functions.dart';

class EditRoutinePage extends StatefulWidget {
    final routineID;

      const EditRoutinePage({super.key, required this.routineID});

  @override
  State<EditRoutinePage> createState() => _EditRoutinePageState();
}
final coachHomeController = Get.put(RoutinesPageController());

 class _EditRoutinePageState extends State<EditRoutinePage> {
  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);

    return GetBuilder<RoutinesPageController>(
      init: RoutinesPageController(),
      builder: (controller) => Scaffold(
        backgroundColor: dark ? Colors.black : Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: dark ? Colors.black : Colors.white,
          // title: Text(
          //   '${controller.clientRoutines[widget.routineID].routines} Workout',
          // ),
          iconTheme: const IconThemeData(color: Colors.blueAccent),
        ),
        body: const Column(
          children: [
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: controller.clientRoutines[widget.routineID].routines.length,
            //     itemBuilder: (context, index) {
            //       var s =controller.clientRoutines[widget.routineID].routines[index];
            //
            //        return ListTile(
            //         title: Text(s.exercises[index].exerciseName),
            //         subtitle: Text(s.exercises[index].targetMuscles),
            //         leading: ClipOval(
            //           child: Image.asset(
            //             TImages.excersiseDirectory +s.exercises[index].exerciseImage,
            //             width: 50,
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
