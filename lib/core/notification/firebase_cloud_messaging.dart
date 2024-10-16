import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import '../common/styles/show_toast.dart';
import 'firebase_messaging_navigate.dart';

class FirebaseCloudMessaging {
  factory FirebaseCloudMessaging() => _instance;

  FirebaseCloudMessaging._();

  static final FirebaseCloudMessaging _instance = FirebaseCloudMessaging._();

  static const String subscribeKey = 'Enmaa';

  final _firebaseMessaging = FirebaseMessaging.instance;

  ValueNotifier<bool> isNotificationSubscribe = ValueNotifier(true);

  bool isPermissionNotification = false;

  Future<void> init() async {
    //permission
    await _permissionsNotification();

    // forground
    FirebaseMessaging.onMessage
        .listen(FirebaseMessagingNavigate.forGroundHandler);

    // terminated
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then(FirebaseMessagingNavigate.terminatedHandler);

    // background
    FirebaseMessaging.onMessageOpenedApp
        .listen(FirebaseMessagingNavigate.backGroundHandler);
  }

  /// controller for the notification if user subscribe or unsubscribed
  /// or accpeted the permission or not

  Future<void> controllerForUserSubscribe(BuildContext context) async {
    if (isPermissionNotification == false) {
      await _permissionsNotification();
    } else {
      if (isNotificationSubscribe.value == false) {
        await _subscribeNotification();
        if (!context.mounted) return;
        ShowToast.showToastSuccessTop(
          message: "msg",
          seconds: 2,
        );
      } else {
        await _unSubscribeNotification();
        if (!context.mounted) return;
        ShowToast.showToastSuccessTop(
          message: "msg",
          seconds: 2,
        );
      }
    }
  }

  /// permissions to notifications
  Future<void> _permissionsNotification() async {
    final settings = await _firebaseMessaging.requestPermission(badge: false);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      /// subscribe to notifications topic
      isPermissionNotification = true;
      await _subscribeNotification();
      debugPrint('🔔🔔 User accepted the notification permission');
    } else {
      isPermissionNotification = false;
      isNotificationSubscribe.value = false;
      debugPrint('🔕🔕 User not accepted the notification permission');
    }
  }

  /// subscribe notification

  Future<void> _subscribeNotification() async {
    isNotificationSubscribe.value = true;
    await FirebaseMessaging.instance.subscribeToTopic(subscribeKey);
    debugPrint('====🔔 Notification Subscribed 🔔=====');
  }

  /// unsubscribe notification

  Future<void> _unSubscribeNotification() async {
    isNotificationSubscribe.value = false;
    await FirebaseMessaging.instance.unsubscribeFromTopic(subscribeKey);
    debugPrint('====🔕 Notification Unsubscribed 🔕=====');
  }

// send notifcation with api
  Future<void> sendTopicNotification({
    required String title,
    required String body,
    required String token,
  }) async {
    try {
      final response = await Dio().post<dynamic>(
        "https://fcm.googleapis.com/v1/projects/coachiko-followup/messages:send",
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${await getAccessToken()}',
          },
        ),
        data: {
          "message": {
            "token": token,
            "notification": {"title": title, "body": body},
          }
        },
      );
      print(
          "==================================${getAccessToken().toString()}===========================================");
      debugPrint('Notification Created => ${response.data}');
    } catch (e) {
      debugPrint('Notification Error => $e');
    }
  }

  Future<String?> getAccessToken() async {
    final serviceAccountJson = {
      "type": "service_account",
      "project_id": "coachiko-followup",
      "private_key_id": "a94f085de6ab06aae54c0d73925fc28690395fde",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCw9bj73zNDTe5+\n1DaKwq9ENNGox6bkV+G+8iXogacOmaNqh/KuuRrPWaUK3DitiYQeAtoheJy8ATzN\nQKDLx+2R/HaqAR6e+Y/ebE+10G2ozosTqI8WoliiLHF1GbpUJkYJoN74+xjz5fbF\n3Umy7vIgI3J5wOiH1PsSvRU/kCsWtWA9aJi8G1qoNzLEWLkECBXGgbEDFPfDeOLQ\nkmCNcdKCFfuguOcw86CjDwPQfBKpwOF9gXByCumAJk/8WSIuiAddUe9/87yWv2pl\n4TMvDik0gSHoMbBZe45Z90+1caXpxOHlkKOZ6P4BTs/oZH7YVFrvvpem58llXg3V\n3kvdvJDfAgMBAAECggEAAO8e2vq2PjLMv8L5uK0QFUEKCzVGEsVoqpHep79og45M\nJI6QlCX3SSeM1gIS1AIm6SSA+ipkKil0PpYmMbcY3qG/ier76VY9JaT5dmh30+qJ\n6wCDbAfQs2j5d+i5Xo9kRcS5v3YTyzRQujDcNO/4ZA9NqZUnMz2QP462V0w9vKrv\nBkAxBynC6+KRK8Zy+yKwQC9To3uBX4fDP5gjYyPD3y16SSFi3jdvxCuK5Cl+FvkQ\nyxExrYZJaWxxJqMwf8M4ecm+YcfZWBzK6ED+gyj1O8sJRjWQKZ3NzI5M7eGif3K3\nc3pQg/xEW2UDgA/Hnkfxg+FzADMZ6NptK4dh8nxceQKBgQDZ0MY6CJdIbskbaP56\ndtuVQCA1wWvw/Tx8+1J0LNAd513NYD7RFZTseHOfA1Mz8yOIloYhYUOErTyIkKnQ\ndSnvwijyZ8DKMznImeG0Xu3ZxAnKh2w6cXand5XBwj/5AIflBRI31kzmK/sqmGL8\nsvc976oDZEzhoX3JckbeyiarmQKBgQDP+2ia4MHxINbnrje0P28U3m36KxEnoySf\nc19zBZMNBkWB4UPJ6kiYWHnZotkprwUM0JWBDX+T/PlJtyaJb3WRnb4PJX08tgOc\nReoHh7WREdUomjTvZYH5T5kfzac6jCKVyyLVxQtruLc4eM4RwteUk1v8hdg0g5rp\nX+YzflMrNwKBgGccHbp7NqJjT3BaU51Fhs0wfg70cVSzjF7d2jqEvEBrtkvys8nm\nnYkTvCgaOtjs0HVoTDahBIVaPL2pPbogvKlzEE8wLmOJvGDp956bEZ103+2wDdvc\nun6sbYg7nG0Tg0E3FVi5ac3MJCoV2UYmskPvoFvar0pgWFt0bXgp2gSBAoGASTjo\n9gYFIcB/CKgUYngmwoEg1P+OlZbhUOXMh/FBeUdo9zX4qMC7+C7GD3I+5GcC7yUM\nTZgT/2UD2wkJHz/Hc5HGlQyMz/AAy2bt4uLLcJyHoDjSRCpHnR+B+Glt47XsgzI2\nPG6X+7/XeaFGY4hmX5+VtgzlNm/S/TDPGffyjfcCgYBAWym1JhLwGWg55x028klE\na6evzOBi5ZXZwZTHBexdTFqFF9z7xh+7VVUtr/wSUWcp7jNYtPieAbCsd65wM9Vm\n6cOy+I/OaWSyjuzOegbnxQA8V8th2N3YzH9HI3tms8WXQ37B0wVZnRbKT9dkJtgL\nzRDUCcgiZ+fjGN3DB/5rTA==\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-9ln92@coachiko-followup.iam.gserviceaccount.com",
      "client_id": "111688089534514411894",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-9ln92%40coachiko-followup.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    try {
      http.Client client = await auth.clientViaServiceAccount(
          auth.ServiceAccountCredentials.fromJson(serviceAccountJson), scopes);

      auth.AccessCredentials credentials =
          await auth.obtainAccessCredentialsViaServiceAccount(
              auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
              scopes,
              client);

      client.close();

      return credentials.accessToken.data;
    } catch (e) {
      return null;
    }
  }
}
