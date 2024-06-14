import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/model/client_user_model.dart';
import '../../../../data/model/diet_models/food_model.dart';
import '../../../../data/source/web_services/databases_web_services/food_data_base/all_foods_database_get_service.dart';
import 'diet_quantities_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FoodListPage extends StatelessWidget {
  final int id;

  const FoodListPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Foods',
          ),
          iconTheme: const IconThemeData(color: Colors.blueAccent),
        ),
        body: GetBuilder<DietMakingController>(
          init: DietMakingController(),
          builder: (coachHomeController) => Column(
            children: [
              TextFormField(
                controller: coachHomeController.search,
                onChanged: coachHomeController.filterFoodList,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(12), right: Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BuildFilterdList(
                coachHomeController: coachHomeController,
              ),
              Button(
                id: id,
                coachHomeController: coachHomeController,
              ),
            ],
          ),
        ));
  }
}

class Button extends StatelessWidget {
  final DietMakingController coachHomeController;
  const Button({
    super.key,
    required this.id,
    required this.coachHomeController,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: double.maxFinite,
        child: ElevatedButton(
          onPressed: () {
            Get.to(DietQuantitiesPage(
              selectedDietList: coachHomeController.selectedDietList,
              id: id,
            ));
          },
          child: const Text('Add Quantities'),
        ),
      ),
    );
  }
}

class BuildFilterdList extends StatelessWidget {
  final DietMakingController coachHomeController;
  const BuildFilterdList({
    required this.coachHomeController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      shrinkWrap: true,
      itemCount: coachHomeController.filteredFoodList.length,
      itemBuilder: (context, index) {
        bool isSelected = coachHomeController.selectedIndexes.contains(index);
        return GestureDetector(
          onTap: () {
            coachHomeController.toggleSelection(index);
            coachHomeController.update();
          },
          child: Card(
            color: isSelected ? Colors.blueAccent : const Color(0xFF1C1C1E),
            child: ListTile(
              title: Text(
                coachHomeController.filteredFoodList[index].foodName,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    ));
  }
}

class DietMakingController extends GetxController {
  static DietMakingController get instance => Get.find();
  FoodDataBase foodDataBase = FoodDataBase();
  List<ClientData> coachClients = [];
  List<FoodDataModel> foodList = [];
  List<DietData> dietData = [];
  RxList<FoodDataModel> filteredFoodList = <FoodDataModel>[].obs;
  RxList<int> selectedIndexes = <int>[].obs;
  RxList<DietModel> selectedDietList = <DietModel>[].obs;
  late TextEditingController search;
  @override
  void onInit() async {
    super.onInit();
    await foodDataBase.getFoodData();
    search = TextEditingController();
  }

  @override
  void onClose() {
    search.dispose();
    super.onClose();
  }

  void filterFoodList(String query) {
    filteredFoodList.assignAll(foodList
        .where(
            (food) => food.foodName.toLowerCase().contains(query.toLowerCase()))
        .toList());
    update(); // Update UI after filtering
  }

  void toggleSelection(int index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
      selectedDietList.removeWhere(
          (diet) => diet.foodData.id == filteredFoodList[index].id);
    } else {
      selectedIndexes.add(index);
      DietModel newDiet = DietModel(
        foodData: filteredFoodList[index],
        quantity: 1,
      );
      selectedDietList.add(newDiet);
    }
    update(); // Update UI after toggling selection
  }

  void addToDietList() {
    for (int index in selectedIndexes) {
      DietModel newDiet = DietModel(
        foodData: filteredFoodList[index],
        quantity: 1,
      );

      int existingIndex = selectedDietList
          .indexWhere((diet) => diet.foodData.id == newDiet.foodData.id);

      if (existingIndex != -1) {
        selectedDietList[existingIndex].quantity += newDiet.quantity;
      } else {
        selectedDietList.add(newDiet);
      }
    }

    selectedIndexes.clear();

    Fluttertoast.showToast(
      msg: 'Added to diet list!',
      backgroundColor: Colors.green,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
    );

    update(); // Update UI after adding to diet list
  }
}
