import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/core/networking/api_service.dart';
import '../../../../../../core/utils/constants/image_strings.dart';
import '../../../../../../core/utils/helpers/helper_functions.dart';
import '../../routine_get/data/models/routine_response.dart';
import '../data/repository/routine_log_repo_impl.dart';
import '../logic/bloc/routine_log_bloc.dart';

class RoutineWeightLogScreen extends StatelessWidget {
  final Routine routine;

  const RoutineWeightLogScreen({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RoutineWeightLogCubit(RoutineLogRepoImp(ApiService(Dio())))
            ..initializeRoutine(routine),
      child: BlocBuilder<RoutineWeightLogCubit, RoutineWeightLogState>(
        builder: (context, state) {
          if (state is RoutineWeightLogLoaded) {
            return _buildUI(context, state);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildUI(BuildContext context, RoutineWeightLogLoaded state) {
    var dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? Colors.black : Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: dark ? Colors.black : Colors.white,
        title: Text('${routine.routineName} Workout'),
        iconTheme: const IconThemeData(color: Colors.blueAccent),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: routine.exercises.length,
              itemBuilder: (context, exerciseIndex) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        child: ClipOval(
                          child: Image(
                            image: AssetImage(
                              TImages.excersiseDirectory +
                                  routine
                                      .exercises[exerciseIndex].exerciseImage,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        routine.exercises[exerciseIndex].exerciseName,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 16),
                      child: const TextField(
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          focusColor: Color(0xff505050),
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
                            state.focused == exerciseIndex
                                ? context
                                    .read<RoutineWeightLogCubit>()
                                    .printRestTime()
                                : routine.exercises[exerciseIndex]
                                            .targetMuscles ==
                                        "cardio"
                                    ? " Cardio Time : ${routine.exercises[exerciseIndex].rest} Mins"
                                    : " Rest Timer: ${routine.exercises[exerciseIndex].rest} Mins",
                            style:
                                TextStyle(color: Colors.blue, fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("SET"),
                          const Text("PREVIOUS"),
                          routine.exercises[exerciseIndex].targetMuscles ==
                                  "cardio"
                              ? const Text("Distance")
                              : const Text("KG"),
                          routine.exercises[exerciseIndex].targetMuscles ==
                                  "cardio"
                              ? const Text("Time")
                              : const Text("REPS"),
                          const Icon(
                            Icons.check,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      itemCount: routine.exercises[exerciseIndex].sets,
                      shrinkWrap: true,
                      itemBuilder: (context, setIndex) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              color: state.isFinishedLists[exerciseIndex]
                                      [setIndex]
                                  ? const Color(0xFF2C6111)
                                  : dark
                                      ? Colors.black
                                      : Colors.white,
                              child: Row(
                                children: [
                                  Text("${setIndex + 1}"),
                                  const Spacer(),
                                  SizedBox(width: 37.w),
                                  Text(
                                      "${routine.exercises[exerciseIndex].lastWeight} ${routine.exercises[exerciseIndex].targetMuscles == "cardio" ? "KM" : "KG"}"),
                                  const Spacer(),
                                  SizedBox(width: 22.w),
                                  Flexible(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        context
                                            .read<RoutineWeightLogCubit>()
                                            .updateWeight(
                                                exerciseIndex, setIndex, value);
                                      },
                                      decoration: const InputDecoration(
                                        // Remove the border and outline
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.zero,
                                        // Adjust hint style
                                        hintStyle: TextStyle(
                                          fontSize: 20,
                                        ),
                                        hintText: "-",
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  routine.exercises[exerciseIndex]
                                              .targetMuscles ==
                                          "cardio"
                                      ? TimeLogButton(
                                          exerciseIndex: exerciseIndex,
                                          setIndex: setIndex,
                                        )
                                      : Flexible(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            onChanged: (value) {
                                              context
                                                  .read<RoutineWeightLogCubit>()
                                                  .updateReps(exerciseIndex,
                                                      setIndex, value);
                                            },
                                            decoration: const InputDecoration(
                                              // Remove the border and outline
                                              border: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              contentPadding: EdgeInsets.zero,
                                              // Adjust hint style
                                              hintStyle: TextStyle(
                                                fontSize: 20,
                                              ),
                                              hintText: "-",
                                            ),
                                          ),
                                        ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      context
                                          .read<RoutineWeightLogCubit>()
                                          .updateExerciseLog(
                                              exerciseIndex, setIndex);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            state.isFinishedLists[exerciseIndex]
                                                    [setIndex]
                                                ? Colors.blueAccent
                                                : Colors.grey,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(6),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        size: 18,
                                        color:
                                            state.isFinishedLists[exerciseIndex]
                                                    [setIndex]
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () async {
                  var cubit = context.read<RoutineWeightLogCubit>();
                  await cubit.submitAndLogRoutine(1, (routine.routineId));
                },
                child: const Text('Submit'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeLogButton extends StatelessWidget {
  final int exerciseIndex;
  final int setIndex;
  const TimeLogButton({
    super.key,
    required this.exerciseIndex,
    required this.setIndex,
  });

  formatedTime(BuildContext context) {
    return context.read<RoutineWeightLogCubit>().formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        showMyBottomSheet(
          context,
          context.read<RoutineWeightLogCubit>(),
          exerciseIndex,
          setIndex,
        );
      },
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        child: Text(
          formatedTime(context),
          style: TextStyle(
              fontSize: formatedTime(context) != '-' ? 14 : 22,
              color: Colors.grey),
        ),
      ),
    );
  }
}

void showMyBottomSheet(BuildContext context, RoutineWeightLogCubit cubit,
    int exerciseIndex, int setIndex) {
  int selectedHour = 0;
  int selectedMinute = 0;
  int selectedSecond = 0;

  showModalBottomSheet(
    context: context,
    isDismissible: true,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Hours",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueAccent,
                    decorationThickness: 2.0,
                  ),
                ),
                Text(
                  "Minutes",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueAccent,
                    decorationThickness: 2.0,
                  ),
                ),
                Text(
                  "Seconds",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueAccent,
                    decorationThickness: 2.0,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: CupertinoPicker(
                    scrollController:
                        FixedExtentScrollController(initialItem: selectedHour),
                    itemExtent: 32.0,
                    onSelectedItemChanged: (int value) {
                      selectedHour = value;
                    },
                    children: List<Widget>.generate(24, (int index) {
                      return Center(
                        child: Text(
                          index.toString().padLeft(2, '0'),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }),
                  ),
                ),
                Flexible(
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                        initialItem: selectedMinute),
                    itemExtent: 32.0,
                    onSelectedItemChanged: (int value) {
                      selectedMinute = value;
                    },
                    children: List<Widget>.generate(60, (int index) {
                      return Center(
                        child: Text(
                          index.toString().padLeft(2, '0'),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }),
                  ),
                ),
                Flexible(
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                        initialItem: selectedSecond),
                    itemExtent: 32.0,
                    onSelectedItemChanged: (int value) {
                      selectedSecond = value;
                    },
                    children: List<Widget>.generate(60, (int index) {
                      return Center(
                        child: Text(
                          index.toString().padLeft(2, '0'),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CupertinoButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoButton(
                  child: const Text('Confirm'),
                  onPressed: () {
                    // Set the selected time in the cubit
                    cubit.formattedTime =
                        '${selectedHour.toString().padLeft(2, '0')}:'
                        '${selectedMinute.toString().padLeft(2, '0')}:'
                        '${selectedSecond.toString().padLeft(2, '0')}';

                    cubit.updateReps(
                        exerciseIndex,
                        setIndex,
                        selectedHour.toString().padLeft(2, '0') +
                            selectedMinute.toString().padLeft(2, '0') +
                            selectedSecond.toString().padLeft(2, '0'));

                    Navigator.of(context).pop(cubit.formattedTime);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  ).then((value) {
    if (value != null) {
      (context as Element).markNeedsBuild();
    }
  });
}
