 // part 'exercise.g.dart'; // Generate this file using hive_generator

// @HiveType(typeId: 1)
// class Exercise {
//   String name;
//   String image;
//   int excersiseID;
//   int sets;
//   int reps;
//   int rir;
//   int rest;
//   double lastWeight;
//   Exercise(this.name,this.image,this.excersiseID,this.sets,this.reps,this.rir,this.rest,this.lastWeight);
//   factory Exercise.fromJson(Map<String, dynamic> json) {
//     return Exercise(
//       json['excersiseName'] ?? 'N/A',
//       json['excersiseImage'] ?? 'N/A',
//       int.parse(json['excersiseID'].toString()),
//       int.parse(json['sets'].toString()),
//       int.parse(json['reps'].toString()),
//       int.parse(json['rir'].toString()),
//       int.parse(json['rest'].toString()),
//       json['lastWeight'] != null ? double.parse(json['lastWeight'].toString()) : 0.0,
//     );
//   }
// }
//
// class ExerciseData {
//   String name;
//   String image;
//    int excersiseID;
//
//   ExerciseData(this.name, this.image,this.excersiseID);
//
//   factory ExerciseData.fromJson(Map<String, dynamic> json) {
//     return ExerciseData(
//       json['excersiseName'] ?? 'N/A',
//       json['excersiseImage'] ?? 'N/A',
//        json['excersiseID'] as int, // Assuming excersiseID is always an int in JSON
//     );
//   }
// }

