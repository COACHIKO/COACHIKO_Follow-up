import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
 import '../../../controller/auth_controllers/signup_controller.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/image_strings.dart';
import '../../../core/utils/constants/sizes.dart';
import '../../../core/utils/constants/text_strings.dart';
import '../../../core/utils/helpers/helper_functions.dart';
import '../../../core/utils/validators/validation.dart';
import '../../widgets/custom_appbar.dart';


class SignUp extends StatelessWidget {
  final SignUpController signUpController = Get.put(SignUpController());
    SignUp({super.key});
  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: dark ? Colors.white : Colors.black,
        ),),
      body: SingleChildScrollView(
         child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Column(
            children: [

              Center(
                child: Image(
                  height: 120,
                  image: AssetImage(dark ? TImages.lightAppLogo : TImages.darkAppLogo),
                ),
              ),
              Text(
                CTexts.appName,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: TSizes.sm),
              Text(
                CTexts.signupSubTitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
                Form(
                key: signUpController.signupkey,
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// First Name TextFormField
                        Expanded(
                          child: TextFormField(validator:CValidator.validateFirstName,
                            onChanged: (value) => signUpController.firstName.value = value,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: CTexts.firstName,
                              fillColor:CColors.secondary,
                              filled:dark? true:false,
                               hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),),
                            style: TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                        ),
                        const SizedBox(width: 16),
                        /// Second Name TextFormField
                        Expanded(
                          child: TextFormField(
                            validator:CValidator.validateSecondName,
                            onChanged: (value) => signUpController.secondName.value = value,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: CTexts.secondName,
                              fillColor:CColors.secondary,
                              filled:dark? true:false,
                              hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
                            ),
                            style: TextStyle(color: Colors.white, fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
                      SizedBox(height: 8.h),

                    TextFormField(
                      validator:CValidator.validateUsername,
                      onChanged: (value) => signUpController.username.value = value,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: CTexts.username,
                        fillColor:CColors.secondary,
                        filled:dark? true:false,

                         hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                      SizedBox(height: 8.h),
                    TextFormField(
                      validator:CValidator.validateEmail,

                      onChanged: (value) => signUpController.email.value = value,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: CTexts.email,
                        fillColor:CColors.secondary,
                        filled:dark? true:false,
                         hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                      SizedBox(height: 8.h),
                    TextFormField(
                      validator:CValidator.validatePassword,
                      onChanged: (value) => signUpController.password.value = value,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        labelText: CTexts.password,
                        fillColor:CColors.secondary,
                        filled:dark? true:false,
                         hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                      SizedBox(height: 8.h),
                    Obx(() => signUpController.isCoach.value == false
                        ? Container(padding: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(color:   dark?Color(0xff1f1f1F):Colors.white,borderRadius: BorderRadius.circular(12) ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:
                      [
                        SizedBox(width: 150,
                          child: TextFormField(
                            onChanged: (value) => signUpController.coachUserName.value = value,
                            keyboardType: TextInputType.name,
                            onSaved: (value) {},
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "33".tr;
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white, fontSize: 14.sp),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                               focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff1f1f1F))),
                          labelText: CTexts.coachUser,
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(Radius.circular(12))),
                              fillColor:CColors.secondary,
                              filled:dark? true:false,
                               hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Row(mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Text(CTexts.coachOrClient),
                                    Text(CTexts.youClient,),

                                  ],
                                ),
                                InkWell(
                                  enableFeedback: false, // Disable the splash effect
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    signUpController.isCoach.value = !signUpController.isCoach.value;
                                   },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: signUpController.isCoach.value ==false? const Color(0xff797979) : CColors.primary,
                                      border: Border.all(
                                        width: 0,
                                      ),

                                    ),
                                    width: 25,
                                    height: 25,
                                    child: const Center(
                                      child: Icon(Icons.check, color: CColors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),],),
                    )
                        : Container(decoration: BoxDecoration(color:  dark? Color(0xff1f1f1F):Colors.white,borderRadius: BorderRadius.circular(12) ),
                      child: SizedBox(width: 337.1,height: 65,
                        child: Container(padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                            Text(CTexts.youCoach,),
                            InkWell(
                              enableFeedback: false, // Disable the splash effect
                              splashColor: Colors.transparent,
                              onTap: () {
                                signUpController.isCoach.value = !signUpController.isCoach.value;
                               },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: signUpController.isCoach.value ==false? const Color(0xff797979) : Colors.blueAccent,
                                  border: Border.all(
                                    width: 0,
                                  ),
                                ),
                                width: 25,
                                height: 25,
                                child: const Center(
                                  child: Icon(Icons.check, color: Color(0xfff6f6f6)),
                                ),
                              ),
                            ),

                          ],),
                        ),
                      ),
                    ), ),
                  ],
                ),
              ),
                SizedBox(height: 16.h),
                Center(
                child: MaterialButton(
                  color: const Color(0xff1f1f1F),
                  minWidth: 155,
                  height: 45.h,
                  splashColor: Colors.blueAccent,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  onPressed: signUpController.signUp,
                  child: Text(
                    CTexts.register,
                    style: const TextStyle(color: Colors.white),
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
