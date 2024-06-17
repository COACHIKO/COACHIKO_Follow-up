import 'package:equatable/equatable.dart';

class CoachHomeState extends Equatable {
  final int selectedIndex;

  const CoachHomeState({required this.selectedIndex});

  CoachHomeState copyWith({int? selectedIndex}) {
    return CoachHomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object> get props => [selectedIndex];
}
