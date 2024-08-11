import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:followupapprefactored/firebase_options.dart';
import 'package:get_it/get_it.dart';
import 'coachiko_app.dart';
import 'core/di/dependency_injection.dart';
import 'core/services/services.dart';
import 'core/services/shared_pref/shared_pref.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref().instantiatePreferences();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await setupInjector();

  await initialServices();
  runApp(COACHIKOFollowApp());
}

String determineInitialRoute() {
  final sharedPref = GetIt.instance<SharedPref>();
  final userType = sharedPref.getInt("user");
  final rememberMe = sharedPref.getBool("rememberMe");
  final isCoach = sharedPref.getInt("isCoach");
  final currentStep = sharedPref.getInt("currentStep");

  if (userType == null || rememberMe == false) {
    return "/forkUsering";
  } else if (isCoach == 1) {
    return "/CoachHome";
  } else if (isCoach == 0 && currentStep == 0) {
    return "/formCompletion";
  } else if (currentStep == 1) {
    return "/currentStage";
  } else {
    return "/ClientHome";
  }
}
