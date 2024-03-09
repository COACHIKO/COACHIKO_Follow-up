class Exercise {
  final String exerciseID;
  final String exerciseName;
  final String targetMuscles;
  final String usedEquipment;
  final String exerciseImage;
  final String exerciseId;
  final int sets;
  final int reps;
  final int rir;
  final int lastWeight;
  final int rest;
  bool isSelected;

  Exercise({
    required this.exerciseID,
    required this.exerciseName,
    required this.targetMuscles,
    required this.usedEquipment,
    required this.exerciseImage,
    required this.exerciseId,
    required this.sets,
    required this.reps,
    required this.rir,
    required this.lastWeight,
    required this.rest,
    required this.isSelected,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      exerciseID: json['excersiseID'] ?? '',
      exerciseName: json['excersiseName'] ?? '',
      targetMuscles: json['targetMuscles'] ?? '',
      usedEquipment: json['usedEquipment'] ?? '',
      exerciseImage: json['excersiseImage'] ?? '',
      exerciseId: json['excersise_id'] ?? '',
      sets: int.parse(json['sets'] ?? '0'),
      reps: int.parse(json['reps'] ?? '0'),
      rir: int.parse(json['rir'] ?? '0'),
      lastWeight: int.parse(json['lastWeight'] ?? '0'),
      rest: int.parse(json['rest'] ?? '0'),
      isSelected: false,
    );
  }
}

class Routine {
  final String routineId;
  final String routineName;
  final List<Exercise> exercises;

  Routine({
    required this.routineId,
    required this.routineName,
    required this.exercises,
  });

  factory Routine.fromJson(String routineName, Map<String, dynamic> json) {
    List<Exercise> exercises = (json['exercises'] as List<dynamic>?)
            ?.map((exerciseJson) => Exercise.fromJson(exerciseJson))
            .toList() ??
        [];

    return Routine(
      routineId: json['routine_id'] ?? '',
      routineName: routineName,
      exercises: exercises,
    );
  }
}

class WorkoutData {
  final List<Routine> routines;

  WorkoutData({required this.routines});

  factory WorkoutData.fromJson(Map<String, dynamic> json) {
    List<Routine> routines = [];
    json.forEach((routineName, routineData) {
      Routine routine = Routine.fromJson(routineName, routineData);
      routines.add(routine);
    });

    return WorkoutData(
      routines: routines,
    );
  }
}
