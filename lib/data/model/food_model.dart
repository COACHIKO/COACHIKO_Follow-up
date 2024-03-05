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
