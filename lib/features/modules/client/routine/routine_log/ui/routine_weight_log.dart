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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("SET"),
                          Text("PREVIOUS"),
                          Text("KG"),
                          Text("REPS"),
                          Icon(
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
                                  : Colors.black,
                              child: Row(
                                children: [
                                  Text("${setIndex + 1}"),
                                  const Spacer(),
                                  SizedBox(width: 37.w),
                                  Text(
                                      "${routine.exercises[exerciseIndex].lastWeight} KG"),
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
                                  Flexible(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        context
                                            .read<RoutineWeightLogCubit>()
                                            .updateReps(
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
                  await cubit.submitAndLogRoutine(1);
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
