import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/core/utils/constants/colors.dart';
import 'package:followupapprefactored/core/utils/helpers/helper_functions.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/routing/routes.dart';
import '../../../all_clients_display/data/models/clients_response.dart';
import '../../food_selection/data/models/food_model.dart';
import 'package:followupapprefactored/features/modules/coach/diet_making_features/quantities_entering/data/models/quantity_insertion_request_body.dart';
import '../logic/cubit/food_quantities_cubit.dart';
import '../logic/cubit/food_quantities_state.dart';

class FoodQuantitiesEntering extends StatelessWidget {
  final ClientData clientData;

  final List<FoodDataModel> selectedFoods;
  const FoodQuantitiesEntering(
      {super.key, required this.selectedFoods, required this.clientData});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodQuantitiesCubit, FoodQuantitiesStates>(
        builder: (context, state) {
      final cubit = BlocProvider.of<FoodQuantitiesCubit>(context);
      final dark = THelperFunctions.isDarkMode(context);

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Enter Quantities'),
          iconTheme: const IconThemeData(color: Colors.blueAccent),
        ),
        body: Column(
          children: [
            Column(children: [
              Container(
                height: 45.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: dark ? Colors.white : CColors.dark,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${"Calories"}\n ${clientData.tdee}",
                      style: TextStyle(
                        color: dark ? Colors.black : Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${"Protien"}\n ${clientData.targetProtien}",
                      style: TextStyle(
                        color: dark ? Colors.black : Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${"Carbohydrate"}\n ${clientData.targetCarbohydrate}",
                      style: TextStyle(
                        color: dark ? Colors.black : Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${"Fat"}\n ${clientData.targetFat}",
                      style: TextStyle(
                        color: dark ? Colors.black : Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 45.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: dark ? CColors.black : CColors.lightContainer,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${"Calories"}\n ${cubit.calculateTotalCalories(selectedFoods).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${"Protien"}\n ${cubit.calculateTotalProtien(selectedFoods).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${"Carbohydrate"}\n ${cubit.calculateTotalCarbohydrate(selectedFoods).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${"Fat"}\n ${cubit.calculateTotalFat(selectedFoods).toStringAsFixed(1)}",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: selectedFoods.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: dark ? CColors.black : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 8),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(selectedFoods[index].foodName),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      cubit.onTextChanged(value, index);
                                    },
                                    controller: cubit.controllers[index],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Calories\n${((selectedFoods[index].calories) * (int.tryParse(cubit.controllers[index].text) ?? 0)).toStringAsFixed(2)}"),
                                Text(
                                    "Protien\n${((selectedFoods[index].protein) * (int.tryParse(cubit.controllers[index].text) ?? 0)).toStringAsFixed(2)}"),
                                Text(
                                    "Carbohydrates\n${((selectedFoods[index].carbohydrates) * (int.tryParse(cubit.controllers[index].text) ?? 0)).toStringAsFixed(2)}"),
                                Text(
                                    "Fats\n${((selectedFoods[index].fats) * (int.tryParse(cubit.controllers[index].text) ?? 0)).toStringAsFixed(2)}"),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  final foodNamesAndQuantities =
                      cubit.getFoodNamesAndQuantities(selectedFoods);
                  String foodNames = foodNamesAndQuantities.value1;
                  String quantities = foodNamesAndQuantities.value2;
                  await cubit.enterQuantities(QuantityInsertionRequestBody(
                      clientId: clientData.id!,
                      foodId: foodNames,
                      quantity: quantities));

                  context.go(Routes.coachHome);
                },
                child: const Text("Submit Quantities"),
              ),
            ),
          ],
        ),
      );
    });
  }
}
