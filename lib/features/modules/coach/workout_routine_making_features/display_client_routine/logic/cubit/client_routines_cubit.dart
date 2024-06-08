import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:followupapprefactored/features/modules/client/routine/routine_get/data/models/routine_request_body.dart';
import 'package:followupapprefactored/features/modules/coach/workout_routine_making_features/display_client_routine/data/models/routine_crud_request_body.dart';
import 'package:get/get.dart';

import '../../data/repository/client_routines_repo_impl.dart';
import 'client_routines_state.dart';

class ClientRoutinsCubit extends Cubit<ClientRoutinesState> {
  final ClientRoutinesRepoImp clientRoutinesRepoImp;
  ClientRoutinsCubit({required this.clientRoutinesRepoImp})
      : super(RoutineInitial());

  TextEditingController routineName = TextEditingController();

  Future<void> getRoutine(id) async {
    try {
      emit(RoutineLoading());
      var routines = await clientRoutinesRepoImp
          .getRoutine(RoutineRequestBody(user: id.toString()));

      if (routines.isEmpty) {
        emit(RoutineNoData());
      } else {
        emit(RoutineLoadedSuccessfully(routines));
      }
    } catch (e) {
      emit(RoutineError(e.toString()));
    }
  }

  Future<void> insertRoutine(routineName, userId) async {
    try {
      emit(RoutineLoading());
      var response = await clientRoutinesRepoImp.insertRoutine(
          RoutineInsertRequestBody(routineName: routineName, userId: userId));
      showToast(response.message);
    } catch (e) {
      emit(RoutineError(e.toString()));
    }
  }

  Future<void> deleteRoutine(int routineId) async {
    try {
      emit(RoutineLoading());
      var response = await clientRoutinesRepoImp
          .deleteRoutine(RoutineDeleteRequestBody(routineId: routineId));
      showToast(response.message);
    } catch (e) {
      emit(RoutineError(e.toString()));
    }
  }

  void showMyBottomSheet(BuildContext context, int userId) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: routineName,
                decoration: const InputDecoration(
                  hintText: 'Enter text',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await insertRoutine(routineName.text, userId);
                    await getRoutine(userId);
                    Get.back();
                  },
                  child: const Text('Insert'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showCustomActionSheet(BuildContext context, routineId, userId) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              onPressed: () async {},
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(CupertinoIcons.share),
                    SizedBox(width: 22),
                    Text("Share Routine",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.control_point_duplicate),
                    SizedBox(width: 22),
                    Text("Duplicate Routine",
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 22),
                    Text("Edit Routine", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () async {
                await deleteRoutine(int.parse(routineId));
                await getRoutine(userId);
                Get.back();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(CupertinoIcons.xmark, color: Colors.red),
                    SizedBox(width: 22),
                    Text(
                      "Delete Routine",
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
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
}
