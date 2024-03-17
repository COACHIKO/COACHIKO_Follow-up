import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../controller/coach_controllers/diet_making_controllers/diet_make_controller.dart';
import '../../../../controller/client_controllers/starting_form_controllers/form_complection_controller.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/image_strings.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/constants/text_strings.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../main.dart';


class FormComplection extends StatelessWidget {
   FormComplection({super.key});
  final coachHomeController = Get.find<DietMakingController>();

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);

    return GetBuilder<FormComplectionController>(
      init: FormComplectionController(),
      builder: (controllerget) => Scaffold(
        body: Stack(
          children: [
            PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controllerget.controller,
                children: [
                  /// GENDER SELECT ///
                  Scaffold(appBar: AppBar(title: const Text(
                      "Gender Select",
                      style: TextStyle(
                           fontWeight: FontWeight.bold)),centerTitle: true,),
                    body: SingleChildScrollView(physics: const NeverScrollableScrollPhysics(),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.only(top: TSizes.spaceBtwItems.h),
                                child: const Text(
                                    "Choose Your Gender :",
                                    style: TextStyle(fontWeight: FontWeight.bold))),
                            SizedBox(height: 50.h,),
                            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: CColors.black,),alignment: Alignment.topCenter,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controllerget.womanSelected();
                                      controllerget.update();
                                      controllerget.controller.nextPage(
                                          duration: const Duration(
                                              milliseconds: 500),
                                          curve: Curves.easeInOut);
                                    },
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(12),
                                      child: Image.asset(
                                        "assets/2.png",
                                        width: 150,
                                        height: 150,
                                        color: controllerget
                                            .isSelectedWoMan
                                            ? null
                                            : Colors.grey,
                                        colorBlendMode: controllerget
                                            .isSelectedWoMan
                                            ? null
                                            : BlendMode.saturation,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controllerget.manSelected();

                                      controllerget.controller.nextPage(
                                          duration: const Duration(
                                              milliseconds: 500),
                                          curve: Curves.easeInOut);
                                    },
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(12),
                                      child: Image.asset(
                                        "assets/1.png",
                                        width: 150,
                                        height: 150,
                                        color:
                                        controllerget.isSelectedMan
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
                                    padding:
                                    EdgeInsets.only(right: 10.w),
                                    child: Text(
                                      "6".tr,
                                      style: TextStyle(
                                          fontSize: 20.sp,
                                          color: Colors.white),
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
                  Scaffold(appBar: AppBar(title: const Text("Goal Select",),centerTitle: true,),
                    body: Container(
                       padding: EdgeInsets.symmetric(
                        horizontal: 22.w,
                      ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Container(
                              padding: EdgeInsets.only(top: TSizes.spaceBtwItems.h),
                              child: const Text(
                                  "Choose Your Goal :",
                                  style: TextStyle(fontWeight: FontWeight.bold))),

                          const SizedBox(height: TSizes.appBarHeight,),

                          InkWell(
                            onTap: () {
                              controllerget.loseWeightSelected();

                              controllerget.controller.nextPage(
                                  duration: const Duration(
                                      milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child:ChooseCard(controller: controllerget.isSelectedLoseWeight, text: "Lose Weight", image: 'assets/3.png'),
                          ),

                          SizedBox(height: 22.h),
                          InkWell(
                            onTap: () {
                              controllerget.gainWeightSelected();

                              controllerget.controller.nextPage(
                                  duration: const Duration(
                                      milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child:ChooseCard(controller: controllerget.isSelectedGainWeight, text: "Gain Weight", image: 'assets/4.png'),
                          ),
                          SizedBox(height: 22.h),
                          InkWell(
                            onTap: () {
                              controllerget.maintainWeightSelected();

                              controllerget.controller.nextPage(
                                  duration: const Duration(
                                      milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child:ChooseCard(controller: controllerget.isSelectedMaintainWeight, text: "Maintain Weight", image: 'assets/3.png',),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /// ACTIVITY SELECT ///
                  Scaffold(appBar: AppBar(title: const Text(
                      "Activity Select",
                      style: TextStyle(
                           fontWeight: FontWeight.bold)),centerTitle: true,),

                    body: Container(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.only(top: TSizes.spaceBtwItems.h),
                              child: const Text(
                                  "Choose Your Activity :",
                                  style: TextStyle(fontWeight: FontWeight.bold))),
                            SizedBox(height: TSizes.spaceBtwItems.h,),
                          InkWell(
                            onTap: () {
                              controllerget
                                  .isLowActivitySelectedFunction();
                              controllerget.activityFactorDetect();
                              controllerget.controller.nextPage(
                                  duration: const Duration(
                                      milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child:ChooseCard(controller: controllerget.isLowActivitySelected, text: "12".tr, image: 'assets/6.png'),
                          ),
                          SizedBox(height: 18.h),
                          InkWell(
                            onTap: () {
                              controllerget
                                  .isLightActivitySelectedFunction();
                              controllerget.activityFactorDetect();
                              controllerget.controller.nextPage(
                                  duration: const Duration(
                                      milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child:ChooseCard(controller: controllerget.isLightActivitySelected, text: "13".tr, image: 'assets/8.png'),
                          ),
                          SizedBox(height: 18.h),
                          InkWell(
                            onTap: () {
                              controllerget
                                  .isModerateActivitySelectedFunction();
                              controllerget.activityFactorDetect();
                              controllerget.controller.nextPage(
                                  duration: const Duration(
                                      milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child:ChooseCard(controller: controllerget.isModerateActivitySelected, text: "14".tr, image: 'assets/7.png'),
                          ),
                          SizedBox(height: 18.h),
                          InkWell(
                            onTap: () {
                              controllerget
                                  .isHeavyActivitySelectedFunction();
                              controllerget.activityFactorDetect();
                              controllerget.controller.nextPage(
                                  duration: const Duration(
                                      milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child:ChooseCard(controller: controllerget.isHeavyActivitySelected, text: "15".tr, image: 'assets/9.png'),
                          ),
                          SizedBox(height: 18.h),
                          InkWell(
                            onTap: () {
                              controllerget
                                  .isExtreemActivitySelectedFunction();
                              controllerget.activityFactorDetect();
                              controllerget.controller.nextPage(
                                  duration: const Duration(
                                      milliseconds: 500),
                                  curve: Curves.easeInOut);
                            },
                            child:ChooseCard(controller: controllerget.isExtreemActivitySelected, text: "16".tr, image: 'assets/10.png'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /// BIRTHDAY DATE SELECT ///
                  Scaffold(appBar: AppBar(title: const Text(
                      "Birthday Select",
                      style: TextStyle(
                          fontWeight: FontWeight.bold)),centerTitle: true,),
                    body: Container(
                       padding: EdgeInsets.symmetric(horizontal: 22.w,),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Container(
                              padding: EdgeInsets.only(top: TSizes.spaceBtwItems.h),
                              child:Text("17".tr, style: const TextStyle(fontWeight: FontWeight.bold))),
                          SizedBox(height: TSizes.spaceBtwItems.h,),
                          SizedBox(
                               height: 400.h,
                              child: CupertinoTheme(
                                  data: MaterialBasedCupertinoThemeData(materialTheme: dark?ThemeData.dark():ThemeData.light()),
                                  child: CupertinoDatePicker(
                                    minimumYear: 1950,
                                    maximumYear: 2013,
                                    initialDateTime: DateTime.utc(1950),
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
                                  borderRadius:
                                  BorderRadius.circular(15)),
                              onPressed: () {
                                controllerget.controller.nextPage(
                                    duration: const Duration(
                                        milliseconds: 500),
                                    curve: Curves.easeInOut);
                              },
                              child: const Text("Next", style: TextStyle(color: Colors.white)),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /// Money Fellow
                  Scaffold(appBar: AppBar(title: const Text(
                      "Budget Select",
                      style: TextStyle(
                          fontWeight: FontWeight.bold)),centerTitle: true,),
                     body: Container(
                       padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.only(top: 25.h),
                              child: Text(
                                  "25".tr,
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
                                      duration: const Duration(
                                          milliseconds: 500),
                                      curve: Curves.easeInOut);
                                },
                                child: ChooseCard(controller: controllerget.poorMoney, text: "22".tr, image: "assets/11.png",)),
                              SizedBox(height: 22.h),
                              InkWell(
                                onTap: () {
                                  controllerget
                                      .mediumCostDietIsSelected();
                                  controllerget.controller.nextPage(
                                      duration: const Duration(
                                          milliseconds: 500),
                                      curve: Curves.easeInOut);
                                },
                                child: ChooseCard(controller: controllerget.mediumMoney, text: "23".tr, image: "assets/12.png",),
                              ),
                              SizedBox(height: 22.h),
                              InkWell(
                                onTap: () {
                                  controllerget.highCostDietIsSelected();
                                  controllerget.controller.nextPage(
                                      duration: const Duration(
                                          milliseconds: 500),
                                      curve: Curves.easeInOut);
                                },
                                child: ChooseCard(controller: controllerget.richMoney, text: "24".tr, image: "assets/13.png",),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  /// MESUREMENTS OF BODY
                  Scaffold(appBar: AppBar(title: const Text(
                      "Birthday Select",
                      style: TextStyle(
                          fontWeight: FontWeight.bold)),centerTitle: true,),
                     body: Container(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                       child:SingleChildScrollView(
                        child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("26".tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10.h,),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  controllerget.isSelectedMan&&dark==true ?TImages.manDarkImage : controllerget.isSelectedMan&&dark==false ?TImages.manLightImage
                                      :controllerget.isSelectedWoMan&&dark==true ?TImages.womanDarkImage :TImages.womanLightImage,

                                  height: 250.h,
                                  // width: 200.w,
                                ),controllerget.isSelectedMan ?Column(
                                  children: [

                                    Form(key: controllerget.formKey.value,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 70.h,
                                            width: 100.w,
                                            child: TextFormField(
                                              maxLength: 3,
                                              keyboardType:
                                              TextInputType.number,

                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              onChanged: (value) => controllerget.weight.value = value,

                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "33".tr;
                                                }
                                                return null;
                                              },
                                              style: TextStyle(fontSize: 14.sp),
                                              textAlign: TextAlign.center,
                                              decoration:
                                              InputDecoration(
                                                counterText: '', // Clear default counter text
                                                errorStyle: const TextStyle(
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
                                                      Radius
                                                          .circular(
                                                          12)),
                                                ),
                                                border: const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .all(Radius
                                                        .circular(
                                                        12))),
                                                fillColor: const Color(
                                                    0xff1f1f1F),
                                                filled:dark? true:false,
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
                                              maxLength: 3,
                                              keyboardType:
                                              TextInputType.number,

                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              onChanged: (value) => controllerget.tall.value = value,

                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "33".tr;
                                                }
                                                return null;
                                              },
                                              style: TextStyle(fontSize: 14.sp),
                                              textAlign: TextAlign.center,
                                              decoration:
                                              InputDecoration(
                                                counterText: '', // Clear default counter text
                                                errorStyle: const TextStyle(
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
                                                      Radius
                                                          .circular(
                                                          12)),
                                                ),
                                                border: const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .all(Radius
                                                        .circular(
                                                        12))),
                                                fillColor: const Color(
                                                    0xff1f1f1F),
                                                filled:dark? true:false,
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
                                              maxLength: 3,
                                              keyboardType:
                                              TextInputType.number,

                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              onChanged: (value) => controllerget.waist.value = value,

                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "33".tr;
                                                }
                                                return null;
                                              },
                                              style: TextStyle(fontSize: 14.sp),
                                              textAlign: TextAlign.center,
                                              decoration:
                                              InputDecoration(
                                                counterText: '', // Clear default counter text
                                                 errorStyle: const TextStyle(
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
                                                      Radius
                                                          .circular(
                                                          12)),
                                                ),
                                                border: const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .all(Radius
                                                        .circular(
                                                        12))),
                                                fillColor: const Color(
                                                    0xff1f1f1F),
                                                filled:dark? true:false,
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
                                              maxLength: 3,
                                              keyboardType:
                                              TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              onChanged: (value) => controllerget.neck.value = value,

                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty ) {
                                                  return "33".tr;
                                                }
                                                return null;
                                              },
                                              style: TextStyle(
                                                  fontSize: 14.sp),
                                              textAlign:
                                              TextAlign.center,
                                              decoration:
                                              InputDecoration(
                                                counterText: '', // Clear default counter text

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
                                                      Radius
                                                          .circular(
                                                          12)),
                                                ),
                                                border: const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .all(Radius
                                                        .circular(
                                                        12))),
                                                fillColor: const Color(
                                                    0xff1f1f1F),
                                                filled:dark? true:false,
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
                                        maxLength: 3,
                                        keyboardType:
                                        TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        onChanged: (value) => controllerget.arms.value = value,

                                        validator: (value) {
                                          return "Optional";
                                        },
                                        style: TextStyle(
                                             fontSize: 14.sp),
                                        textAlign:
                                        TextAlign.center,
                                        decoration:
                                        InputDecoration(
                                          counterText: '', // Clear default counter text

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
                                                Radius
                                                    .circular(
                                                    12)),
                                          ),
                                          border: const OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .all(Radius
                                                  .circular(
                                                  12))),
                                          fillColor: const Color(
                                              0xff1f1f1F),
                                          filled:dark? true:false,
                                          hintText: "29".tr,
                                          hintStyle: TextStyle(
                                               fontSize: 14.sp),
                                        ),
                                      ),
                                    ),
                                    /// CALVES
                                    Center(
                                      child: SizedBox(
                                        height: 70.h,
                                        width: 100.w,
                                        child: TextFormField(
                                          maxLength: 3,
                                          keyboardType:
                                          TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          onChanged: (value) => controllerget.calves.value = value,

                                          style: TextStyle(
                                              fontSize: 14.sp),
                                          textAlign:
                                          TextAlign.center,
                                          decoration:
                                          InputDecoration(
                                            counterText: '', // Clear default counter text
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
                                                  Radius
                                                      .circular(
                                                      12)),
                                            ),
                                            border: const OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius
                                                    .all(Radius
                                                    .circular(
                                                    12))),
                                            fillColor: const Color(
                                                0xff1f1f1F),
                                            filled:dark? true:false,
                                            hintText: "30".tr,
                                            hintStyle: TextStyle(
                                                 fontSize: 14.sp),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ):Column(
                                  children: [

                                    Form(key: controllerget.womanFormKey.value,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 70.h,
                                            width: 100.w,
                                            child: TextFormField(
                                              maxLength: 3,
                                              keyboardType:
                                              TextInputType.number,

                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              onChanged: (value) => controllerget.weight.value = value,

                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "33".tr;
                                                }
                                                return null;
                                              },
                                              style: TextStyle(fontSize: 14.sp),
                                              textAlign: TextAlign.center,
                                              decoration:
                                              InputDecoration(
                                                counterText: '', // Clear default counter text
                                                errorStyle: const TextStyle(
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
                                                      Radius
                                                          .circular(
                                                          12)),
                                                ),
                                                border: const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .all(Radius
                                                        .circular(
                                                        12))),
                                                fillColor: const Color(
                                                    0xff1f1f1F),
                                                filled:dark? true:false,
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
                                              maxLength: 3,
                                              keyboardType:
                                              TextInputType.number,

                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              onChanged: (value) => controllerget.tall.value = value,

                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "33".tr;
                                                }
                                                return null;
                                              },
                                              style: TextStyle(fontSize: 14.sp),
                                              textAlign: TextAlign.center,
                                              decoration:
                                              InputDecoration(
                                                counterText: '', // Clear default counter text
                                                errorStyle: const TextStyle(
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
                                                      Radius
                                                          .circular(
                                                          12)),
                                                ),
                                                border: const OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .all(Radius
                                                        .circular(
                                                        12))),
                                                fillColor: const Color(
                                                    0xff1f1f1F),
                                                filled:dark? true:false,
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
                                              maxLength: 3,
                                              keyboardType:
                                              TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              onChanged: (value) => controllerget.waist.value = value,

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
                                                counterText: '', // Clear default counter text

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
                                                filled:dark? true:false,
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
                                              maxLength: 3,
                                              keyboardType:
                                              TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              onChanged: (value) => controllerget.neck.value = value,

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
                                                counterText: '', // Clear default counter text

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
                                                filled:dark? true:false,
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
                                              maxLength: 3,
                                              keyboardType:
                                              TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .digitsOnly,
                                              ],
                                              onChanged: (value) => controllerget.hip.value = value,

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
                                                counterText: '', // Clear default counter text

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
                                                filled:dark? true:false,
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
                                       maxLength: 3,
                                       keyboardType:
                                       TextInputType.number,
                                       inputFormatters: <TextInputFormatter>[
                                         FilteringTextInputFormatter
                                             .digitsOnly,
                                       ],
                                       onChanged: (value) => controllerget.chest.value = value,

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
                                         counterText: '', // Clear default counter text

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
                                         filled:dark? true:false,
                                         hintText: "32".tr,
                                         hintStyle: TextStyle(
                                              fontSize: 14.sp),
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
                                    child:  const Text("Next",
                                        style:
                                        TextStyle(color: Colors.white)),
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
                  title: const Text('Foods',),
                  iconTheme: const IconThemeData(color: Colors.blueAccent),
                  ),
                     body:GetBuilder<DietMakingController>(init:DietMakingController(),builder:(coachHomeController) => SingleChildScrollView(
                           child: Column(
                         children: [
                             Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 10),
                               child: TextFormField(
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
                             ),
                             const SizedBox(height: 10,),
                              SizedBox(height: 500,
                                   child:ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: coachHomeController.filteredFoodList.length,
                                          itemBuilder: (context, index) {
                                          bool isSelected = coachHomeController.selectedIndexes.contains(index);
                                               return GestureDetector(onTap: () {coachHomeController.toggleSelection(index);coachHomeController.update();},
                                                child: Card(color: isSelected ? Colors.blueAccent : const Color(0xFF1C1C1E),
                                                            child: ListTile(title: Text(coachHomeController.filteredFoodList[index].foodName, style: const TextStyle(color: Colors.white),),),),);},)),

                           Container(
                               padding: EdgeInsets.only(top: 20.h),
                               child: Center(
                                 child: MaterialButton(
                                   color: const Color(0xff1f1f1F),
                                   minWidth: 155,
                                   height: 45.h,
                                   splashColor: Colors.blueAccent,
                                   shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                   onPressed: () async{
                                     List<String> selectedFoodNames = coachHomeController.filteredFoodList.asMap().entries.where((entry) => coachHomeController.selectedIndexes.contains(entry.key)).map((entry) => entry.value.foodName).toList();
                                       controllerget.selectedFoods = selectedFoodNames.join(', ');

                                     await controllerget.finshClientForm();

                                   },
                                   child: const Text("Next", style: TextStyle(color: Colors.white)),
                                 ),
                               )),


                         ],

                                          ),
                     ),)),

                  SafeArea(
                    child: Scaffold(
                        body:SingleChildScrollView(
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
                                         Image(
                                           height: 120,
                                           image: AssetImage(dark ? TImages.lightAppLogo : TImages.darkAppLogo),
                                         ),
                                         Text(
                                           CTexts.appName,
                                           style: Theme.of(context).textTheme.headlineMedium,
                                         ),
                                       ],
                                     ),
                                   ),
                                   const SizedBox(height: 20,),
                                   const SizedBox(height: 20,),

                                   Center(
                                     child: Column(
                                         children: [




                                           Text("Hello, ${myServices.sharedPreferences.getString("first_name")} ${myServices.sharedPreferences.getString("second_name")}",style: Theme.of(context).textTheme.bodyMedium,),
                                           const SizedBox(height: 10,),

                                           Text("You're a ${controllerget.isSelectedMan? "Man":"Woman"} Weights ${controllerget.weight}kg with ${controllerget.tall}cm Tall",style: Theme.of(context).textTheme.bodyMedium,),
                                           const SizedBox(height: 10,),

                                           Text("your waist is ${controllerget.waist}cm your neck is ${controllerget.neck}cm",style: Theme.of(context).textTheme.bodyMedium,),
                                           const SizedBox(height: 10,),

                                           controllerget.arms.value.isNotEmpty?Text("Your arm is ${controllerget.arms}",style: Theme.of(context).textTheme.bodyMedium,):
                                           controllerget.chest.isNotEmpty? Text("Your chest is ${controllerget.chest}",style: Theme.of(context).textTheme.bodyMedium,):
                                           controllerget.calves.isNotEmpty?Text("Your calves is ${controllerget.calves}",style: Theme.of(context).textTheme.bodyMedium,):
                                           controllerget.hip.isNotEmpty?Text("Your calves is ${controllerget.hip}",style: Theme.of(context).textTheme.bodyMedium,):
                                           Text("Your Goal is ${controllerget.isSelectedLoseWeight? "Lose Weight" : controllerget.isSelectedMaintainWeight? "Maintain Weight": "Gain Weight" }"),
                                           const SizedBox(height: 10,),

                                           Text(controllerget.isLowActivitySelected ? "You Don't Train At All" :
                                           controllerget.isLightActivitySelected ? "You Train 1 or 2 Times" :
                                           controllerget.isModerateActivitySelected ? "You Train 3 to 5 Times" :
                                           controllerget.isHeavyActivitySelected ? "You Train 6 Times" : "Twice a Day"),
                                           const SizedBox(height: 10,),

                                           Text("Your Budget is ${controllerget.poorMoney? "Low" : controllerget.mediumMoney? "Medium": "High" }"),


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

                                                    // Get.offAllNamed(newRouteName);


                                                   },
                                                   child:  const Text("Next",
                                                       style:
                                                       TextStyle(color: Colors.white)),
                                                 ),
                                               )),


                                         ],
                                       ),
                                   ),


                                 ],
                               ),
                               // Form
                               const Padding(
                                 padding:EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
                                 child: Column(
                                   children: [

                                   ],
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
                            curve: Curves.easeInOut);},
                      icon: getIconBasedOnLanguage(),
                      color: dark?CColors.light:CColors.dark,
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
                        dotColor: dark?CColors.white:CColors.black,
                        strokeWidth:
                        0, // Set border width to 0 to remove the border
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if(controllerget.controller.page==0){
                          if(controllerget.isSelectedMan==true||controllerget.isSelectedWoMan==true){controllerget.controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);}else{}
                        }else if (controllerget.controller.page==1){
                          if(controllerget.isSelectedLoseWeight==true||controllerget.isSelectedGainWeight ==true||controllerget.isSelectedMaintainWeight==true){
                            controllerget.controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                          }else{}
                        }else if(controllerget.controller.page==2){
                          if(controllerget.isLowActivitySelected==true||controllerget.isLightActivitySelected ==true||controllerget.isModerateActivitySelected==true||controllerget.isHeavyActivitySelected==true||controllerget.isExtreemActivitySelected==true){
                            controllerget.controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);

                          }else{}
                        }else if(controllerget.controller.page==3){
                          if(controllerget.birthdayDate!=DateTime(1950, 1, 1)){controllerget.controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);}else{}
                        }else if (controllerget.controller.page==4){
                          if(controllerget.poorMoney==true||controllerget.mediumMoney ==true||controllerget.richMoney==true){
                            controllerget.controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                          }else{}
                        }else if (controllerget.controller.page==5){
                          controllerget.validateMeasuresForm();
                        }else if (controllerget.controller.page==6){
                          controllerget.finshClientForm();

                        }




                      },icon:getIconBackchervon(),

                      color: dark?CColors.light:CColors.dark,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
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
  if (localeController.language== const Locale("en")) {
    return const Icon(CupertinoIcons.chevron_forward);
  } else  {
    return const Icon(CupertinoIcons.chevron_back);
  }
}
Icon getIconBackchervon() {
  if (localeController.language== const Locale("en")) {
    return const Icon(CupertinoIcons.chevron_back);
  } else  {
    return const Icon(CupertinoIcons.chevron_forward);
  }
}




