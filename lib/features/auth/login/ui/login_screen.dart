import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/core/networking/api_service.dart';
import 'package:followupapprefactored/features/modules/coach/navigation_bar/ui/coach_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/image_strings.dart';
import '../../../../../../core/utils/constants/sizes.dart';
import '../../../../../../core/utils/constants/text_strings.dart';
import '../../../../../../core/utils/helpers/helper_functions.dart';
import '../../../../../core/utils/validators/validation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:followupapprefactored/main.dart';

import '../data/models/login_request_body.dart';
import '../data/repository/login_repo_impl.dart';

class LoginPage extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());
  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: dark ? Colors.white : Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Obx(
              () => Form(
                key: _loginController.formKey.value,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Image(
                            height: 120,
                            image: AssetImage(dark
                                ? TImages.lightAppLogo
                                : TImages.darkAppLogo),
                          ),
                        ),
                        Text(
                          CTexts.appName,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: TSizes.sm),
                        Text(
                          CTexts.loginSubTitle,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    // Form
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: TSizes.spaceBtwSections),
                      child: Column(
                        children: [
                          // Username Or Email TEXTFORMFIELD
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: CTexts.usernameOrEmail),
                            validator: CValidator.validateUsernameOrEmail,
                            onChanged: (value) =>
                                _loginController.username.value = value,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: TSizes.spaceBtwInputFields),
                          // Password TEXTFORMFIELD
                          TextFormField(
                            onChanged: (value) =>
                                _loginController.password.value = value,
                            validator: CValidator
                                .validatePassword, // Validation for password
                            obscureText: _loginController.obscurePassword.value,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.password_outlined),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _loginController.obscurePassword.value
                                        ? Iconsax.eye_slash
                                        : Iconsax.eye),
                                onPressed:
                                    _loginController.togglePasswordVisibility,
                              ),
                              labelText: CTexts.password,
                            ),
                          ),
                          const SizedBox(
                              height: TSizes.spaceBtwInputFields / 2),
                          // Remember me & Forget Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Remember me
                              Row(
                                children: [
                                  Checkbox(
                                    value: _loginController.rememberMe.value,
                                    onChanged:
                                        _loginController.toggleRememberMe,
                                  ),
                                  Text(CTexts.rememberMe),
                                ],
                              ),

                              // Forget Password
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  CTexts.forgetPassword,
                                  style:
                                      const TextStyle(color: CColors.primary),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: TSizes.spaceBtwSections),
                          // Sign In button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _loginController.signIn();
                              },
                              child: Text(CTexts.signIn),
                            ),
                          ),

                          const SizedBox(height: TSizes.spaceBtwItems),
                        ],
                      ),
                    ),
                    // Divider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Divider(
                            color: dark ? CColors.darkGrey : CColors.grey,
                            thickness: 0.5,
                            indent: 60,
                            endIndent: 5,
                          ),
                        ),
                        Text(
                          CTexts.orSignInWith,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Flexible(
                          child: Divider(
                            color: dark ? CColors.darkGrey : CColors.grey,
                            thickness: 0.5,
                            indent: 5,
                            endIndent: 60,
                          ),
                        ),
                      ],
                    ),
                    // Footer
                    const SizedBox(height: TSizes.spaceBtwSections),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: CColors.grey),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Image(
                              width: TSizes.iconMd,
                              height: TSizes.iconMd,
                              image: AssetImage(TImages.google),
                            ),
                          ),
                        ),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: CColors.grey),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Image(
                              width: TSizes.iconMd,
                              height: TSizes.iconMd,
                              image: AssetImage(TImages.facebook),
                            ),
                          ),
                        ),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: CColors.grey),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Image(
                              width: TSizes.iconMd,
                              height: TSizes.iconMd,
                              image: AssetImage(TImages.appleLogo),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class LoginController extends GetxController {
  final LoginRepoImp loginRepoImp = LoginRepoImp(ApiService(Dio()));
  var username = ''.obs;
  var password = ''.obs;
  var obscurePassword = true.obs;
  var rememberMe = false.obs;
  String firebaseToken = "";
  var formKey = GlobalKey<FormState>().obs;
  void togglePasswordVisibility() {
    obscurePassword.toggle();
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  void getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    firebaseToken = token.toString();
  }

  @override
  void onInit() {
    getToken();
    super.onInit();
  }

  void signIn() async {
    if (formKey.value.currentState!.validate()) {
      var response = await loginRepoImp.login(
        LoginRequestBody(
          username: username.value.toString(),
          password: password.value.toString(),
          token: firebaseToken.toString(),
        ),
        rememberMe.value,
      );

      if (response.status == "Success") {
        myServices.sharedPreferences.setInt("user", response.userData!.id);
        myServices.sharedPreferences
            .setString("first_name", response.userData!.firstName);
        myServices.sharedPreferences
            .setString("second_name", response.userData!.secondName);
        myServices.sharedPreferences
            .setString("email", response.userData!.email);
        myServices.sharedPreferences
            .setInt("RelatedtoCoachID", response.userData!.relatedToCoachID);
        myServices.sharedPreferences
            .setInt("currentStep", response.userData!.currentStep);
        myServices.sharedPreferences
            .setInt("isCoach", response.userData!.isCoach == "Coach" ? 1 : 0);
        myServices.sharedPreferences.setBool("rememberMe", rememberMe.value);

        if (response.userData!.isCoach == "Client") {
          Get.offAll(const CoachNavigationBar());
        } else {
          Get.offAll(const CoachNavigationBar());
        }

        // Show welcome message
        Fluttertoast.showToast(
          msg:
              'Welcome, ${myServices.sharedPreferences.getString("first_name")}',
          backgroundColor: Colors.green,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_SHORT,
        );
      } else {
        Fluttertoast.showToast(
          backgroundColor: Colors.red,
          textColor: Colors.white,
          msg: response.message.toString(),
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    }
  }
}
