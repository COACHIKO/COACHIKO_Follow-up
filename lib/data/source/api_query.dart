import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:followupapprefactored/view/screens/coach_area/routine_edit_page.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../controller/client_controllers/routines_page_controller.dart';
import '../../controller/coach_controllers/diet_make_controller.dart';
import '../../data/model/client_user_model.dart';
import '../../data/model/food_model.dart';
import '../../data/model/routine_model.dart';
import '../../linkapi.dart';
import '../../main.dart';
import '../../view/screens/auth/fork_usering_page.dart';
import '../../view/screens/client_area/client_home_screen.dart';
import '../../view/screens/coach_area/coach_home_page.dart';
import '../../view/screens/coach_area/workout_plan_making_page.dart';

class ApiCalls {
  /// Dependency Injection
  final homeController = Get.put(RoutinesPageController());
  final coachHomeController = Get.put(DietMakingController());
  final exerciseDataBaseController = Get.put(ExerciseController());

  /// register Function

  /// Get Routine Data


  //  Future<void> fetchRoutineData() async {
  //    final mybox = await Hive.openBox<String>('routines');
  //
  //    if (mybox.containsKey('data')) {
  //      print("============== Read From Hive ===============");
  //      var jsonData = mybox.get('data');
  //      if (jsonData != null) {
  //        var data = json.decode(jsonData);
  //        if (data != null && data is Map<String, dynamic>) {
  //          List<Routine> routines = parseRoutines(data);
  //          if (routines.isNotEmpty) { // Check if routines list is not empty
  //            homeController.routines = routines;
  //            print(routines[0].name);
  //            homeController.update();
  //          } else {
  //            print("No routines found in Hive data.");
  //          }
  //        } else {
  //          print("Failed to parse data retrieved from Hive.");
  //        }
  //      } else {
  //        print("No data retrieved from Hive.");
  //      }
  //    }
  // else {
  //      print("No 'data' key found in Hive.");
  //    }
  //
  //    var url = Uri.http(AppLink.server, AppLink.getWorkoutRoutineData);
  //    final response = await http.post(url, body: {
  //      "user": myServices.sharedPreferences.getInt("user").toString(),
  //    });
  //
  //    if (response.statusCode == 200) {
  //      var data = json.decode(response.body);
  //      List<Routine> routines = parseRoutines(data);
  //      homeController.routines = routines;
  //      // Update Hive and file (optional, if data always needs to be saved)
  //      mybox.put('data', json.encode(data));
  //      print("============ DATA UPDATED  ==============");
  //      update(); // تحديث العرض في الواجهة الرسومية
  //    } else {
  //      // Handle network error
  //      print("Failed to fetch data from server. Status code: ${response.statusCode}");
  //    }
  //  }
  //
  //  List<Routine> parseRoutines(Map<String, dynamic>? data) {
  //    if (data == null || data['data'] == null) {
  //      return [];
  //    }
  //    return (data['data'] as Map<String, dynamic>).entries.map((entry) {
  //      return Routine.fromJson({
  //        'routineName': entry.key,
  //        'exercises': entry.value,
  //      });
  //    }).toList();
  //  }
  //
  //  Future<void> fetchRoutineDataForCoach(id) async {
  //    var url = Uri.http(AppLink.server, AppLink.getWorkoutRoutineData);
  //    final response = await http.post(url, body: {
  //      "user": id.toString(),
  //    });
  //
  //    if (response.statusCode == 200) {
  //      var data = json.decode(response.body);
  //      List<Routine> routines = parseRoutines(data);
  //      homeController.clientRoutines = routines;
  //      // Update Hive and file (optional, if data always needs to be saved)
  //      update(); // تحديث العرض في الواجهة الرسومية
  //    } else {
  //      // Handle network error
  //      print("Failed to fetch data from server. Status code: ${response.statusCode}");
  //    }
  //  }

  /// Get Clients Data For Coach
  Future<void> getCoachClients() async {
    var url = Uri.http(AppLink.server, AppLink.getCoachClient);

    try {
      final response = await http.post(url, body: {
        "id": myServices.sharedPreferences
            .getInt("user")
            .toString(), // Replace with the actual user ID
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data != null && data['status'] == 'Success') {
          if (data['data'] is List) {
            List<ClientUser> userList = (data['data'] as List)
                .map((userJson) => ClientUser.fromJson(userJson))
                .toList();

            coachHomeController.coachClients = userList;
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
  Future<void> clientInsertion(String firstname, String secondname, var coachId,
      String user, String pass, String email) async {
    var url = Uri.http(AppLink.server, '${AppLink.coacharea}insertPlayer.php',
        {'q': '{http}'});
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
      coachHomeController.foodList =
          data.map((item) => FoodDataModel.fromJson(item)).toList();
    } else {}
  }

  Future<void> dietGetForClient() async {
    final response = await http.post(
      Uri.parse(AppLink.dietGetFClient),
      body: {
        'client_id': myServices.sharedPreferences.getInt("user").toString()
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedData = jsonDecode(response.body);

      DietApiGet dietApiGet = DietApiGet.fromJson(decodedData);
      coachHomeController.dietData = dietApiGet.data;
     } else {
      // Handle error
    }
  }
  // Future<void> getAllExercises() async {
  //   var request = http.MultipartRequest('POST', Uri.parse('192.168.1.6/coachikoFollowApp/get_excersise_data.php'));
  //
  //
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body);
  //
  //     exerciseController.exercises = response.map((item) => FoodDataModel.fromJson(item)).toList();
  //
  //     print(await response.stream.bytesToString());
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  //
  // }

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
        AppLink.server,
        '/coachikoFollowApp/client_user_data_insert_update.php',
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

  Future<void> getExercises() async {
    final url = Uri.parse(
        'http://192.168.1.6/coachikoFollowApp/get_excersise_data.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final exercises = data['data'] as List;

        // Map JSON data to ExerciseDatabaseModel objects
        final mappedExercises =
        exercises.map((exercise) => Exercise.fromJson(exercise)).toList();

        // Assuming exerciseDataBaseController.exercises is RxList<ExerciseDatabaseModel>
        assignExercises(mappedExercises);
      } catch (e) {
        // Handle any exceptions that might occur during decoding or mapping
        print('Error: $e');
      }
    } else {
      // Throw an exception if the response status code is not 200
      throw Exception('Failed to load exercises');
    }
  }

// Function to assign exercises to RxList
  void assignExercises(List<Exercise> exercises) {
    exerciseDataBaseController.exercises.assignAll(exercises);
    exerciseDataBaseController.selectedExercises.assignAll(exercises);
  }

  Future<void> addEditRoutine(String routinename, user_id, routine_id) async {
    var url = Uri.http(
        AppLink.server, "${AppLink.fetchDirectory}routine_insertion.php");
    var response = await http.post(url, body: {
      "routinename": routinename.toString(),
      "user_id": user_id.toString(),
      if (routine_id != null)
        "routine_id":
        routine_id.toString(), // Include routine_id only if it's not null
    });
    var data = json.decode(response.body);
    if (data["status"] == "error") {
      Fluttertoast.showToast(
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        msg: data["message"],
        toastLength: Toast.LENGTH_SHORT,
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.green,
        textColor: Colors.white,
        msg: data["message"],
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
}
