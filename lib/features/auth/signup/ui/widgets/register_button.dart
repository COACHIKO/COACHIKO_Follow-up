import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/constants/text_strings.dart';
import '../../logic/signup_controller.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key, required this.signUpController,
  });
  final SignUpController signUpController;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: const Color(0xff1f1f1F),
      minWidth: 155,
      height: 45.h,
      splashColor: Colors.blueAccent,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onPressed: () async {
        await signUpController.signUp();
      },
      child: Text(
        CTexts.register,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
