import 'package:bloc/bloc.dart';

import 'coach_navigation_bar_state.dart';

class CoachHomeCubit extends Cubit<CoachHomeState> {
  CoachHomeCubit() : super(const CoachHomeState(selectedIndex: 0));

  void changeTabIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
