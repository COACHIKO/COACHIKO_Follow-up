import 'package:hive/hive.dart';

import 'exercise_model.dart';

class Routine {
  String name;
  List<Exercise> exercises;

  Routine(this.name, this.exercises);

  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      json['routineName'] ?? 'N/A',
      (json['exercises'] as List<dynamic>).map((exercise) {
        return Exercise.fromJson(exercise);
      }).toList(),
    );
  }
}




class RoutineAdapter extends TypeAdapter<Routine> {
  @override
  final int typeId = 0; // Unique identifier for this type adapter

  @override
  Routine read(BinaryReader reader) {
    // Read Routine object from binary
    return Routine(
      reader.readString(),
      reader.readList().cast<Exercise>(), // Assuming Exercise class is serializable
    );
  }

  @override
  void write(BinaryWriter writer, Routine obj) {
    // Write Routine object to binary
    writer.writeString(obj.name);
    writer.writeList(obj.exercises);
  }
}