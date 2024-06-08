import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:followupapprefactored/core/networking/api_service.dart';
import 'package:followupapprefactored/features/modules/client/routine/routine_get/data/models/routine_response.dart';
import 'package:followupapprefactored/features/modules/coach/workout_routine_making_features/specific_routine_/display_client_routine/data/repository/edit_routines_repo_impl.dart';
import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../core/utils/constants/image_strings.dart';
import '../../../display_client_routine/data/models/routine_crud_request_body.dart';
import '../logic/cubit/edit_routine_state.dart';

class WorkoutRoutinePreview extends StatelessWidget {
  final Routine routine;

  const WorkoutRoutinePreview({super.key, required this.routine});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: BlocProvider(
        create: (context) => EditRoutineCubit(
            editRoutineRepoImp: EditRoutineRepoImp(ApiService(Dio())),
            routine: routine),
        child: const WorkoutRoutinePreviewBody(),
      )),
    );
  }
}

class EditRoutineCubit extends Cubit<EditRoutineState> {
  final Routine routine;
  final EditRoutineRepoImp editRoutineRepoImp;
  EditRoutineCubit({
    required this.editRoutineRepoImp,
    required this.routine,
  }) : super(EditRoutineInitial());

  TextEditingController routineName = TextEditingController();
  void updateRoutine(Routine routine) {
    emit(EditRoutineUpdate(routine));
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> updateRoutineName(String routineName, int routineId) async {
    try {
      var response = await editRoutineRepoImp.updateRoutineName(
          RoutineUpdateRequestBody(
              routineName: routineName, routineId: routineId));
      showToast(response.message);
    } catch (e) {
      emit(EditRoutineError(e.toString()));
    }
  }
}

class WorkoutRoutinePreviewBody extends StatelessWidget {
  const WorkoutRoutinePreviewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<EditRoutineCubit>();

    //  var dark = THelperFunctions.isDarkMode(context);
    return BlocBuilder<EditRoutineCubit, EditRoutineState>(
        builder: (context, state) {
      if (state is EditRoutineError) {
        return Center(child: Text('Error: ${state.error}'));
      } else {
        return SafeArea(
            child: Scaffold(
                backgroundColor: Colors.black,
                appBar: AppBar(
                  actions: [
                    GestureDetector(
                      onTap: () async {
                        await cubit.updateRoutineName(
                            cubit.routineName.text.isNotEmpty
                                ? cubit.routineName.text
                                : cubit.routine.routineName,
                            int.parse(cubit.routine.routineId));

                        cubit.routine.routineName =
                            cubit.routineName.text.isNotEmpty
                                ? cubit.routineName.text
                                : cubit.routine.routineName;
                        cubit.updateRoutine(cubit.routine);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Text(
                          textAlign: TextAlign.start,
                          "Update",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                  fontSize: 14.sp,
                                  color: const Color(0xFF2d7ed9)),
                        ),
                      ),
                    )
                  ],
                  backgroundColor: const Color(0xFF1c1c1e),
                  centerTitle: true,
                  title: Text(cubit.routine.routineName),
                  iconTheme: const IconThemeData(color: Colors.blueAccent),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) => {cubit.routineName.text = value},
                        initialValue: cubit.routine.routineName,
                        decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF4d4d4d))),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF4d4d4d))),
                            // hintText: cubit.routine.routineName,
                            suffixIcon: IconButton(
                                onPressed: () {
                                 cubit.routine.routineName ;
                                  cubit.updateRoutine(cubit.routine);
                                  // String exerciseNames = cubit.routine.exercises
                                  //     .map((exercise) => exercise.exerciseId)
                                  //     .join(', ');
                                  // String numSets = cubit.routine.exercises
                                  //     .map((exercise) =>
                                  //         exercise.sets.toString())
                                  //     .join(', ');
                                  // print('$exerciseNames');
                                  // print('$numSets');
                                },
                                icon: const Icon(Icons.cancel))),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cubit.routine.exercises.length,
                          itemBuilder: (context, exerciseIndex) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      child: ClipOval(
                                        child: Image(
                                          image: AssetImage(
                                            TImages.excersiseDirectory +
                                                cubit
                                                    .routine
                                                    .exercises[exerciseIndex]
                                                    .exerciseImage,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Text(
                                      cubit.routine.exercises[exerciseIndex]
                                          .exerciseName,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.timer,
                                      color: Colors.blue,
                                      size: 22,
                                    ),
                                    Text(
                                      " Rest Timer: ${cubit.routine.exercises[exerciseIndex].rest} Mins",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 15.sp),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("SET"),
                                  ],
                                ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: cubit
                                      .routine.exercises[exerciseIndex].sets,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6.0.w),
                                          child: Text("${index + 1}"),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: double.maxFinite,
                                  child: MaterialButton(
                                    shape: const OutlineInputBorder(
                                      borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(5),
                                        right: Radius.circular(5),
                                      ),
                                    ),
                                    onPressed: () async {
                                      cubit.routine.exercises[exerciseIndex]
                                          .sets++;
                                      cubit.updateRoutine(cubit.routine);
                                    },
                                    color: CColors.primary,
                                    child: const Text(
                                      'Add Set +',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )));
      }
    });
  }
}
