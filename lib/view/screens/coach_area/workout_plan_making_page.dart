import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/api_controller.dart';
import '../../../main.dart';

class ClientInsertion extends StatelessWidget {
  final ApiController apiController = Get.put(ApiController());
  final signupkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController password = TextEditingController();

ClientInsertion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1c1c1e),
        centerTitle: true,
        title: const Text("Sign up"),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_sharp),
          color: Colors.blueAccent,
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22.w),
          child: Form(
            key: signupkey,
            child: Column(
              children: [
                Image(
                  height: 120.h,
                  image: const AssetImage("assets/100.png"),
                  fit: BoxFit.fitHeight,
                ),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty || value == 0) {
                      return "33".tr;
                    }
                    final emailRegex = RegExp(
                        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');

                    if (value.isEmpty) {
                      return "Email is required";
                    } else if (!emailRegex.hasMatch(value)) {
                      return "Invalid email address";
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.blueAccent),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent)),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    fillColor: const Color(0xff1f1f1F),
                    filled: true,
                    label: const Text("Email"),
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
                SizedBox(height: 8.h,),
                TextFormField(
                  controller: username,
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty || value == 0) {
                      return "33".tr;
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.blueAccent),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent)),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    fillColor: const Color(0xff1f1f1F),
                    filled: true,
                    label: const Text("Username"),
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
                SizedBox(height: 8.h,),
                TextFormField(
                  controller: firstname,
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty || value == 0) {
                      return "33".tr;
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.blueAccent),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent)),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    fillColor: const Color(0xff1f1f1F),
                    filled: true,
                    label: const Text("First Name"),
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
                SizedBox(height: 8.h,),
                TextFormField(
                  controller: lastname,
                  keyboardType: TextInputType.visiblePassword,
                  onSaved: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty || value == 0) {
                      return "33".tr;
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.blueAccent),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent)),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    fillColor: const Color(0xff1f1f1F),
                    filled: true,
                    label: const Text("Last Name"),
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                ),
                SizedBox(height: 8.h,),
                TextFormField(
                  controller: password,
                  obscureText: true, // Password is hidden
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(20),
                  ],
                  onSaved: (value) {
                    // Handle the saved password value here
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    errorStyle: TextStyle(color: Colors.blueAccent),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent)),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    fillColor: Color(0xff1f1f1F),
                    filled: true,
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 60.h),
                  child: Center(
                    child: MaterialButton(
                      color: const Color(0xff1f1f1F),
                      minWidth: 155,
                      height: 45.h,
                      splashColor: Colors.blueAccent,
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      onPressed: () async {
                     //   Int s=  as Int;

                        if (signupkey.currentState!.validate()) {
                          signupkey.currentState!.save();
                          await apiController.clientInsertion(
                            firstname.text.toString(),
                            lastname.text.toString(),
                            myServices.sharedPreferences.getInt("user")!.toString(),
                            username.text.toString(),
                            password.text.toString(),
                            email.text.toString(),
                          );
                        }
                      },
                     // String firstname,String secondname,Int coachId,String user, String pass, String email
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
