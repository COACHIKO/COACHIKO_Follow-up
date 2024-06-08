import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../controller/coach_controllers/diet_making_controllers/diet_make_controller.dart';
import '../../../../linkapi.dart';
import '../../../../main.dart';
import '../../../../view/screens/coach_area/diet_presentation/diet_making_page.dart';
import '../../../model/diet_models/food_model.dart';

class ClientDietGet {
  Future<void> dietGetForClient() async {
    final dietMakingController = Get.put(DietMakingController());

    final response = await http.post(
      Uri.parse(AppLink.dietGetFClient),
      body: {
        'client_id': myServices.sharedPreferences.getInt("user").toString()
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedData = jsonDecode(response.body);
      DietApiGet dietApiGet = DietApiGet.fromJson(decodedData);
      dietMakingController.dietData = dietApiGet.data;
    } else {}
  }
}
