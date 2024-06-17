import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/features/modules/client/phases_cases/waiting_phase/data/models/current_stage_request_body.dart';
import '../../../../../../../core/utils/constants/colors.dart';
import '../../../../../../../main.dart';
import '../../data/repository/current_state_repo_impl.dart';
import 'current_stage_state.dart';

class CurrentStageCubit extends Cubit<CurrentStageState> {
  final CurrentStateRepoImpl currentStateRepoImpl;
  CurrentStageCubit({required this.currentStateRepoImpl})
      : super(CurrentStageInitial());

  bool logSettingsExpanded = false;
  Future<void> getCurrentStage() async {
    try {
      emit(CurrentStageLoading());
      var response = await currentStateRepoImpl.getCurrentStage(
          CurrentStageRequestBody(
              id: myServices.sharedPreferences.getInt("user")!.toInt()));
      emit(CurrentStageUpdate(response));
    } catch (e) {
      emit(CurrentStageError(e.toString()));
    }
  }

  void toggleLogSettingsExpanded(response) {
    logSettingsExpanded = !logSettingsExpanded;
    emit(CurrentStageUpdate(response));
  }

  toggleUpdateLogSettingsExpanded(response) {
    emit(CurrentStageUpdate(response));
  }

  void showNumberPicker(
      {required BuildContext context,
      required int minValue,
      required int maxValue,
      required Color fontColor,
      required Function(int) onSelected}) {
    int selectedValue = minValue;

    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 300.h,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 200.h,
                child: CupertinoPicker(
                  backgroundColor: Colors.white,
                  itemExtent: 32.0,
                  onSelectedItemChanged: (int index) {
                    selectedValue = minValue + index;
                  },
                  children: List<Widget>.generate(
                    maxValue - minValue + 1,
                    (int index) {
                      return Center(
                        child: Text(
                          '${minValue + index}',
                          style: TextStyle(color: fontColor),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CupertinoButton(
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoButton(
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: CColors.primary,
                      ),
                    ),
                    onPressed: () {
                      onSelected(selectedValue);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
