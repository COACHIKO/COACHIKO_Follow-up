import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/text_strings.dart';
import '../../../logic/signup_controller.dart';

class ClientFormField extends StatelessWidget {
  const ClientFormField({
    super.key,
    required this.dark,
    required this.signUpController,
  });

  final bool dark;
  final SignUpController signUpController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: dark ? const Color(0xff1f1f1F) : Colors.white,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150,
            child: TextFormField(
              onChanged: (value) =>
                  signUpController.coachUserName.value = value,
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
                fillColor: CColors.secondary,
                filled: dark ? true : false,
                hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(CTexts.coachOrClient),
                      Text(
                        CTexts.youClient,
                      ),
                    ],
                  ),
                  InkWell(
                    enableFeedback: false, // Disable the splash effect
                    splashColor: Colors.transparent,
                    onTap: () {
                      signUpController.toggleCoach();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: signUpController.isCoach.value == false
                            ? const Color(0xff797979)
                            : CColors.primary,
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
          ),
        ],
      ),
    );
  }
}
