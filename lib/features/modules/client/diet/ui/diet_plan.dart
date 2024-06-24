import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/features/modules/client/diet/data/models/diet_response.dart';
import 'package:followupapprefactored/features/modules/coach/all_clients_display/data/models/clients_response.dart';
import 'package:followupapprefactored/features/modules/coach/diet_making_features/food_selection/ui/food_selection_page.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/helpers/helper_functions.dart';
import '../logic/cubit/diet_cubit.dart';
import '../logic/cubit/diet_state.dart';

class DietPlanPage extends StatelessWidget {
  const DietPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      //   appBar: const CustomAppBar(showBackArrow: false, title: "Diet"),
      body: BlocBuilder<DietCubit, DietState>(
        builder: (context, state) {
          if (state is DietLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DietError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is DietNoData) {
            return const Center(child: Text('No Diet Plan available'));
          } else if (state is DietLoaded) {
            return LoadedDataUi(
              dark: dark,
              state: state,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class LoadedDataUi extends StatelessWidget {
  const LoadedDataUi({
    super.key,
    required this.dark,
    required this.state,
  });
  final bool dark;
  final DietLoaded state;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<DietCubit>(context);

    // Add a ValueNotifier to hold the selected food item data.
    final selectedFoodNotifier = ValueNotifier<Map<String, dynamic>?>(null);

    double totalCalories = state.dietData.dietData!
        .map((e) => e.calories * e.quantity)
        .reduce((value, element) => value + element);
    double energyPercentage = (totalCalories / state.dietData.tdee!) * 100;

    double totalProtein = state.dietData.dietData!
        .map((e) => e.protein * e.quantity)
        .reduce((value, element) => value + element);
    double proteinPercentage =
        (totalProtein / state.dietData.targetProtein!) * 100;

    double totalCarbohydrate = state.dietData.dietData!
        .map((e) => e.carbohydrates * e.quantity)
        .reduce((value, element) => value + element);
    double carbohydrateNeed = (state.dietData.tdee! * 0.30) / 4;

    double carbohydratePercentage =
        (totalCarbohydrate / carbohydrateNeed) * 100;

    double totalFat = state.dietData.dietData!
        .map((e) => e.fats * e.quantity)
        .reduce((value, element) => value + element);

    // Calculate fat need (30% of TDEE divided by 9)
    double fatNeed = (state.dietData.tdee! * 0.30) / 9;

    // Calculate the percentage of fat need met
    double fatPercentage = (totalFat / fatNeed) * 100;

    // Ensure the percentage does not exceed 100%
    double displayFatPercentage = fatPercentage > 100 ? 1 : fatPercentage / 100;

    return Scaffold(
      body: Column(
        children: [
          ValueListenableBuilder<Map<String, dynamic>?>(
            valueListenable: selectedFoodNotifier,
            builder: (context, selectedFood, child) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10.h),
                decoration: BoxDecoration(
                  color: dark ? const Color(0xff272A3B) : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text(
                              "Your daily report ",
                              style: TextStyle(
                                  fontSize: 20.sp, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.more_vert,
                                  color: dark ? Colors.white : Colors.black),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Energy - ${selectedFood != null ? selectedFood['calories'].floor() : totalCalories.toInt()} / ${state.dietData.tdee} kcal"),
                            Text(
                                "${selectedFood != null ? selectedFood['caloriesPercentage'].floor() : energyPercentage.floor()} %"),
                          ],
                        ),
                      ),
                      LinearPercentIndicator(
                        barRadius: const Radius.circular(10),
                        animation: true,
                        lineHeight: 10.h,
                        backgroundColor: const Color(0xff414252),
                        percent: selectedFood != null
                            ? (selectedFood['caloriesPercentage'] > 100
                                ? 1
                                : selectedFood['caloriesPercentage'] / 100)
                            : (energyPercentage > 100
                                ? 1
                                : energyPercentage / 100),
                        progressColor: dark ? Colors.white : CColors.dark,
                      ),
                      SizedBox(height: 5.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Protein - ${selectedFood != null ? selectedFood['protein'].floor() : totalProtein.toInt()} / ${state.dietData.targetProtein} g"),
                                Text(
                                    "${selectedFood != null ? selectedFood['proteinPercentage'].floor() : proteinPercentage.floor()} %"),
                              ],
                            ),
                          ),
                          LinearPercentIndicator(
                            barRadius: const Radius.circular(10),
                            animation: true,
                            lineHeight: 10.h,
                            backgroundColor: const Color(0xff414252),
                            percent: selectedFood != null
                                ? (selectedFood['proteinPercentage'] > 100
                                    ? 1
                                    : selectedFood['proteinPercentage'] / 100)
                                : (proteinPercentage > 100
                                    ? 1
                                    : proteinPercentage / 100),
                            progressColor: dark ? Colors.green : Colors.green,
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Total Carbohydrates - ${selectedFood != null ? selectedFood['carbohydrates'].floor() : totalCarbohydrate.toInt()} g"),
                                Text(
                                    "${selectedFood != null ? selectedFood['carbohydratesPercentage'].floor() : carbohydratePercentage.floor()} %"),
                              ],
                            ),
                          ),
                          LinearPercentIndicator(
                            barRadius: const Radius.circular(10),
                            animation: true,
                            lineHeight: 10.h,
                            backgroundColor: const Color(0xff414252),
                            percent: selectedFood != null
                                ? (selectedFood['carbohydratesPercentage'] > 100
                                    ? 1
                                    : selectedFood['carbohydratesPercentage'] /
                                        100)
                                : (carbohydratePercentage > 100
                                    ? 1
                                    : carbohydratePercentage / 100),
                            progressColor: dark ? Colors.yellow : Colors.yellow,
                          )
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Total Fats - ${selectedFood != null ? selectedFood['fats'].floor() : totalFat.toInt()} g"),
                                Text(
                                    "${selectedFood != null ? selectedFood['fatPercentage'].floor() : fatPercentage.floor()} %"),
                              ],
                            ),
                          ),
                          LinearPercentIndicator(
                            barRadius: const Radius.circular(10),
                            animation: true,
                            lineHeight: 10.h,
                            backgroundColor: const Color(0xff414252),
                            percent: selectedFood != null
                                ? (selectedFood['fatPercentage'] > 100
                                    ? 1
                                    : selectedFood['fatPercentage'] / 100)
                                : displayFatPercentage,
                            progressColor: dark ? Colors.red : Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: FoodsListView(
                state: state,
                totalCalories: totalCalories,
                totalProtein: totalProtein,
                totalCarbohydrate: totalCarbohydrate,
                totalFat: totalFat,
                selectedFoodNotifier: selectedFoodNotifier,
                cubit: cubit),
          ),
        ],
      ),
    );
  }
}

class FoodsListView extends StatefulWidget {
  const FoodsListView({
    super.key,
    required this.state,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbohydrate,
    required this.totalFat,
    required this.selectedFoodNotifier,
    required this.cubit,
  });

  final DietLoaded state;
  final double totalCalories;
  final double totalProtein;
  final double totalCarbohydrate;
  final double totalFat;
  final ValueNotifier<Map<String, dynamic>?> selectedFoodNotifier;
  final DietCubit cubit;

  @override
  State<FoodsListView> createState() => _FoodsListViewState();
}

class _FoodsListViewState extends State<FoodsListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 5.h),
      shrinkWrap: true,
      itemCount: widget.state.dietData.dietData!.length,
      itemBuilder: (context, index) {
        final foodItem = widget.state.dietData.dietData![index];

        return Dismissible(
          key: Key(foodItem.foodName), // Unique key for each item
          background: Container(
            color: Colors.blueGrey,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Icon(Icons.edit, color: Colors.white),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            widget.state.dietData.dietData!.removeAt(index);

            // Get.to(FoodSelection(clientData: ClientData()));
          },
          child: GestureDetector(
            onTap: () {
              final foodItem = widget.state.dietData.dietData![index];

              // Check if the item is already selected
              if (foodItem.isSelected) {
                // Deselect the item
                foodItem.isSelected = false;
              } else {
                // Deselect any previously selected food item
                for (var item in widget.state.dietData.dietData!) {
                  if (item.isSelected) {
                    item.isSelected = false;
                    break; // Exit loop after deselecting the first selected item
                  }
                }

                foodItem.isSelected = true;
              }

              if (foodItem.isSelected) {
                // Calculate nutritional information for the selected food item
                final foodCalories = foodItem.calories * foodItem.quantity;
                final foodProtein = foodItem.protein * foodItem.quantity;
                final foodCarbohydrate =
                    foodItem.carbohydrates * foodItem.quantity;
                final foodFat = foodItem.fats * foodItem.quantity;

                final foodCaloriesPercentage =
                    (foodCalories / widget.totalCalories) * 100;
                final foodProteinPercentage =
                    (foodProtein / widget.totalProtein) * 100;
                final foodCarbohydratePercentage =
                    (foodCarbohydrate / widget.totalCarbohydrate) * 100;
                final foodFatPercentage = (foodFat / widget.totalFat) * 100;

                // Update selectedFoodNotifier with the nutritional information of the selected food item
                widget.selectedFoodNotifier.value = {
                  'name': foodItem.foodName,
                  'calories': foodCalories,
                  'caloriesPercentage': foodCaloriesPercentage,
                  'protein': foodProtein,
                  'proteinPercentage': foodProteinPercentage,
                  'carbohydrates': foodCarbohydrate,
                  'carbohydratesPercentage': foodCarbohydratePercentage,
                  'fats': foodFat,
                  'fatPercentage': foodFatPercentage,
                };
              } else {
                widget.selectedFoodNotifier.value = null;
              }

              setState(() {});
            },
            child: SizedBox(
              height: 50.h,
              child: Card(
                color: foodItem.isSelected
                    ? Colors.blueAccent
                    : const Color(0xff272A3B),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Text(
                        foodItem.foodName,
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.normal),
                      ),
                      const Spacer(),
                      Text(
                        "${foodItem.quantity} g",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
