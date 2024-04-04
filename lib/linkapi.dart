class AppLink {
  static const String server = "192.168.1.6";
  static const String httpServer = "http://$server";
  static const String authDirectory = "/coachikoFollowApp/auth/";
  static const String fetchDirectory = "/coachikoFollowApp/";
  static const String signUpKey = "${authDirectory}register.php";
  static const String signInKey = "${authDirectory}login.php";
  static const String getdirectory = "/coachikoFollowApp/auth_screens/";
  static const String getWorkoutRoutineData =
      "${fetchDirectory}get_routine_data.php";
  static const String getCoachClient = "${fetchDirectory}get_coach_clients.php";
  static const String coacharea = "/coachikoFollowApp/areaofcoach/";
  static const String foodData = "/coachikoFollowApp/";
  static const String dietGetFClient =
      "${httpServer + fetchDirectory}diet_get_for_client.php";
  static const String getDietDataAPI =
      "${httpServer + fetchDirectory}get_food_data.php";
  static const String getExcersiseDataAPI =
      "${httpServer + fetchDirectory}get_excersise_data.php";
  static const String dietInsertionForClients =
      '${httpServer + fetchDirectory}diet_insert_for_client.php';
}
