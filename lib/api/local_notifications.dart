import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import '../main.dart';

class LocalNotificationService {
  // Instance of Flutternotification plugin
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Initialization setting for android
    const InitializationSettings initializationSettingsAndroid =
    InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notificationsPlugin.initialize(
      initializationSettingsAndroid,
      // to handle event when we receive notification
      onDidReceiveNotificationResponse: (details) {
        if (details.input != null) {}
      },
    );

    try {
      var status = await Permission.notification.request();
      if (status == PermissionStatus.denied) {
        const  snackBar = const SnackBar(content: Text("Cannot show notifications", style: TextStyle(color: Colors.white),), backgroundColor: Colors.indigoAccent,);
        snackbarKey.currentState?.showSnackBar(snackBar);
      }

    } on (Error e,) {
      const  snackBar = const SnackBar(content: Text("Cannot show notifications", style: TextStyle(color: Colors.white),), backgroundColor: Colors.indigoAccent,);
      snackbarKey.currentState?.showSnackBar(snackBar);
    }


  }

}