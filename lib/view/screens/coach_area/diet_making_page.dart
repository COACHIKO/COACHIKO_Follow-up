import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/api_controller.dart';
import '../../../controller/diet_make_controller.dart';
import 'diet_quantities_page.dart';

class FoodListPage extends StatelessWidget {
  final int id;

  FoodListPage({super.key, required this.id});

  final controller = Get.put(ApiController());
  final coachHomeController = Get.find<DietMakingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        centerTitle: true,
        title: const Text('Foods',),
        iconTheme: const IconThemeData(color: Colors.blueAccent),
      ),
      body:GetBuilder<DietMakingController>(init:DietMakingController(),builder:(coachHomeController) => Column(
        children: [
          TextFormField(
            controller: coachHomeController.search,
            onChanged: coachHomeController.filterFoodList,

            decoration: const InputDecoration(
              hintText: 'Search...',
               focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blueAccent),
              ),
              enabledBorder: UnderlineInputBorder(
               ),
            ),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child:  ListView.builder(
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
            )),
          ElevatedButton(
            onPressed: (){
              Get.to(DietQuantitiesPage(selectedDietList: coachHomeController.selectedDietList, id: id,)) ;
            },
            child: const Text('Add Quantities'),
          ),
        ],
      ),
            ));
  }
}
