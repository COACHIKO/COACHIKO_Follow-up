import 'package:followupapprefactored/features/modules/coach/diet_making_features/quantities_entering/data/models/quantity_insertion_request_body.dart';

import '../models/quantity_insertion_response.dart';

abstract class FoodQuantitiesRepo {
  Future<QuantityInsertionResponse> enterQuantites(
      QuantityInsertionRequestBody quantityInsertionRequestBody);
}
