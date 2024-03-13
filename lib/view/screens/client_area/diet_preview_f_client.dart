import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/client_controllers/diet_display_page_controller.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/helpers/helper_functions.dart';
import '../../widgets/custom_appbar.dart';

class DietPreviewfClient extends StatelessWidget {
  const DietPreviewfClient({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);

    return GetBuilder<DietDataController>(
      init: DietDataController(),
      builder: (controller) => Scaffold(
         appBar: const CustomAppBar(showBackArrow: false, title: 'Diet',),
        body: controller.isLoading.value
            ? const Center(child: CircularProgressIndicator(color: Colors.white),)
            : SingleChildScrollView(
          child: controller.dietData.isEmpty
              ? const Center(child: Text('No data available'))
              : Column(
            children: [
              const SizedBox(height: 20,),
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
                          color:dark? Colors.white:CColors.dark,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "46".tr,
                              style: TextStyle(
                                color:dark? Colors.black:Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "42".tr,
                              style: TextStyle(
                                color:dark? Colors.black:Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "43".tr,
                              style: TextStyle(
                                color:dark? Colors.black:Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "44".tr,
                              style: TextStyle(
                                color:dark? Colors.black:Colors.white,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "${controller.dietData[0].tdee.toInt()}",
                            style: TextStyle(
                               fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${controller.dietData[0].targetProtien} g",
                            style: TextStyle(
                               fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${controller.dietData[0].targetCarbohdrate} g",
                            style: TextStyle(
                               fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${controller.dietData[0].targetFat} g",
                            style: TextStyle(
                               fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                        height: 20,
                      ),
                      const SizedBox(height: 15,),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.dietData.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                height: 45.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color:dark? Colors.white:CColors.dark,
                                ),
                                child:Center(
                                  child: Text(
                                    "${controller.dietData[index].foodName} : ${controller.dietData[index].quantity} g",style: TextStyle(
                                    fontSize: 11.sp,color:dark? Colors.black:CColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  ),
                                ),

                              ),




                              const SizedBox(height: 10,),
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
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "${(controller.dietData[index].calories * controller.dietData[index].quantity).toInt()}",
                                    style: TextStyle(
                                       fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${(controller.dietData[index].protein * controller.dietData[index].quantity).toInt()} g",
                                    style: TextStyle(
                                       fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${controller.dietData[index].carbohydrates * controller.dietData[index].quantity.toInt()} g",
                                    style: TextStyle(
                                       fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${(controller.dietData[index].fats * controller.dietData[index].quantity).toInt()} g",
                                    style: TextStyle(
                                       fontSize: 11.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15,),
                              index < controller.dietData.length - 1 ? const Divider(
                                color: Colors.grey,
                                thickness: 1.0,
                                height: 20,
                              ) : const SizedBox(height: 0,),
                              const SizedBox(height: 15,),
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
        ),
      ),
    );
  }
}