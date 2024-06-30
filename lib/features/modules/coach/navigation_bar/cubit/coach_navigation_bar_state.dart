class CoachHomeState {
  final int selectedIndex;

  CoachHomeState({required this.selectedIndex});

  CoachHomeState copyWith({int? selectedIndex}) {
    return CoachHomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
