import 'package:equatable/equatable.dart';
import 'package:followupapprefactored/features/modules/client/diet/data/models/diet_response.dart';

abstract class DietState extends Equatable {
  const DietState();

  @override
  List<Object> get props => [];
}

class DietInitial extends DietState {}

class DietLoading extends DietState {}

class DietLoaded extends DietState {
  final List<DietItem> dietItems;

  const DietLoaded({required this.dietItems});
}

class DietError extends DietState {
  final String message;

  const DietError({required this.message});

  @override
  List<Object> get props => [message];
}

class DietNoData extends DietState {}
