import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'coachiko_app.dart';
import 'core/di/dependency_injection.dart';
import 'core/notification/firebase_cloud_messaging.dart';
import 'core/notification/notfication.dart';
import 'core/services/shared_pref/shared_pref.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref().instantiatePreferences();

  // Use FirebaseOptions for Android only if needed, otherwise default
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      name: "coachikofollowapp",
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAahZFS9DL4m2a5gfD_nFCex7XxbtwYGtE',
        appId: '1:752059871954:android:edcec9e1179f36c191f30b',
        messagingSenderId: '752059871954',
        projectId: 'coachiko-followup',
      ),
    );
  } else {
    // Initialize for iOS or web without options
    await Firebase.initializeApp();
  }

  // Setup services after Firebase has initialized
  FirebaseCloudMessaging().init();
  LocalNotificationService.init();

  await setupInjector();

  runApp(COACHIKOFollowApp());
}
