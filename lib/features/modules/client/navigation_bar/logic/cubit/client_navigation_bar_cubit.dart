import 'package:bloc/bloc.dart';
import 'client_navigation_bar_state.dart';

class ClientNavigationBarCubit extends Cubit<ClientNavigationBarState> {
  ClientNavigationBarCubit({int initialIndex = 0})
      : super(ClientNavigationBarState(selectedIndex: initialIndex));

  void changeTabIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
