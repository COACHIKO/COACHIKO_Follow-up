import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:followupapprefactored/core/networking/api_service.dart';
import 'package:iconsax/iconsax.dart';
import '../data/repository/login_repo_impl.dart';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/image_strings.dart';
import '../../../../../../core/utils/constants/sizes.dart';
import '../../../../../../core/utils/constants/text_strings.dart';
import '../../../../../../core/utils/helpers/helper_functions.dart';
import '../../../../../core/utils/validators/validation.dart';
import '../logic/cubit/login_cubit.dart';
import '../logic/cubit/login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(LoginRepoImp(ApiService(Dio()))),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: THelperFunctions.isDarkMode(context)
                ? Colors.white
                : Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                var cubit = context.read<LoginCubit>();
                var dark = THelperFunctions.isDarkMode(context);
                return Form(
                  key: state.formKey,
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
                              onChanged: (value) => cubit.setUsername(value),
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(height: TSizes.spaceBtwInputFields),
                            // Password TEXTFORMFIELD
                            TextFormField(
                              onChanged: (value) => cubit.setPassword(value),
                              validator: CValidator
                                  .validatePassword, // Validation for password
                              obscureText: state.obscurePassword,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.password_outlined),
                                suffixIcon: IconButton(
                                  icon: Icon(state.obscurePassword
                                      ? Iconsax.eye_slash
                                      : Iconsax.eye),
                                  onPressed: cubit.togglePasswordVisibility,
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
                                      value: state.rememberMe,
                                      onChanged: cubit.toggleRememberMe,
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
                                onPressed: cubit.signIn,
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
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
