// import 'package:followupapprefactored/features/modules/client/features/routine/data/models/routine_response.dart';
// import 'package:hive/hive.dart';

// class WorkoutData {
//   final List<Routine> routines;

//   WorkoutData({required this.routines});

//   factory WorkoutData.fromJson(Map<String, dynamic> json) {
//     List<Routine> routines = [];
//     json.forEach((routineName, routineData) {
//       Routine routine =
//           Routine.fromJson(routineName as Map<String, dynamic>, routineData);
//       routines.add(routine);
//     });

//     return WorkoutData(
//       routines: routines,
//     );
//   }
// }

// class WorkoutDataAdapter extends TypeAdapter<WorkoutData> {
//   @override
//   final typeId = 2; // Unique identifier for the model

//   @override
//   WorkoutData read(BinaryReader reader) {
//     return WorkoutData(
//       routines: reader.readList().cast<Routine>(),
//     );
//   }

//   @override
//   void write(BinaryWriter writer, WorkoutData obj) {
//     writer.writeList(obj.routines);
//   }
// }
