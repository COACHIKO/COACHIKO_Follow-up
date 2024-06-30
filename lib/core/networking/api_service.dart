// import 'package:dio/dio.dart';
// import 'package:followupapprefactored/features/auth/login/data/models/login_request_body.dart';
// import 'package:followupapprefactored/features/auth/login/data/models/login_response.dart';
// import 'package:followupapprefactored/features/modules/client/features/routine/routine_get/data/models/routine_response.dart';
// import 'package:followupapprefactored/features/modules/coach/clients_display/data/models/clients_response.dart';
// import 'package:followupapprefactored/linkapi.dart';
// import 'package:retrofit/retrofit.dart';

// import '../../features/food_data_get/data/models/food_model.dart';
// import '../../features/modules/client/features/diet/data/models/diet_request_body.dart';
// import '../../features/modules/client/features/diet/data/models/diet_response.dart';
// import '../../features/modules/client/features/routine/routine_get/data/models/routine_request_body.dart';
// import '../../features/modules/coach/clients_display/data/models/clients_data_request_body.dart';
// part 'api_service.g.dart';

import 'package:dio/dio.dart';
import 'package:followupapprefactored/features/auth/login/data/models/login_request_body.dart';
import 'package:followupapprefactored/features/modules/client/routine/routine_get/data/models/routine_request_body.dart';
import 'package:followupapprefactored/features/modules/client/routine/routine_log/data/models/routine_log_request_body.dart';
import 'package:followupapprefactored/features/modules/coach/workout_routine_making_features/quantities_entering/data/models/exercises_assignment_request_body.dart';
import '../../features/auth/signup/data/models/signup_request_model.dart';
import '../../features/modules/client/diet/data/models/diet_request_body.dart';
import '../../features/modules/client/phases_cases/form_completion/data/models/form_completion_request_body.dart';
import '../../features/modules/client/phases_cases/waiting_phase/data/models/current_stage_request_body.dart';
import '../../features/modules/coach/all_clients_display/data/models/clients_data_request_body.dart';
import '../../features/modules/coach/diet_making_features/quantities_entering/data/models/quantity_insertion_request_body.dart';
import '../../features/modules/coach/workout_routine_making_features/display_client_routine/data/models/routine_crud_request_body.dart';

class ApiService {
  final Dio _dio;
//
  ApiService(this._dio);
  // String baseUrl = "https://d200-156-204-91-232.ngrok-free.app";
  String baseUrl = "http://192.168.1.6";

  Future<List<dynamic>> getFoodsData() async {
    var response = await _dio.get(
        "$baseUrl/CoachikoFollowUpApp_Back_End/get_data/get_food_data.php");
    return response.data;
  }

  Future<List<dynamic>> getExercisesData() async {
    var response = await _dio.get(
        "$baseUrl/CoachikoFollowUpApp_Back_End/get_data/get_excersise_data.php");
    return response.data;
  }

  /// Auth Services
  Future<Map<String, dynamic>> login(
      {required LoginRequestBody loginRequestBody}) async {
    var response = await _dio.post(
        "$baseUrl/CoachikoFollowUpApp_Back_End/auth/login.php",
        data: loginRequestBody.toJson());
    return response.data;
  }

  Future<Map<String, dynamic>> register(
      {required SignupRequestBody signupRequestBody}) async {
    var response = await _dio.post(
        "$baseUrl/CoachikoFollowUpApp_Back_End/auth/register.php",
        data: signupRequestBody.toJson());
    return response.data;
  }

  Future<Map<String, dynamic>> getCurrentStage(
      {required CurrentStageRequestBody currentStageRequestBody}) async {
    var response = await _dio.post(
        "$baseUrl/CoachikoFollowUpApp_Back_End/client_area/get_status.php",
        data: currentStageRequestBody.toJson());
    return response.data;
  }

  /// Data Retrieval Services
  Future<Map<String, dynamic>> getRoutine(
      {required RoutineRequestBody routineRequestBody}) async {
    var response = await _dio.post(
        "$baseUrl/CoachikoFollowUpApp_Back_End/client_area/get_routine_data.php",
        data: routineRequestBody.toJson());
    return response.data;
  }

  Future<Map<String, dynamic>> routineLog(
      {required RoutineLogRequestBody routineLogRequestBody}) async {
    var response = await _dio.post(
        "$baseUrl/CoachikoFollowUpApp_Back_End/client_area/routine_log.php",
        data: routineLogRequestBody.toJson());
    return response.data;
  }

  Future<Map<String, dynamic>> getDiet(
      {required DietRequestBody dietRequestBody}) async {
    var response = await _dio.post(
        "$baseUrl/CoachikoFollowUpApp_Back_End/client_area/diet_get_for_client.php",
        data: dietRequestBody.toJson());
    return response.data;
  }

  Future<Map<String, dynamic>> completeForm(
      {required FormCompletionRequestBody formCompletionRequestBody}) async {
    var response = await _dio.post(
        "$baseUrl/coachikoFollowApp/client_user_data_insert_update.php",
        data: formCompletionRequestBody.toJson());
    return response.data;
  }

  Future<Map<String, dynamic>> getClients(
      {required ClientsDataRequestBody clientsDataRequestBody}) async {
    var response = await _dio.post(
        "$baseUrl/CoachikoFollowUpApp_Back_End/coach_area/get_coach_clients.php",
        data: clientsDataRequestBody.toJson());
    return response.data;
  }

  Future<Map<String, dynamic>> foodQuantityEnter(
      {required QuantityInsertionRequestBody
          quantityInsertionRequestBody}) async {
    var response = await _dio.post(
        "$baseUrl/CoachikoFollowUpApp_Back_End/coach_area/diet_insert_for_client.php",
        data: quantityInsertionRequestBody.toJson());
    return response.data;
  }

  Future<Map<String, dynamic>> routineInsert(
      {required RoutineInsertRequestBody routineInsertRequestBody}) async {
    var response = await _dio.post(
        "$baseUrl/CoachikoFollowUpApp_Back_End/coach_area/routine_insertion.php",
        data: routineInsertRequestBody.toJson());
    return response.data;
  }

  Future<Map<String, dynamic>> routineUpdate(
      {required RoutineUpdateRequestBody routineUpdateRequestBody}) async {
    var response = await _dio.post(
        "$baseUrl/CoachikoFollowUpApp_Back_End/coach_area/routine_name_update.php",
        data: routineUpdateRequestBody.toJson());
    return response.data;
  }

  Future<Map<String, dynamic>> routineDelete(
      {required RoutineDeleteRequestBody routineDeleteRequestBody}) async {
    var response = await _dio.post(
        "$baseUrl/CoachikoFollowUpApp_Back_End/coach_area/routine_delete.php",
        data: routineDeleteRequestBody.toJson());
    return response.data;
  }

  Future<Map<String, dynamic>> routineAssignExercises(
      {required ExerciseAssignmentRequestBody
          exerciseAssignmentRequestBody}) async {
    var response = await _dio.post(
        "$baseUrl/CoachikoFollowUpApp_Back_End/coach_area/excersise_assign_to_routine.php",
        data: exerciseAssignmentRequestBody.toJson());
    return response.data;
  }
}
