class ClientNavigationBarState {
  final int selectedIndex;

  ClientNavigationBarState({required this.selectedIndex});

  ClientNavigationBarState copyWith({int? selectedIndex}) {
    return ClientNavigationBarState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
