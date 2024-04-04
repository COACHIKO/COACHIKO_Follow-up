import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/utils/constants/image_strings.dart';
import '../../../core/utils/constants/text_strings.dart';

class ForkUseringPage extends StatelessWidget {
  const ForkUseringPage({super.key});
  @override
  Widget build(BuildContext context) {
    // AuthService authService = AuthService();
    return Scaffold(
        body: Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/bs.png",
                    ),
                    fit: BoxFit.fitWidth)),
          ),
          Container(
            margin: EdgeInsets.only(top: 520.h),
            padding: EdgeInsets.symmetric(
              horizontal: 14.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                  onPressed: () async => () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                            width: 20,
                            image: AssetImage(TImages.google),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            CTexts.signInWithGoogle,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/signup");
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      textAlign: TextAlign.center,
                      CTexts.signInWithEmail,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                InkWell(
                    onTap: () {
                      Get.toNamed("/login");
                    },
                    child: Text(
                      CTexts.haveAccLogin,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.white),
                    ))
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
