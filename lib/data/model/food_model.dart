import 'package:hive/hive.dart';

class FoodDataModel {
  final int id;
  final String foodName;
  final String foodNameAr;
  final double calories;
  final double protein;
  final double carbohydrates;
  final double fats;

  FoodDataModel({
    required this.id,
    required this.foodName,
    required this.foodNameAr,
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fats,
  });

  factory FoodDataModel.fromJson(Map<String, dynamic> json) {
    return FoodDataModel(
      id: int.parse(json['id'].toString()),
      foodName: json['foodName'].toString(),
      foodNameAr: json['foodName_ar'].toString(),
      calories: double.parse(json['calories'].toString()),
      protein: double.parse(json['protein'].toString()),
      carbohydrates: double.parse(json['carbohydrates'].toString()),
      fats: double.parse(json['fats'].toString()),
    );
  }
}

class DietModel {
  final FoodDataModel foodData;
  int quantity;

  DietModel({
    required this.foodData,
    required this.quantity,
  });
}

class DietApiGet {
  final String status;
  final List<DietData> data;

  DietApiGet({
    required this.status,
    required this.data,
   });

  factory DietApiGet.fromJson(Map<String, dynamic> json) {
    return DietApiGet(
      status: json['status'],
      data: List<DietData>.from(
        json['data'].map((data) => DietData.fromJson(data)),
      ),
    );
  }
}

class DietData {
  final int id;

  final int foodId;
  final int quantity;
  final double calories;
  final double protein;
  final double carbohydrates;
  final double fats;
  final String foodName;
  final double tdee;
  final double targetProtien;
  final double targetCarbohdrate;
  final double targetFat;


  DietData({
    required this.id,
    required this.foodId,
    required this.quantity,
    required this.protein,
    required this.calories,
    required this.carbohydrates,
    required this.fats,
    required this.foodName,
    required this.targetFat,
    required this.tdee,
    required this.targetProtien,
    required this.targetCarbohdrate,

  });

  factory DietData.fromJson(Map<String, dynamic> json) {
    return DietData(
      id: json['id'],
      foodId: json['food_id'],
      quantity: json['quantity'],
      protein: json['protein'].toDouble(),
      calories: json['calories'].toDouble(),
      carbohydrates: json['carbohydrates'].toDouble(),
      fats: json['fats'].toDouble(),
      foodName: json['foodName'],
      tdee: json['tdee'].toDouble(),
      targetProtien: json['targetProtien'].toDouble(),
      targetCarbohdrate: json['targetCarbohdrate'].toDouble(),
      targetFat: json['targetFat'].toDouble(),


    );
  }
}



class FoodDataModelAdapter extends TypeAdapter<FoodDataModel> {
  @override
  final typeId = 3; // Unique identifier for this type in Hive.

  @override
  FoodDataModel read(BinaryReader reader) {
    return FoodDataModel(
      id: reader.readInt(),
      foodName: reader.readString(),
      foodNameAr: reader.readString(),
      calories: reader.readDouble(),
      protein: reader.readDouble(),
      carbohydrates: reader.readDouble(),
      fats: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, FoodDataModel obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.foodName);
    writer.writeString(obj.foodNameAr);
    writer.writeDouble(obj.calories);
    writer.writeDouble(obj.protein);
    writer.writeDouble(obj.carbohydrates);
    writer.writeDouble(obj.fats);
  }
}

class DietModelAdapter extends TypeAdapter<DietModel> {
  @override
  final typeId = 4; // Unique identifier for this type in Hive.

  @override
  DietModel read(BinaryReader reader) {
    return DietModel(
      foodData: reader.read() as FoodDataModel,
      quantity: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, DietModel obj) {
    writer.write(obj.foodData);
    writer.writeInt(obj.quantity);
  }
}

class DietApiGetAdapter extends TypeAdapter<DietApiGet> {
  @override
  final typeId = 5; // Unique identifier for this type in Hive.

  @override
  DietApiGet read(BinaryReader reader) {
    return DietApiGet(
      status: reader.readString(),
      data: reader.readList().cast<DietData>(),
    );
  }

  @override
  void write(BinaryWriter writer, DietApiGet obj) {
    writer.writeString(obj.status);
    writer.writeList(obj.data);
  }
}

class DietDataAdapter extends TypeAdapter<DietData> {
  @override
  final typeId = 6; // Unique identifier for this type in Hive.

  @override
  DietData read(BinaryReader reader) {
    return DietData(
      id: reader.readInt(),
      foodId: reader.readInt(),
      quantity: reader.readInt(),
      protein: reader.readDouble(),
      calories: reader.readDouble(),
      carbohydrates: reader.readDouble(),
      fats: reader.readDouble(),
      foodName: reader.readString(),
      tdee: reader.readDouble(),
      targetProtien: reader.readDouble(),
      targetCarbohdrate: reader.readDouble(),
      targetFat: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, DietData obj) {
    writer.writeInt(obj.id);
    writer.writeInt(obj.foodId);
    writer.writeInt(obj.quantity);
    writer.writeDouble(obj.protein);
    writer.writeDouble(obj.calories);
    writer.writeDouble(obj.carbohydrates);
    writer.writeDouble(obj.fats);
    writer.writeString(obj.foodName);
    writer.writeDouble(obj.tdee);
    writer.writeDouble(obj.targetProtien);
    writer.writeDouble(obj.targetCarbohdrate);
    writer.writeDouble(obj.targetFat);
  }
}
