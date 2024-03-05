import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/excersise_log_controller.dart';
import '../../../core/utils/helpers/helper_functions.dart';
import '../../widgets/custom_textformfield.dart';


class ExerciseLoggingPage extends StatefulWidget {
  final String routineName;
  final List<String> exercises;
  final List<int> setsPerExercise;
  final List<int> rest;
  final List<double> lastWeights;

  const ExerciseLoggingPage({
    super.key,
    required this.routineName,
    required this.exercises,
    required this.setsPerExercise,
    required this.rest,
    required this.lastWeights,
  });

  @override
  ExerciseLoggingPageState createState() => ExerciseLoggingPageState();
}
class ExerciseLoggingPageState extends State<ExerciseLoggingPage> {
  final ExerciseLoggingController exerciseLoggingController = Get.put(ExerciseLoggingController());
  @override
  void initState() {
    super.initState();
    exerciseLoggingController.initializeExerciseLogs(widget);
   }

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);

    return GetBuilder<ExerciseLoggingController>(
      init: ExerciseLoggingController(),
      builder: (controller) => Scaffold(
         appBar: AppBar(
          centerTitle: true,
          backgroundColor: dark?Colors.black:Colors.white,
          title: Text(
            '${controller.capitalize(widget.routineName)} Workout',
          ),
          iconTheme: const IconThemeData(color: Colors.blueAccent),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: const PageScrollPhysics(),
                itemCount: widget.exercises.length,
                itemBuilder: (context, indexx) {
                  String exerciseName = widget.exercises[indexx];
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: ListTile(
                          leading: const Image(
                            image: AssetImage('assets/images/6.png'),
                            width: 50,
                          ),
                          title: Text(
                            exerciseName,
                            style: const TextStyle(
                              fontSize: 19,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 16),
                        child: const TextField(
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(),
                            focusColor: Color(0xff505050),
                            focusedBorder: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF959595),
                            ),
                            hintText: 'Add routine notes here',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 16),
                        child: Row(
                          children: [
                            const Icon(
                              CupertinoIcons.timer,
                              color: Colors.blue,
                              size: 22,
                            ),
                            Text(
                              " Rest Timer: ${
                                  controller.isClicked.value && indexx < controller.restSecondsList.length
                                      ? '${controller.restSecondsList[indexx].value ~/ 60} min ${controller.restSecondsList[indexx].value % 60} sec'
                                      : '${widget.rest[indexx]} min'
                              }",
                              style: const TextStyle(color: Colors.blue, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "SET",
                                  style: TextStyle(color: Color(0xFF959595)),
                                ),
                                Text(
                                  "PREVIOUS",
                                  style: TextStyle(color: Color(0xFF959595)),
                                ),
                                Text(
                                  "KG",
                                  style: TextStyle(color: Color(0xFF959595)),
                                ),
                                Text(
                                  "REPS",
                                  style: TextStyle(color: Color(0xFF959595)),
                                ),
                                Icon(
                                  Icons.check_sharp,
                                  color: Color(0xFF959595),
                                )
                              ],
                            ),
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.setsPerExercise[indexx],
                            itemBuilder: (context, setIndex) {
                              ExerciseLog exerciseLog = controller.exerciseLogs[indexx][setIndex];

                              return Container(
                                color: exerciseLog.iscomplete ? const Color(0xFF2C6111) :dark? Colors.black:Colors.white,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 9),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.start,

                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 5.5),
                                        child: Text(
                                          "${setIndex + 1}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: exerciseLog.iscomplete == false
                                                ? const Color(0xFF959595)
                                                : Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(left: 80, top: 0),
                                        child: Text(
                                          "${widget.lastWeights[indexx]}",
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: exerciseLog.iscomplete == false
                                                ? const Color(0xFF959595)
                                                : Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),

                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 40.0),
                                          child: Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly , children: [Flexible(
                                            child: Container(
                                              width: 50,
                                              //  margin: const EdgeInsets.only(left: 70, top: 0),
                                              alignment: Alignment.center,
                                              child: CustomWeightInput(isComplete: exerciseLog.iscomplete, hintText: "-"),
                                            ),
                                          ),
                                            Flexible(
                                            child: Container(padding: const EdgeInsets.only(left: 5.0),

                                              width: 50,

                                              //   margin: const EdgeInsets.only(left: 40, top: 0),
                                              child: CustomWeightInput(isComplete: exerciseLog.iscomplete, hintText: "-"),
                                            ),
                                          ),],),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.toggleTimer(indexx, setIndex,widget);
                                        },
                                        child: Icon(
                                          exerciseLog.iscomplete ? Icons.stop : Icons.play_arrow,size: 30,
                                          color: exerciseLog.iscomplete ? Colors.green : const Color(0xFF959595),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: .09,color: Colors.blueAccent,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseLog {
  String reps = '';
  String weight = '';
  bool iscomplete = false;
  int restTimer = 0;
}

