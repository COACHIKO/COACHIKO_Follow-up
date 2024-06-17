import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/core/networking/api_service.dart';
import 'package:followupapprefactored/features/modules/coach/diet_making_features/quantities_entering/ui/food_quantities_insertion.dart';
import 'package:get/get.dart';
import '../../../../../../core/utils/constants/sizes.dart';
import '../../../../client/phases_cases/form_completion/logic/cubit/form_completion_cubit.dart';
import '../../../all_clients_display/data/models/clients_response.dart';
import '../data/repository/foods_repo_impl.dart';
import '../logic/cubit/food_cubit.dart';
import '../logic/cubit/food_state.dart';

class FoodSelection extends StatelessWidget {
  final ClientData clientData;

  const FoodSelection({super.key, required this.clientData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Foods'),
        iconTheme: const IconThemeData(color: Colors.blueAccent),
      ),
      body: BlocProvider(
        create: (context) => FoodCubit(
            foodsRepoImpl: FoodsRepoImpl(ApiService(Dio())), selectedfoods: [])
          ..getFoods(),
        child: FoodDataWidget(
          clientData: clientData,
        ),
      ),
    );
  }
}

class FoodDataWidget extends StatelessWidget {
  final ClientData clientData;

  const FoodDataWidget({super.key, required this.clientData});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodCubit, FoodsState>(
      builder: (context, state) {
        if (state is FoodsStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FoodsStateError) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is LoadedSuccessfullyFoodsState) {
          return Column(
            children: [
              TextFormField(
                onChanged: (query) async {
                  context.read<FoodCubit>().searchFoods();
                },
                controller: context.read<FoodCubit>().searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(12),
                      right: Radius.circular(12),
                    ),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.foods.length,
                  itemBuilder: (context, index) {
                    final food = state.foods[index];
                    return GestureDetector(
                      onTap: () {
                        context.read<FoodCubit>().toggleFoodSelection(food);
                      },
                      child: Card(
                        color: food.isSelected
                            ? Colors.blueAccent.withOpacity(0.5)
                            : null,
                        child: ListTile(
                          title: Text(
                            food.foodName,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              context.read<FoodCubit>().selectedFoods().isNotEmpty
                  ? SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(FoodQuantitiesEntering(
                            clientData: clientData,
                            selectedFoods:
                                context.read<FoodCubit>().selectedFoods(),
                          ));
                        },
                        child: const Text("Add Quantities"),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }
}

class FoodDataWidget2 extends StatelessWidget {
  const FoodDataWidget2({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodCubit, FoodsState>(
      builder: (context, state) {
        if (state is FoodsStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FoodsStateError) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is LoadedSuccessfullyFoodsState) {
          return Column(
            children: [
              TextFormField(
                onChanged: (query) async {
                  context.read<FoodCubit>().searchFoods();
                },
                controller: context.read<FoodCubit>().searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(12),
                      right: Radius.circular(12),
                    ),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.foods.length,
                  itemBuilder: (context, index) {
                    final food = state.foods[index];
                    return GestureDetector(
                      onTap: () {
                        context.read<FoodCubit>().toggleFoodSelection(food);
                        BlocProvider.of<FormCompletionCubit>(context)
                                .selectedFoods =
                            context.read<FoodCubit>().selectedFoods();
                      },
                      child: Card(
                        color: food.isSelected
                            ? Colors.blueAccent.withOpacity(0.5)
                            : null,
                        child: ListTile(
                          title: Text(
                            food.foodName,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              context.read<FoodCubit>().selectedFoods().isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 100.0),
                      child: Center(
                        child: MaterialButton(
                          color: const Color(0xff1f1f1F),
                          minWidth: 200.w,
                          height: 45.h,
                          splashColor: Colors.blueAccent,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          onPressed: () {
                            BlocProvider.of<FormCompletionCubit>(context)
                                .controller
                                .nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);

                            BlocProvider.of<FormCompletionCubit>(context)
                                .updateUi();
                          },
                          child: const Text("Next",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        } else {
          return const Center(child: Text('No data found'));
        }
      },
    );
  }
}
