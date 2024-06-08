// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoutineResponseAdapter extends TypeAdapter<RoutineResponse> {
  @override
  final int typeId = 0;

  @override
  RoutineResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoutineResponse(
      message: fields[0] as String?,
      routines: (fields[1] as List).cast<Routine>(),
      status: fields[2] as bool?,
      code: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, RoutineResponse obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.routines)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.code);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutineResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExerciseAdapter extends TypeAdapter<Exercise> {
  @override
  final int typeId = 1;

  @override
  Exercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exercise(
      exerciseId: fields[0] as int,
      exerciseName: fields[1] as String,
      targetMuscles: fields[2] as String,
      usedEquipment: fields[3] as String,
      exerciseImage: fields[4] as String,
      sets: fields[5] as int,
      reps: fields[6] as int,
      rir: fields[7] as int,
      lastWeight: fields[8] as double,
      rest: fields[9] as int,
      isSelected: false,
    );
  }

  @override
  void write(BinaryWriter writer, Exercise obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.exerciseId)
      ..writeByte(1)
      ..write(obj.exerciseName)
      ..writeByte(2)
      ..write(obj.targetMuscles)
      ..writeByte(3)
      ..write(obj.usedEquipment)
      ..writeByte(4)
      ..write(obj.exerciseImage)
      ..writeByte(5)
      ..write(obj.sets)
      ..writeByte(6)
      ..write(obj.reps)
      ..writeByte(7)
      ..write(obj.rir)
      ..writeByte(8)
      ..write(obj.lastWeight)
      ..writeByte(9)
      ..write(obj.rest);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RoutineAdapter extends TypeAdapter<Routine> {
  @override
  final int typeId = 2;

  @override
  Routine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Routine(
      routineId: fields[0] as String,
      routineName: fields[1] as String,
      exercises: (fields[2] as List).cast<Exercise>(),
    );
  }

  @override
  void write(BinaryWriter writer, Routine obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.routineId)
      ..writeByte(1)
      ..write(obj.routineName)
      ..writeByte(2)
      ..write(obj.exercises);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
