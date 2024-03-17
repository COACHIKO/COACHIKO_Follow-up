import 'package:hive/hive.dart';

import 'exercise_model.dart';


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

