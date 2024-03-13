import 'package:hive/hive.dart';

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


class ExerciseAdapter extends TypeAdapter<Exercise> {
  @override
  final typeId = 0; // Unique identifier for the model

  @override
  Exercise read(BinaryReader reader) {
    return Exercise(
      exerciseID: reader.read(),
      exerciseName: reader.read(),
      targetMuscles: reader.read(),
      usedEquipment: reader.read(),
      exerciseImage: reader.read(),
      exerciseId: reader.read(),
      sets: reader.read(),
      reps: reader.read(),
      rir: reader.read(),
      lastWeight: reader.read(),
      rest: reader.read(),
      isSelected: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Exercise obj) {
    writer.write(obj.exerciseID);
    writer.write(obj.exerciseName);
    writer.write(obj.targetMuscles);
    writer.write(obj.usedEquipment);
    writer.write(obj.exerciseImage);
    writer.write(obj.exerciseId);
    writer.write(obj.sets);
    writer.write(obj.reps);
    writer.write(obj.rir);
    writer.write(obj.lastWeight);
    writer.write(obj.rest);
    writer.write(obj.isSelected);
  }
}

class RoutineAdapter extends TypeAdapter<Routine> {
  @override
  final typeId = 1; // Unique identifier for the model

  @override
  Routine read(BinaryReader reader) {
    return Routine(
      routineId: reader.read(),
      routineName: reader.read(),
      exercises: reader.readList().cast<Exercise>(),
    );
  }

  @override
  void write(BinaryWriter writer, Routine obj) {
    writer.write(obj.routineId);
    writer.write(obj.routineName);
    writer.writeList(obj.exercises);
  }
}

class WorkoutDataAdapter extends TypeAdapter<WorkoutData> {
  @override
  final typeId = 2; // Unique identifier for the model

  @override
  WorkoutData read(BinaryReader reader) {
    return WorkoutData(
      routines: reader.readList().cast<Routine>(),
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutData obj) {
    writer.writeList(obj.routines);
  }
}
