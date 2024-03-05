import 'package:hive/hive.dart';

class Exercise {
  String name;
  int sets;
  int reps;
  int rir;
  int rest;
  double lastWeight;

  Exercise(this.name, this.sets, this.reps, this.rir,this.rest, this.lastWeight);

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      json['excersisename'] ?? 'N/A',
      int.parse(json['sets'].toString()),
      int.parse(json['reps'].toString()),
      int.parse(json['rir'].toString()),
      int.parse(json['rest'].toString()),
      json['lastWeight'] != null ? double.parse(json['lastWeight'].toString()) : 0.0,
    );
  }
}


@HiveType(typeId: 1)
class ExerciseAdapter extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int sets;
  @HiveField(2)
  int reps;
  @HiveField(3)
  int rir;
  @HiveField(4)
  int rest;
  @HiveField(5)
  double lastWeight;

  ExerciseAdapter(this.name, this.sets, this.reps, this.rir, this.rest, this.lastWeight);
}
