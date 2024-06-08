import 'package:hive/hive.dart';

part 'routine_response.g.dart';

@HiveType(typeId: 0)
class RoutineResponse {
  @HiveField(0)
  String? message;
  @HiveField(1)
  List<Routine> routines;
  @HiveField(2)
  bool? status;
  @HiveField(3)
  int? code;

  RoutineResponse({
    this.message,
    required this.routines,
    this.status,
    this.code,
  });

  factory RoutineResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List?;
    List<Routine> routines = dataList
            ?.map((routine) => Routine.fromJson(routine, routine))
            .toList() ??
        [];

    return RoutineResponse(
      message: json['message'] ?? '',
      routines: routines,
      status: json['status'] ?? false,
      code: json['code'] ?? 0,
    );
  }
}

@HiveType(typeId: 1)
class Exercise {
  @HiveField(0)
  int exerciseId;
  @HiveField(1)
  String exerciseName;
  @HiveField(2)
  String targetMuscles;
  @HiveField(3)
  String usedEquipment;
  @HiveField(4)
  String exerciseImage;
  @HiveField(5)
  int sets;
  @HiveField(6)
  int reps;
  @HiveField(7)
  int rir;
  @HiveField(8)
  double lastWeight;
  @HiveField(9)
  int rest;
  // isSelected is marked as transient and won't be stored in Hive
  bool isSelected;

  Exercise({
    required this.exerciseId,
    required this.exerciseName,
    required this.targetMuscles,
    required this.usedEquipment,
    required this.exerciseImage,
    required this.sets,
    required this.reps,
    required this.rir,
    required this.lastWeight,
    required this.rest,
    required this.isSelected,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      exerciseId: json['exerciseId'] ?? 0,
      exerciseName: json['exerciseName'] ?? '',
      targetMuscles: json['targetMuscles'] ?? '',
      usedEquipment: json['usedEquipment'] ?? '',
      exerciseImage: json['exerciseImage'] ?? '',
      sets: json['sets'] ?? 0,
      reps: json['reps'] ?? 0,
      rir: json['rir'] ?? 0,
      lastWeight: (json['lastWeight'] ?? 0).toDouble(),
      rest: json['rest'] ?? 0,
      isSelected: false,
    );
  }
}

@HiveType(typeId: 2)
class Routine {
  @HiveField(0)
  String routineId;
  @HiveField(1)
  String routineName;
  @HiveField(2)
  List<Exercise> exercises;

  Routine({
    required this.routineId,
    required this.routineName,
    required this.exercises,
  });

  factory Routine.fromJson(Map<String, dynamic> json, routineData) {
    var exercisesList = json['exercises'] as List?;
    List<Exercise> exercises = exercisesList
            ?.map((exercise) => Exercise.fromJson(exercise))
            .toList() ??
        [];

    return Routine(
      routineId: json['routine_id'] ?? '',
      routineName: json['routineName'] ?? '',
      exercises: exercises,
    );
  }
}
