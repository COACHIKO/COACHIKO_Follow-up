import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/coach_controllers/diet_making_controllers/diet_make_controller.dart';
import 'diet_quantities_page.dart';

class FoodListPage extends StatelessWidget {
  final int id;

  FoodListPage({super.key, required this.id});

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
               focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(12),right: Radius.circular(12)),
                borderSide: BorderSide(color: Colors.blueAccent),
              ),

            ),
          ),
          const SizedBox(height: 10,),
          BuildFilterdList(coachHomeController: coachHomeController,),
          Button(id: id,coachHomeController: coachHomeController,),
        ],
      ),));
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
      child: SizedBox( width:  double.maxFinite,
        child: ElevatedButton(
          onPressed: (){
            Get.to(DietQuantitiesPage(selectedDietList: coachHomeController.selectedDietList, id: id,)) ;
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
      child:ListView.builder(
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
