import 'package:bloc/bloc.dart';
import 'coach_navigation_bar_state.dart';

class CoachHomeCubit extends Cubit<CoachHomeState> {
  CoachHomeCubit({int initialIndex = 0})
      : super(CoachHomeState(selectedIndex: initialIndex));

  void changeTabIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
