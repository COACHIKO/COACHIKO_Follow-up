import 'package:hive/hive.dart';

import 'routine_model.dart';

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

