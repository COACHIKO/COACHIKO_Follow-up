import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/core/networking/api_service.dart';
import 'package:followupapprefactored/core/utils/helpers/helper_functions.dart';
import 'package:followupapprefactored/features/modules/client/starting_form/quantities_entering/data/models/form_completion_request_body.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/image_strings.dart';
import '../../../../../../core/utils/constants/sizes.dart';
import '../../../../../../core/utils/constants/text_strings.dart';
import '../../../../../../main.dart';
import '../../../../coach/diet_making_features/food_selection/data/repository/foods_repo_impl.dart';
import '../../../../coach/diet_making_features/food_selection/logic/cubit/food_cubit.dart';
import '../../../../coach/diet_making_features/food_selection/ui/food_selection_page.dart';
import '../data/repository/form_completion_repo_imp.dart';
import '../logic/cubit/form_completion_cubit.dart';
import '../logic/cubit/form_completion_state.dart';

class FormComplectionView extends StatelessWidget {
  const FormComplectionView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => FormCompletionCubit(
          formCompletionRepoImp: FormCompletionRepoImp(ApiService(Dio())),
        ),
        child: const FormComplectionBody(),
      ),
    );
  }
}

class FormComplectionBody extends StatelessWidget {
  const FormComplectionBody({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormCompletionCubit, FormComplectionStates>(
        builder: (context, state) {
      final controllerget = BlocProvider.of<FormCompletionCubit>(context);

      final dark = THelperFunctions.isDarkMode(context);

      return Scaffold(
        body: Stack(
          children: [
            PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controllerget.controller,
                children: [
                  /// GENDER SELECT ///
                  Scaffold(
                    appBar: AppBar(
                      title: const Text("Gender Select",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      centerTitle: true,
                    ),
                    body: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.only(
                                    top: TSizes.spaceBtwItems.h),
                                child: const Text("Choose Your Gender :",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            SizedBox(
                              height: 50.h,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: CColors.black,
                              ),
                              alignment: Alignment.topCenter,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controllerget.womanSelected();
                                      controllerget.controller.nextPage(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        "assets/2.png",
                                        width: 150,
                                        height: 150,
                                        color: controllerget.isSelectedWoMan
                                            ? null
                                            : Colors.grey,
                                        colorBlendMode:
                                            controllerget.isSelectedWoMan
                                                ? null
                                                : BlendMode.saturation,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controllerget.manSelected();

                                      controllerget.controller.nextPage(
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeInOut);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        "assets/1.png",
                                        width: 150,
                                        height: 150,
                                        color: controllerget.isSelectedMan
                                            ? null
                                            : Colors.grey,
                                        colorBlendMode:
                                            controllerget.isSelectedMan
                                                ? null
                                                : BlendMode.saturation,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40.w, vertical: 8.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "5".tr,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: Text(
                                      "6".tr,
                                      style: TextStyle(
                                          fontSize: 20.sp, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// GOAL SELECT ///
                  Scaffold(
                    appBar: AppBar(
                      title: const Text(
                        "Goal Select",
                      ),
                      centerTitle: true,
                    ),
                    body: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 22.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding:
                                  EdgeInsets.only(top: TSizes.spaceBtwItems.h),
                              child: const Text("Choose Your Goal :",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          const SizedBox(
                            height: TSizes.appBarHeight,
                          ),
                          InkWell(
                            onTap: () {
                              controllerget.loseWeightSelected();

                              controllerget.controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child: ChooseCard(
                                controller: controllerget.isSelectedLoseWeight,
                                text: "Lose Weight",
                                image: 'assets/3.png'),
                          ),
                          SizedBox(height: 22.h),
                          InkWell(
                            onTap: () {
                              controllerget.gainWeightSelected();

                              controllerget.controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child: ChooseCard(
                                controller: controllerget.isSelectedGainWeight,
                                text: "Gain Weight",
                                image: 'assets/4.png'),
                          ),
                          SizedBox(height: 22.h),
                          InkWell(
                            onTap: () {
                              controllerget.maintainWeightSelected();

                              controllerget.controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child: ChooseCard(
                              controller:
                                  controllerget.isSelectedMaintainWeight,
                              text: "Maintain Weight",
                              image: 'assets/3.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// ACTIVITY SELECT ///
                  Scaffold(
                    appBar: AppBar(
                      title: const Text("Activity Select",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      centerTitle: true,
                    ),
                    body: Container(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding:
                                  EdgeInsets.only(top: TSizes.spaceBtwItems.h),
                              child: const Text("Choose Your Activity :",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(
                            height: TSizes.spaceBtwItems.h,
                          ),
                          InkWell(
                            onTap: () {
                              controllerget.isLowActivitySelectedFunction();
                              controllerget.activityFactorDetect();
                              controllerget.controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child: ChooseCard(
                                controller: controllerget.isLowActivitySelected,
                                text: "12".tr,
                                image: 'assets/6.png'),
                          ),
                          SizedBox(height: 18.h),
                          InkWell(
                            onTap: () {
                              controllerget.isLightActivitySelectedFunction();
                              controllerget.activityFactorDetect();
                              controllerget.controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child: ChooseCard(
                                controller:
                                    controllerget.isLightActivitySelected,
                                text: "13".tr,
                                image: 'assets/8.png'),
                          ),
                          SizedBox(height: 18.h),
                          InkWell(
                            onTap: () {
                              controllerget
                                  .isModerateActivitySelectedFunction();
                              controllerget.activityFactorDetect();
                              controllerget.controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child: ChooseCard(
                                controller:
                                    controllerget.isModerateActivitySelected,
                                text: "14".tr,
                                image: 'assets/7.png'),
                          ),
                          SizedBox(height: 18.h),
                          InkWell(
                            onTap: () {
                              controllerget.isHeavyActivitySelectedFunction();
                              controllerget.activityFactorDetect();
                              controllerget.controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child: ChooseCard(
                                controller:
                                    controllerget.isHeavyActivitySelected,
                                text: "15".tr,
                                image: 'assets/9.png'),
                          ),
                          SizedBox(height: 18.h),
                          InkWell(
                            onTap: () {
                              controllerget.isExtreemActivitySelectedFunction();
                              controllerget.activityFactorDetect();
                              controllerget.controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child: ChooseCard(
                                controller:
                                    controllerget.isExtreemActivitySelected,
                                text: "16".tr,
                                image: 'assets/10.png'),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// BIRTHDAY DATE SELECT ///
                  Scaffold(
                    appBar: AppBar(
                      title: const Text("Birthday Select",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      centerTitle: true,
                    ),
                    body: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 22.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding:
                                  EdgeInsets.only(top: TSizes.spaceBtwItems.h),
                              child: Text("17".tr,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold))),
                          SizedBox(
                            height: TSizes.spaceBtwItems.h,
                          ),
                          SizedBox(
                              height: 400.h,
                              child: CupertinoTheme(
                                  data: MaterialBasedCupertinoThemeData(
                                      materialTheme: dark
                                          ? ThemeData.dark()
                                          : ThemeData.light()),
                                  child: CupertinoDatePicker(
                                    minimumYear: 1950,
                                    maximumYear: 2013,
                                    initialDateTime: DateTime.utc(2000),
                                    onDateTimeChanged: (value) {
                                      controllerget.birthdayDate = value;
                                    },
                                    mode: CupertinoDatePickerMode.date,
                                  ))),
                          Center(
                            child: MaterialButton(
                              color: const Color(0xff1f1f1F),
                              minWidth: 200.w,
                              height: 45.h,
                              splashColor: Colors.blueAccent,
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              onPressed: () {
                                controllerget.controller.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                              },
                              child: const Text("Next",
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Money Fellow
                  Scaffold(
                    appBar: AppBar(
                      title: const Text("Budget Select",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      centerTitle: true,
                    ),
                    body: Container(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.only(top: 25.h),
                              child: Text("25".tr,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          SizedBox(height: 22.h),
                          Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    controllerget.lowCostDietIsSelected();
                                    controllerget.controller.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut);
                                  },
                                  child: ChooseCard(
                                    controller: controllerget.poorMoney,
                                    text: "22".tr,
                                    image: "assets/11.png",
                                  )),
                              SizedBox(height: 22.h),
                              InkWell(
                                onTap: () {
                                  controllerget.mediumCostDietIsSelected();
                                  controllerget.controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                },
                                child: ChooseCard(
                                  controller: controllerget.mediumMoney,
                                  text: "23".tr,
                                  image: "assets/12.png",
                                ),
                              ),
                              SizedBox(height: 22.h),
                              InkWell(
                                onTap: () {
                                  controllerget.highCostDietIsSelected();
                                  controllerget.controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                },
                                child: ChooseCard(
                                  controller: controllerget.richMoney,
                                  text: "24".tr,
                                  image: "assets/13.png",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// MESUREMENTS OF BODY
                  Scaffold(
                    appBar: AppBar(
                      title: const Text("Birthday Select",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      centerTitle: true,
                    ),
                    body: Container(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("26".tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  controllerget.isSelectedMan && dark == true
                                      ? TImages.manDarkImage
                                      : controllerget.isSelectedMan &&
                                              dark == false
                                          ? TImages.manLightImage
                                          : controllerget.isSelectedWoMan &&
                                                  dark == true
                                              ? TImages.womanDarkImage
                                              : TImages.womanLightImage,

                                  height: 250.h,
                                  // width: 200.w,
                                ),
                                controllerget.isSelectedMan
                                    ? Column(
                                        children: [
                                          Form(
                                            key: controllerget.formKey,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 70.h,
                                                  width: 100.w,
                                                  child: TextFormField(
                                                    controller:
                                                        controllerget.weight,
                                                    maxLength: 3,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "33".tr;
                                                      }
                                                      return null;
                                                    },
                                                    style: TextStyle(
                                                        fontSize: 14.sp),
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                      counterText:
                                                          '', // Clear default counter text
                                                      errorStyle:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .blueAccent),
                                                      focusedErrorBorder:
                                                          const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .blueAccent)),
                                                      errorBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .blueAccent),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12)),
                                                      ),
                                                      border: const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                      fillColor: const Color(
                                                          0xff1f1f1F),
                                                      filled:
                                                          dark ? true : false,
                                                      hintText: "Weight",
                                                      hintStyle: TextStyle(
                                                          fontSize: 14.sp),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 70.h,
                                                  width: 100.w,
                                                  child: TextFormField(
                                                    controller:
                                                        controllerget.tall,
                                                    maxLength: 3,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "33".tr;
                                                      }
                                                      return null;
                                                    },
                                                    style: TextStyle(
                                                        fontSize: 14.sp),
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                      counterText:
                                                          '', // Clear default counter text
                                                      errorStyle:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .blueAccent),
                                                      focusedErrorBorder:
                                                          const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .blueAccent)),
                                                      errorBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .blueAccent),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12)),
                                                      ),
                                                      border: const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                      fillColor: const Color(
                                                          0xff1f1f1F),
                                                      filled:
                                                          dark ? true : false,
                                                      hintText: "Tall",
                                                      hintStyle: TextStyle(
                                                          fontSize: 14.sp),
                                                    ),
                                                  ),
                                                ),

                                                /// WAIST
                                                SizedBox(
                                                  height: 70.h,
                                                  width: 100.w,
                                                  child: TextFormField(
                                                    controller:
                                                        controllerget.waist,
                                                    maxLength: 3,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "33".tr;
                                                      }
                                                      return null;
                                                    },
                                                    style: TextStyle(
                                                        fontSize: 14.sp),
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                      counterText:
                                                          '', // Clear default counter text
                                                      errorStyle:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .blueAccent),
                                                      focusedErrorBorder:
                                                          const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .blueAccent)),
                                                      errorBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .blueAccent),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12)),
                                                      ),
                                                      border: const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                      fillColor: const Color(
                                                          0xff1f1f1F),
                                                      filled:
                                                          dark ? true : false,
                                                      hintText: "27".tr,
                                                      hintStyle: TextStyle(
                                                          fontSize: 14.sp),
                                                    ),
                                                  ),
                                                ),

                                                ///NECK
                                                SizedBox(
                                                  height: 70.h,
                                                  width: 100.w,
                                                  child: TextFormField(
                                                    controller:
                                                        controllerget.neck,
                                                    maxLength: 3,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "33".tr;
                                                      }
                                                      return null;
                                                    },
                                                    style: TextStyle(
                                                        fontSize: 14.sp),
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                      counterText:
                                                          '', // Clear default counter text

                                                      errorStyle:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .blueAccent),
                                                      focusedErrorBorder:
                                                          const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .blueAccent)),
                                                      errorBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .blueAccent),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12)),
                                                      ),
                                                      border: const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                      fillColor: const Color(
                                                          0xff1f1f1F),
                                                      filled:
                                                          dark ? true : false,
                                                      hintText: "28".tr,
                                                      hintStyle: TextStyle(
                                                          fontSize: 14.sp),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                          ///ARMS
                                          SizedBox(
                                            height: 70.h,
                                            width: 100.w,
                                            child: TextFormField(
                                              controller: controllerget.arms,
                                              maxLength: 3,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              validator: (value) {
                                                return "Optional";
                                              },
                                              style: TextStyle(fontSize: 14.sp),
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                counterText:
                                                    '', // Clear default counter text

                                                errorStyle: const TextStyle(
                                                    color: Colors.blueAccent),
                                                focusedErrorBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .blueAccent)),
                                                errorBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blueAccent),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                ),
                                                border:
                                                    const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12))),
                                                fillColor:
                                                    const Color(0xff1f1f1F),
                                                filled: dark ? true : false,
                                                hintText: "29".tr,
                                                hintStyle:
                                                    TextStyle(fontSize: 14.sp),
                                              ),
                                            ),
                                          ),

                                          /// CALVES
                                          Center(
                                            child: SizedBox(
                                              height: 70.h,
                                              width: 100.w,
                                              child: TextFormField(
                                                controller:
                                                    controllerget.calves,
                                                maxLength: 3,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                                style:
                                                    TextStyle(fontSize: 14.sp),
                                                textAlign: TextAlign.center,
                                                decoration: InputDecoration(
                                                  counterText:
                                                      '', // Clear default counter text
                                                  errorStyle: const TextStyle(
                                                      color: Colors.blueAccent),
                                                  focusedErrorBorder:
                                                      const OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .blueAccent)),
                                                  errorBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Colors.blueAccent),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                  ),
                                                  border:
                                                      const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                  fillColor:
                                                      const Color(0xff1f1f1F),
                                                  filled: dark ? true : false,
                                                  hintText: "30".tr,
                                                  hintStyle: TextStyle(
                                                      fontSize: 14.sp),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          Form(
                                            key: controllerget.womanFormKey,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 70.h,
                                                  width: 100.w,
                                                  child: TextFormField(
                                                    controller:
                                                        controllerget.weight,
                                                    maxLength: 3,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "33".tr;
                                                      }
                                                      return null;
                                                    },
                                                    style: TextStyle(
                                                        fontSize: 14.sp),
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                      counterText:
                                                          '', // Clear default counter text
                                                      errorStyle:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .blueAccent),
                                                      focusedErrorBorder:
                                                          const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .blueAccent)),
                                                      errorBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .blueAccent),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12)),
                                                      ),
                                                      border: const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                      fillColor: const Color(
                                                          0xff1f1f1F),
                                                      filled:
                                                          dark ? true : false,
                                                      hintText: "Weight",
                                                      hintStyle: TextStyle(
                                                          fontSize: 14.sp),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 70.h,
                                                  width: 100.w,
                                                  child: TextFormField(
                                                    controller:
                                                        controllerget.tall,
                                                    maxLength: 3,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "33".tr;
                                                      }
                                                      return null;
                                                    },
                                                    style: TextStyle(
                                                        fontSize: 14.sp),
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                      counterText:
                                                          '', // Clear default counter text
                                                      errorStyle:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .blueAccent),
                                                      focusedErrorBorder:
                                                          const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .blueAccent)),
                                                      errorBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .blueAccent),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12)),
                                                      ),
                                                      border: const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                      fillColor: const Color(
                                                          0xff1f1f1F),
                                                      filled:
                                                          dark ? true : false,
                                                      hintText: "Tall",
                                                      hintStyle: TextStyle(
                                                          fontSize: 14.sp),
                                                    ),
                                                  ),
                                                ),

                                                /// Waist
                                                SizedBox(
                                                  height: 70.h,
                                                  width: 100.w,
                                                  child: TextFormField(
                                                    controller:
                                                        controllerget.waist,
                                                    maxLength: 3,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "33".tr;
                                                      }
                                                      return null;
                                                    },
                                                    style: TextStyle(
                                                        fontSize: 14.sp),
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .blueAccent),
                                                      counterText:
                                                          '', // Clear default counter text

                                                      focusedErrorBorder:
                                                          const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .blueAccent)),
                                                      errorBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .blueAccent),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12)),
                                                      ),
                                                      border: const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                      fillColor: const Color(
                                                          0xff1f1f1F),
                                                      filled:
                                                          dark ? true : false,
                                                      hintText: "27".tr,
                                                      hintStyle: TextStyle(
                                                          fontSize: 14.sp),
                                                    ),
                                                  ),
                                                ),

                                                /// Neck
                                                SizedBox(
                                                  height: 70.h,
                                                  width: 100.w,
                                                  child: TextFormField(
                                                    controller:
                                                        controllerget.neck,
                                                    maxLength: 3,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "33".tr;
                                                      }
                                                      return null;
                                                    },
                                                    style: TextStyle(
                                                        fontSize: 14.sp),
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                      counterText:
                                                          '', // Clear default counter text

                                                      errorStyle:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .blueAccent),
                                                      focusedErrorBorder:
                                                          const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .blueAccent)),
                                                      errorBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .blueAccent),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12)),
                                                      ),
                                                      border: const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                      fillColor: const Color(
                                                          0xff1f1f1F),
                                                      filled:
                                                          dark ? true : false,
                                                      hintText: "28".tr,
                                                      hintStyle: TextStyle(
                                                          fontSize: 14.sp),
                                                    ),
                                                  ),
                                                ),

                                                /// Hip
                                                SizedBox(
                                                  height: 70.h,
                                                  width: 100.w,
                                                  child: TextFormField(
                                                    controller:
                                                        controllerget.hip,
                                                    maxLength: 3,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return "33".tr;
                                                      }
                                                      return null;
                                                    },
                                                    style: TextStyle(
                                                        fontSize: 14.sp),
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                      errorStyle:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .blueAccent),
                                                      focusedErrorBorder:
                                                          const OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .blueAccent)),
                                                      counterText:
                                                          '', // Clear default counter text

                                                      errorBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .blueAccent),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12)),
                                                      ),
                                                      border: const OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                      fillColor: const Color(
                                                          0xff1f1f1F),
                                                      filled:
                                                          dark ? true : false,
                                                      hintText: "31".tr,
                                                      hintStyle: TextStyle(
                                                          fontSize: 14.sp),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          /// CHEST
                                          SizedBox(
                                            height: 70.h,
                                            width: 100.w,
                                            child: TextFormField(
                                              controller: controllerget.chest,
                                              maxLength: 3,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "33".tr;
                                                }
                                                return null;
                                              },
                                              style: TextStyle(fontSize: 14.sp),
                                              textAlign: TextAlign.center,
                                              decoration: InputDecoration(
                                                counterText:
                                                    '', // Clear default counter text

                                                errorStyle: const TextStyle(
                                                    color: Colors.blueAccent),
                                                focusedErrorBorder:
                                                    const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .blueAccent)),
                                                errorBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.blueAccent),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(12)),
                                                ),
                                                border:
                                                    const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12))),
                                                fillColor:
                                                    const Color(0xff1f1f1F),
                                                filled: dark ? true : false,
                                                hintText: "32".tr,
                                                hintStyle:
                                                    TextStyle(fontSize: 14.sp),
                                              ),
                                            ),
                                          ),

                                          /// CALVE
                                        ],
                                      ),
                              ],
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 20.h),
                                child: Center(
                                  child: MaterialButton(
                                    color: const Color(0xff1f1f1F),
                                    minWidth: 155,
                                    height: 45.h,
                                    splashColor: Colors.blueAccent,
                                    shape: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    onPressed: () {
                                      controllerget.validateMeasuresForm();
                                    },
                                    child: const Text("Next",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// FIND PREFERRED FOODS
                  Scaffold(
                    appBar: AppBar(
                      centerTitle: true,
                      title: const Text('Foods'),
                      iconTheme: const IconThemeData(color: Colors.blueAccent),
                    ),
                    body: BlocProvider(
                      create: (context) => FoodCubit(
                        foodsRepoImpl: FoodsRepoImpl(ApiService(Dio())),
                        selectedfoods: controllerget.selectedFoods,
                      )..getFoods(),
                      child: const FoodDataWidget2(),
                    ),
                  ),
                  SafeArea(
                    child: Scaffold(
                        body: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      const Row(
                                        children: [
                                          Text(
                                            "Your report based on your data :",
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      SizedBox(
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12.0, vertical: 12),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Physical Info ",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.copyWith(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                          "Gender: ${controllerget.gender ? "Male" : "Female"} "),
                                                      Text(
                                                          "Weight: ${controllerget.weight.text} KG"),
                                                      Text(
                                                          "Abdomen: ${controllerget.waist.text} CM"),
                                                      Text(
                                                          "Neck: ${controllerget.neck.text} CM"),
                                                      controllerget.hip.text
                                                              .isNotEmpty
                                                          ? Text(
                                                              "Hip: ${controllerget.hip.text} CM")
                                                          : const SizedBox
                                                              .shrink(),
                                                      controllerget.hip.text
                                                              .isNotEmpty
                                                          ? Text(
                                                              "Chest: ${controllerget.chest.text} CM")
                                                          : const SizedBox
                                                              .shrink(),
                                                      controllerget.hip.text
                                                              .isNotEmpty
                                                          ? Text(
                                                              "Arm: ${controllerget.arms.text} CM")
                                                          : const SizedBox
                                                              .shrink(),
                                                      controllerget.hip.text
                                                              .isNotEmpty
                                                          ? Text(
                                                              "Wrist: ${controllerget.wrist.text} CM")
                                                          : const SizedBox
                                                              .shrink(),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        "Social Info ",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge
                                                            ?.copyWith(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                          "Goal: ${controllerget.wheightloss ? "Weight Loss" : controllerget.weightMaintain ? "Weight Maintain" : "Weight Gain"} "),
                                                      Text(controllerget
                                                              .isLowActivitySelected
                                                          ? "${"You"} Don't Train At All"
                                                          : controllerget
                                                                  .isLightActivitySelected
                                                              ? "${"You"} Train 1 or 2 Times A Week"
                                                              : controllerget
                                                                      .isModerateActivitySelected
                                                                  ? "${"You"} Train 3 to 5 Times A Week"
                                                                  : controllerget
                                                                          .isHeavyActivitySelected
                                                                      ? "${"You"} Train 6 Times A Week"
                                                                      : "${"You"} Train Twice a Day"),
                                                      Text(
                                                          "${"Your"} Budget is ${controllerget.poorMoney ? "Low" : controllerget.mediumMoney ? "Medium" : "High"}"),
                                                      Text(
                                                          "Preferred Foods: ${controllerget.getFoodNames()}"),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                    width:
                                                        16), // Adding space between text and image
                                                controllerget.gender == true &&
                                                        controllerget
                                                                .fatPercentage !=
                                                            0 &&
                                                        controllerget
                                                                .fatPercentage <
                                                            12
                                                    ? const Image(
                                                        image: AssetImage(
                                                            TImages
                                                                .under12FatMan),
                                                        height: 300,
                                                      )
                                                    : controllerget
                                                                    .gender ==
                                                                true &&
                                                            controllerget
                                                                    .fatPercentage >
                                                                12 &&
                                                            controllerget
                                                                    .fatPercentage <
                                                                20
                                                        ? const Image(
                                                            image: AssetImage(
                                                                TImages
                                                                    .above12under20FatMan),
                                                            height: 300,
                                                          )
                                                        : controllerget
                                                                        .gender ==
                                                                    true &&
                                                                controllerget
                                                                        .fatPercentage >
                                                                    20 &&
                                                                controllerget
                                                                        .fatPercentage <
                                                                    29
                                                            ? const Image(
                                                                image: AssetImage(
                                                                    TImages
                                                                        .above20under30FatMan),
                                                                height: 300,
                                                              )
                                                            : controllerget.gender ==
                                                                        true &&
                                                                    controllerget
                                                                            .fatPercentage >
                                                                        29 &&
                                                                    controllerget
                                                                            .fatPercentage <
                                                                        39
                                                                ? const Image(
                                                                    image: AssetImage(
                                                                        TImages
                                                                            .above29Under40FatMan),
                                                                    height: 300,
                                                                  )
                                                                : const SizedBox
                                                                    .shrink(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 200.h,
                                      ),
                                      Center(
                                        child: MaterialButton(
                                          color: const Color(0xff1f1f1F),
                                          minWidth: 155,
                                          height: 45.h,
                                          splashColor: Colors.blueAccent,
                                          shape: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          onPressed: () async {
                                            await controllerget.completeForm(
                                                FormCompletionRequestBody(
                                                    id: myServices.sharedPreferences
                                                        .getInt("user")!
                                                        .toInt(),
                                                    preferedFoods: controllerget
                                                        .getFoodNames(),
                                                    genderSelect:
                                                        controllerget.isSelectedMan
                                                            ? 0
                                                            : 1,
                                                    goalSelect: controllerget
                                                            .isSelectedLoseWeight
                                                        ? 0
                                                        : controllerget
                                                                .isSelectedMaintainWeight
                                                            ? 1
                                                            : 2,
                                                    activitySelect: controllerget
                                                            .isLowActivitySelected
                                                        ? 0
                                                        : controllerget
                                                                .isLightActivitySelected
                                                            ? 1
                                                            : controllerget
                                                                    .isModerateActivitySelected
                                                                ? 2
                                                                : controllerget
                                                                        .isHeavyActivitySelected
                                                                    ? 3
                                                                    : 4,
                                                    weight: double.parse(
                                                        controllerget
                                                            .weight.text),
                                                    tall: double.parse(
                                                        controllerget
                                                            .tall.text),
                                                    costSelect: controllerget
                                                            .poorMoney
                                                        ? 0
                                                        : controllerget.mediumMoney
                                                            ? 1
                                                            : 2,
                                                    waist: double.parse(controllerget.waist.text),
                                                    neck: double.parse(controllerget.neck.text),
                                                    hip: controllerget.hip.text.isEmpty ? 0.0 : double.parse(controllerget.hip.text),
                                                    chest: controllerget.chest.text.isEmpty ? 0.0 : double.parse(controllerget.chest.text),
                                                    arms: controllerget.arms.text.isEmpty ? 0.0 : double.parse(controllerget.arms.text),
                                                    wrist: controllerget.wrist.text.isEmpty ? 0.0 : double.parse(controllerget.wrist.text),
                                                    tdee: controllerget.tdeeCalculator().toInt(),
                                                    fatPercentage: controllerget.fatPercentage,
                                                    targetProtien: controllerget.targetProtein.toInt(),
                                                    targetCarbohdrate: controllerget.targetCarbs.toInt(),
                                                    targetFat: controllerget.targetFat.toInt(),
                                                    currentStep: 1,
                                                    birthdayDate: controllerget.birthdayDate.toUtc()));
                                          },
                                          child: const Text("Next",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // Form
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: TSizes.spaceBtwSections),
                              child: Column(
                                children: [],
                              ),
                            ),
                            // Divider
                          ],
                        ),
                      ),
                    )),
                  )
                ]),

            /// PROGRESSIVE LINE INDICATOR
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .85),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        controllerget.controller.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      },
                      icon: getIconBasedOnLanguage(),
                      color: dark ? CColors.light : CColors.dark,
                    ),
                    SmoothPageIndicator(
                      controller: controllerget.controller,
                      count: 8,
                      effect: SwapEffect(
                        paintStyle: PaintingStyle.fill,
                        spacing: 0,
                        dotWidth: 28,
                        radius: double.minPositive,
                        activeDotColor: CColors.primary,
                        dotColor: dark ? CColors.white : CColors.black,
                        strokeWidth:
                            0, // Set border width to 0 to remove the border
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (controllerget.controller.page == 0) {
                          if (controllerget.isSelectedMan == true ||
                              controllerget.isSelectedWoMan == true) {
                            controllerget.controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          } else {}
                        } else if (controllerget.controller.page == 1) {
                          if (controllerget.isSelectedLoseWeight == true ||
                              controllerget.isSelectedGainWeight == true ||
                              controllerget.isSelectedMaintainWeight == true) {
                            controllerget.controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          } else {}
                        } else if (controllerget.controller.page == 2) {
                          if (controllerget.isLowActivitySelected == true ||
                              controllerget.isLightActivitySelected == true ||
                              controllerget.isModerateActivitySelected ==
                                  true ||
                              controllerget.isHeavyActivitySelected == true ||
                              controllerget.isExtreemActivitySelected == true) {
                            controllerget.controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          } else {}
                        } else if (controllerget.controller.page == 3) {
                          if (controllerget.birthdayDate !=
                              DateTime(1950, 1, 1)) {
                            controllerget.controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          } else {}
                        } else if (controllerget.controller.page == 4) {
                          if (controllerget.poorMoney == true ||
                              controllerget.mediumMoney == true ||
                              controllerget.richMoney == true) {
                            controllerget.controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          } else {}
                        } else if (controllerget.controller.page == 5) {
                          controllerget.validateMeasuresForm();
                        } else if (controllerget.controller.page == 6) {
                          if (controllerget.selectedFoods.isNotEmpty) {
                            controllerget.controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          }
                        }
                      },
                      icon: getIconBackchervon(),
                      color: dark ? CColors.light : CColors.dark,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}

class ChooseCard extends StatelessWidget {
  final bool controller; // Add explicit type bool for controller
  final String text; // Add explicit type String for text
  final String image; // Add explicit type String for image

  const ChooseCard({
    super.key, // Add Key key parameter
    required this.controller,
    required this.text,
    required this.image,
  }); // Pass key to super constructor

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 90,
        width: 340,
        decoration: BoxDecoration(
          color: controller ? Colors.blueAccent : const Color(0xff1f1f1F),
          borderRadius: BorderRadius.circular(12.5),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image(
                height: 40,
                width: 40,
                image: AssetImage(image),
              ),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Icon getIconBasedOnLanguage() {
  if (localeController.language == const Locale("en")) {
    return const Icon(CupertinoIcons.chevron_forward);
  } else {
    return const Icon(CupertinoIcons.chevron_back);
  }
}

Icon getIconBackchervon() {
  if (localeController.language == const Locale("en")) {
    return const Icon(CupertinoIcons.chevron_back);
  } else {
    return const Icon(CupertinoIcons.chevron_forward);
  }
}
