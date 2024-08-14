import '../../../features/modules/coach/all_clients_display/data/models/clients_response.dart';
import '../../../features/modules/coach/diet_making_features/food_selection/data/models/food_model.dart';

class TrackHistoryParams {
  final int userId;
  final String name;

  TrackHistoryParams({
    required this.userId,
    required this.name,
  });
}

class SelectedFoodsParams {
  final ClientData clientData;
  final List<FoodDataModel> selectedFoods;

  SelectedFoodsParams({
    required this.clientData,
    required this.selectedFoods,
  });
}
