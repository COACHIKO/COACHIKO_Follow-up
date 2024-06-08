import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/helpers/helper_functions.dart';
import '../../../../../view/widgets/custom_appbar.dart';
import '../logic/cubit/diet_cubit.dart';
import '../logic/cubit/diet_state.dart';

class DietPlanPage extends StatelessWidget {
  const DietPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: const CustomAppBar(showBackArrow: false, title: "Diet"),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(22),
                  left: Radius.circular(22),
                ),
              ),
              child: Column(
                children: [
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
                          "46".tr,
                          style: TextStyle(
                            color: dark ? Colors.black : Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "42".tr,
                          style: TextStyle(
                            color: dark ? Colors.black : Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "43".tr,
                          style: TextStyle(
                            color: dark ? Colors.black : Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "44".tr,
                          style: TextStyle(
                            color: dark ? Colors.black : Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${state.dietItems[0].tdee.toInt()}",
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${state.dietItems[0].targetProtein} g",
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${state.dietItems[0].targetCarbohydrate} g",
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${state.dietItems[0].targetFat} g",
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 1.0,
                    height: 20,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.dietItems.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            height: 45.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: dark ? Colors.white : CColors.dark,
                            ),
                            child: Center(
                              child: Text(
                                "${state.dietItems[index].foodName} : ${state.dietItems[index].quantity} g",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: dark ? Colors.black : CColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 35.h,
                            width: 350,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "41".tr,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "42".tr,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "43".tr,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "44".tr,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "${(state.dietItems[index].calories * state.dietItems[index].quantity).toInt()}",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${(state.dietItems[index].protein * state.dietItems[index].quantity).toInt()} g",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${state.dietItems[index].carbohydrates * state.dietItems[index].quantity.toInt()} g",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${(state.dietItems[index].fats * state.dietItems[index].quantity).toInt()} g",
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          index < state.dietItems.length - 1
                              ? const Divider(
                                  color: Colors.grey,
                                  thickness: 1.0,
                                  height: 20,
                                )
                              : const SizedBox(
                                  height: 0,
                                ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
