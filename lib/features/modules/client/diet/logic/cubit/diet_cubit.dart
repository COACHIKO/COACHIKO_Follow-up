// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:followupapprefactored/features/modules/client/diet/data/repository/diet_repo_impl.dart';
import 'package:get/get.dart';

import '../../data/models/diet_request_body.dart';
import 'diet_state.dart';

class DietCubit extends Cubit<DietState> {
  final DietRepoImp dietRepoImp;

  DietCubit({required this.dietRepoImp}) : super(DietInitial());

  Future<void> getDietData() async {
    emit(DietLoading());
    try {
      final dietData =
          await dietRepoImp.getDiet(DietRequestBody(clientId: "1"));
      if (dietData.isBlank!) {
        emit(DietNoData());
      } else {
        emit(DietLoaded(dietData: dietData));
      }
    } catch (e) {
      emit(DietError(message: 'Error fetching diet data $e'));
    }
  }

  void UpdateUi() {
    emit(state);
  }
}
