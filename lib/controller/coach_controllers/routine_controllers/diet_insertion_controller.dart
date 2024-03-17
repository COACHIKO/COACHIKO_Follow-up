import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../data/model/diet_models/food_model.dart';
import '../../../linkapi.dart';

class DietQuantitiesController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  insertDietData(List<DietModel> selectedDietList, int clientId,nmofdata) async {

    try {
      isLoading.value = true;
      for (DietModel diet in selectedDietList) {
        final response = await http.post(
          Uri.parse(AppLink.dietInsertionForClients),
          body: {
            'client_id': clientId.toString(),
            'food_id': diet.foodData.id.toString(),
            'quantity': diet.quantity.toString(),
            'numofdata': nmofdata.toString(),
          },
        );

        if (response.statusCode == 200) {
        } else {
          errorMessage.value = 'Failed to insert diet data. Status code: ${response.statusCode}';
        }
      }
    } catch (e) {
      errorMessage.value = 'Error during diet data insertion: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
