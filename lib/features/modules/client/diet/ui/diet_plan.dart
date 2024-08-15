import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:followupapprefactored/features/modules/client/diet/data/models/diet_response.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/helpers/helper_functions.dart';
import '../../../coach/diet_making_features/food_selection/data/models/food_model.dart';
import '../../../coach/diet_making_features/food_selection/logic/cubit/food_cubit.dart';
import '../../../coach/diet_making_features/food_selection/logic/cubit/food_state.dart';
import '../../phases_cases/waiting_phase/ui/current_stage_page.dart';
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
    double fatNeed = (state.dietData.tdee! * 0.30) / 9;
    double fatPercentage = (totalFat / fatNeed) * 100;

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
                                "${selectedFood != null ? (selectedFood['caloriesPercentage'].isFinite ? selectedFood['caloriesPercentage'].floor() : 0) : (energyPercentage.isFinite ? energyPercentage.floor() : 0)} %"),
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
                                : (selectedFood['caloriesPercentage'].isFinite
                                    ? selectedFood['caloriesPercentage'] / 100
                                    : 0))
                            : (energyPercentage > 100
                                ? 1
                                : (energyPercentage.isFinite
                                    ? energyPercentage / 100
                                    : 0)),
                        progressColor: dark ? Colors.white : Colors.blueAccent,
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
                                    "${selectedFood != null ? (selectedFood['proteinPercentage'].isFinite ? selectedFood['proteinPercentage'].floor() : 0) : (proteinPercentage.isFinite ? proteinPercentage.floor() : 0)} %"),
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
                                    : (selectedFood['proteinPercentage']
                                            .isFinite
                                        ? selectedFood['proteinPercentage'] /
                                            100
                                        : 0))
                                : (proteinPercentage > 100
                                    ? 1
                                    : (proteinPercentage.isFinite
                                        ? proteinPercentage / 100
                                        : 0)),
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
                                    "${selectedFood != null ? (selectedFood['carbohydratesPercentage'].isFinite ? selectedFood['carbohydratesPercentage'].floor() : 0) : (carbohydratePercentage.isFinite ? carbohydratePercentage.floor() : 0)} %"),
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
                                    : (selectedFood['carbohydratesPercentage']
                                            .isFinite
                                        ? selectedFood[
                                                'carbohydratesPercentage'] /
                                            100
                                        : 0))
                                : (carbohydratePercentage > 100
                                    ? 1
                                    : (carbohydratePercentage.isFinite
                                        ? carbohydratePercentage / 100
                                        : 0)),
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
                                    "${selectedFood != null ? (selectedFood['fatPercentage'].isFinite ? selectedFood['fatPercentage'].floor() : 0) : (fatPercentage.isFinite ? fatPercentage.floor() : 0)} %"),
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
                                    : (selectedFood['fatPercentage'].isFinite
                                        ? selectedFood['fatPercentage'] / 100
                                        : 0))
                                : (fatPercentage > 100
                                    ? 1
                                    : (fatPercentage.isFinite
                                        ? fatPercentage / 100
                                        : 0)),
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

        return Slidable(
          key: Key(foodItem.foodName),
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(12), right: Radius.circular(12)),
                onPressed: (context) {
                  final selectedFood = widget.state.dietData.dietData![index];
                  selectedFood.isSelected = true;
                  context
                      .push(
                    Routes.dietExchange,
                    extra: widget.state.dietData.dietData,
                  )
                      .then((_) {
                    selectedFood.isSelected = false;
                  });
                },
                backgroundColor: Colors.blueGrey,
                foregroundColor: Colors.white,
                label: 'Replace',
              ),
            ],
          ),
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
              height: 52.h,
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
                            color: CColors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal),
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

class ConvertFooods extends StatelessWidget {
  final List<DietItem>? diet;
  const ConvertFooods({
    super.key,
    required this.diet,
  });

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);
    DietItem? selectedDietItem;
    FoodDataModel? selectedItem;
    double? equivalentQuantity;
    TextEditingController quantityController = TextEditingController();

    void calculateEquivalentQuantity() {
      if (selectedDietItem != null && selectedItem != null) {
        double caloriesPerGramDietItem = selectedDietItem!.calories;
        double caloriesPerGramSelectedItem = selectedItem!.calories;
        int quantityToSubstitute;

        if (quantityController.text.isEmpty) {
          quantityToSubstitute = selectedDietItem!.quantity;
        } else {
          quantityToSubstitute = int.tryParse(quantityController.text) ??
              selectedDietItem!.quantity;
        }

        equivalentQuantity = (quantityToSubstitute * caloriesPerGramDietItem) /
            caloriesPerGramSelectedItem;
      } else {
        equivalentQuantity = null;
      }
    }

    return BlocBuilder<FoodCubit, FoodsState>(
      builder: (context, state) {
        if (state is FoodsStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FoodsStateError) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is LoadedSuccessfullyFoodsState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Foods Exchange"),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: dark ? Colors.white : Colors.black,
                ),
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 100.h,
                  child: Card(
                    child: Column(
                      children: [
                        DropdownButton<DietItem>(
                          value: selectedDietItem,
                          hint: const Text('Choose food to substitute'),
                          onChanged: (DietItem? newValue) {
                            selectedDietItem = newValue!;
                            quantityController.text = '';
                            context.read<FoodCubit>().updateUi();
                          },
                          items: diet?.map((DietItem dietItem) {
                            return DropdownMenuItem<DietItem>(
                              value: dietItem,
                              child: Text(dietItem.foodName),
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Quantity to substitute"),
                              SizedBox(
                                width: 100,
                                child: TextFormField(
                                  controller: quantityController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText:
                                        "${selectedDietItem?.quantity.toString() ?? ""} g",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomMaterialButton(
                            onPressed: () {
                              calculateEquivalentQuantity();
                              context.read<FoodCubit>().updateUi();
                            },
                            buttonText: equivalentQuantity != null
                                ? "${equivalentQuantity!.floor()} grams"
                                : "Calculate",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100.h,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: Text(
                            "Choose food to substitute with",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(fontSize: 15),
                          ),
                        ),
                        DropdownSearch<FoodDataModel>(
                          popupProps: const PopupProps.menu(
                              showSelectedItems: true, showSearchBox: true),
                          items: state.foods,
                          itemAsString: (FoodDataModel u) => u.foodName,
                          onChanged: (FoodDataModel? newValue) {
                            selectedItem = newValue;
                            context.read<FoodCubit>().updateUi();
                          },
                          selectedItem: selectedItem,
                          compareFn: (FoodDataModel a, FoodDataModel b) =>
                              a.foodName == b.foodName,
                          filterFn: (FoodDataModel item, String query) {
                            return item.foodName
                                .toLowerCase()
                                .contains(query.toLowerCase());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }
}
