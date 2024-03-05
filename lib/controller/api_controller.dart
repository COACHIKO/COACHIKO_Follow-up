import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../data/model/client_user_model.dart';
import '../data/model/food_model.dart';
import '../data/model/routine_model.dart';
import '../linkapi.dart';
import '../main.dart';
import '../view/screens/auth/fork_usering_page.dart';
import '../view/screens/client_area/client_home_screen.dart';
 import '../view/screens/coach_area/coach_home_page.dart';
import 'caches_controller/cache_controller.dart';
 import 'diet_make_controller.dart';
import 'routines_page_controller.dart';

class ApiController extends GetxController {
  /// Dependency Injection
  static ApiController get instance =>Get.find();
  final homeController = Get.put(RoutinesPageController());
  final coachHomeController = Get.put(DietMakingController());
  final cacheController = Get.put(CacheController());
  //final dietQuantityInsertionController = Get.put(DietQuantitiesController());


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    homeController.openHiveBox();
  }



  /// register Function
  Future<void> register(String firstName,String secondName,String isCoach,String coachusername,String user, String pass, String email,) async {
    var url = Uri.http(AppLink.server,AppLink.signUpKey);
    var response = await http.post(url, body: {
      "first_name": firstName,
      "second_name": secondName,
      "isCoach": isCoach,
      "coach_user_name": coachusername,
      "username": user,
      "email": email,
      "password": pass,
    });
    var data = json.decode(response.body);

    if (data == "Error") {
      Fluttertoast.showToast(
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        msg: 'User already exists!',
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Get.offAll(const ForkUseringPage());
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'Registration Successful',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
  /// login Function
  Future<void> login(String user, String pass,rememberme) async {
    var url = Uri.http(AppLink.server, AppLink.signInKey,);
    var response = await http.post(url, body: {
      "username": user,
      "password": pass,
    });
    var data = json.decode(response.body);

    if (data["status"].toString() == "Success") {
      if(rememberme==true){
      myServices.sharedPreferences.setInt("user", data["data"]["id"]);
      myServices.sharedPreferences.setInt("RelatedtoCoachID", data["data"]["RelatedtoCoachID"]);
      myServices.sharedPreferences.setInt("isCoach", data["data"]["isCoach"]);
      myServices.sharedPreferences.setString("first_name", data["data"]["first_name"]);
      myServices.sharedPreferences.setString("second_name", data["data"]["second_name"]);

      if(data["data"]["isCoach"]==0){
        Get.offAll(const HomePage());
      }else{
        Get.offAll(const CoachHome());

      }
      }else{

        if(data["data"]["isCoach"]==0){
          Get.offAll(const HomePage());
        }else{
          Get.offAll(const CoachHome());

        }
      }



      Fluttertoast.showToast(
        msg: 'Welcome, ${myServices.sharedPreferences.getString("first_name")}',
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Username and password invalid',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
  /// Get Routine Data
  Future<void> fetchRoutineData() async {
    var url = Uri.http(AppLink.server, AppLink.getWorkoutRoutineData,);

    try {
      // Making a POST request to the server
      final response = await http.post(url, body: {
        "user": myServices.sharedPreferences.getInt("user").toString(), // Replace with the actual user ID
      });

      // Checking if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        // Parsing the response body as JSON
        final data = json.decode(response.body);

        // Mapping the received data to a list of Routine objects
        homeController.routines = (data['data'] as Map<String, dynamic>).entries.map((entry) {
          return Routine.fromJson({
            'routineName': entry.key,
            'exercises': entry.value,
          });
        }).toList();

        // homeController.saveData((data['data'] as Map<String, dynamic>).entries.map((entry) {
        //   return Routine.fromJson({
        //     'routineName': entry.key,
        //     'exercises': entry.value,
        //   });
        // }).toList());


      } else {
        // Displaying a toast message if the request fails
        Fluttertoast.showToast(
          msg: 'Failed to load user data',
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG,
        );
      }
    } catch (error) {
      // Printing the error if an exception occurs
    }
  }
  /// Get Clients Data For Coach
  Future<void> getCoachClients() async {
    var url = Uri.http(AppLink.server, AppLink.getCoachClient);

    try {
      final response = await http.post(url, body: {
        "id": myServices.sharedPreferences.getInt("user").toString(), // Replace with the actual user ID
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data != null && data['status'] == 'Success') {
          if (data['data'] is List) {
            List<ClientUser> userList = (data['data'] as List)
                .map((userJson) => ClientUser.fromJson(userJson))
                .toList();

            coachHomeController.coachClients = userList;
            update();
          } else {
            // Handle the case where 'data' is not a list
            Fluttertoast.showToast(
              msg: 'Invalid data format',
              backgroundColor: Colors.red,
              textColor: Colors.white,
              toastLength: Toast.LENGTH_LONG,
            );
          }
        } else {
          // Handle the case where the server responds with an error
          Fluttertoast.showToast(
            msg: 'Failed to load user data',
            backgroundColor: Colors.red,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG,
          );
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: '$error',
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
      );
}
  }
  /// Client insertion
  Future<void> clientInsertion(String firstname,String secondname,var coachId,String user, String pass, String email) async {
    var url = Uri.http(AppLink.server, '${AppLink.coacharea}insertPlayer.php', {'q': '{http}'});
    var response = await http.post(url, body: {
      "first_name": firstname,
      "second_name": secondname,
      "username": user,
      "email": email,
      "password": pass,
      "RelatedtoCoachID": coachId,
    });
    var data = json.decode(response.body);

    if (data == "Error") {
      Fluttertoast.showToast(
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        msg: 'User already exists!',
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      //Get.to(const CoachClients());
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: 'Registration Successful',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
  /// Get FoodData
  Future<void> getFoodData() async {
    final response = await http.get(Uri.parse(AppLink.getDietDataAPI));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      coachHomeController.foodList = data.map((item) => FoodDataModel.fromJson(item)).toList();

    } else {
    }
  }

  Future<void> dietGetForClient() async {
    final response = await http.post(
      Uri.parse(AppLink.dietGetFClient),
      body: {'client_id':myServices.sharedPreferences.getInt("user").toString()},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedData = jsonDecode(response.body);

      DietApiGet dietApiGet = DietApiGet.fromJson(decodedData);
      coachHomeController.dietData = dietApiGet.data;
      update();
    } else {
      // Handle error
    }
  }









  Future<void> updateClientData(
      fatPercentage,
      id,
      genderSelect,
      goalSelect,
      String activitySelect,
      birthdayDate,
      weight,
      tall,
      costSelect,
      waist,
      neck,
      hip,
      tdee,
      preferredFoods,
      chest,
      arms,
      wrist,
      targetProtein,
      targetCarb,
      targetFat,
       currentStep,
      ) async {
    try {
      var url = Uri.http(
        AppLink.server,'/coachikoFollowApp/client_user_data_insert_update.php',
      );
      var response = await http.post(url, body: {
        "fatPercentage": fatPercentage.toString(),
        "id": id.toString(),
        "preferedFoods": preferredFoods.toString(),
        "genderSelect": genderSelect.toString(),
        "goalSelect": goalSelect.toString(),
        "activitySelect": activitySelect.toString(),
        "weight": weight.toString(),
        "tall": tall.toString(),
        "costSelect": costSelect.toString(),
        "waist": waist.toString(),
        "neck": neck.toString(),
        "hip": hip.toString(),
        "chest": chest.toString(),
        "arms": arms.toString(),
        "wrist": wrist.toString(),
        "tdee": tdee.toString(),
        "targetProtien": targetProtein.toString(),
        "targetCarbohdrate": targetCarb.toString(),
        "targetFat": targetFat.toString(),
        "current_step": currentStep.toString(),
        "birthdayDate": birthdayDate,

      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data["status"] == "Error") {
          Fluttertoast.showToast(
            backgroundColor: Colors.orange,
            textColor: Colors.white,
            msg: '${data["message"]}',
            toastLength: Toast.LENGTH_SHORT,
          );
        } else {
          Fluttertoast.showToast(
            backgroundColor: Colors.green,
            textColor: Colors.white,
            msg: '${data["message"]}',
            toastLength: Toast.LENGTH_SHORT,
          );
        }
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'An error occurred: $e',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }



































}
