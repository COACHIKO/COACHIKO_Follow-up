import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/api_controller.dart';
import '../../../controller/diet_insertion_controller.dart';
import '../../../controller/diet_preview_controller.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../data/model/food_model.dart';
import 'coach_home_page.dart';

class DietQuantitiesPage extends StatelessWidget {
  final List<DietModel> selectedDietList;
  final int id;

   DietQuantitiesPage({
    super.key,
    required this.selectedDietList,
    required this.id,
  });

  final DietQuantitiesController dietQuantitiesController = Get.put(DietQuantitiesController());
  final DietDataController dietDataController = Get.put(DietDataController());
  final ApiController apiController = Get.put(ApiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        centerTitle: true,
         title: const Text('Diet Quantities',),
      ),
      body: Obx(() {
        if (dietQuantitiesController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: selectedDietList.length,
            itemBuilder: (context, index) {
              return Card(
                color:   CColors.primary,
                child: ListTile(
                  title: Text(
                    selectedDietList[index].foodData.foodName,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Row(
                    children: [
                      const Text(
                        'Quantity: ',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 50,
                        child: TextFormField(
                          initialValue: selectedDietList[index].quantity.toString(),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            int newQuantity = int.tryParse(value) ?? 0;
                            // Update the quantity in the original list
                            selectedDietList[index].quantity = newQuantity;
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: 'Qty',
                            hintStyle: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          //widget.selectedDietList.forEach((element) {print("${element.foodData.foodName} : ${element.quantity} ");});
          await dietQuantitiesController.insertDietData(selectedDietList, id,selectedDietList.length);
          await dietDataController.fetchData();
             Get.offAll(const CoachHome());
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
