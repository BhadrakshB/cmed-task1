import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:task1/constants.dart';

import 'api/local_notifications.dart';
import 'download_button/presentation/pages/home_page.dart';

class DownloadCallbackClass {
  @pragma('vm:entry-point')
  static void
  downloadCallback(
      String id,
      int status,
      int progress) {

    final SendPort? send =
    IsolateNameServer
        .lookupPortByName(
        'downloader_send_port');
    send!.send([
      id,
      status,
      progress
    ]);
  }
}

final GlobalKey<ScaffoldMessengerState> snackbarKey =
GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();



  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('app_icon');
  const DarwinInitializationSettings initializationSettingsDarwin =
  DarwinInitializationSettings();
  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin);

  flutterLocalNotificationsPlugin.initialize(initializationSettings);


  // Plugin must be initialized before using
  await FlutterDownloader.initialize(
      debug: true, // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl: true // option: set to false to disable working with http links (default: false)

  );

  FlutterDownloader
      .registerCallback(
      DownloadCallbackClass.downloadCallback);
  runApp(const MyApp());
}

class MyApp
    extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{


  @override
  void initState() {

    super.initState();

    LocalNotificationService.initialize();
  }

  @override
  Widget build(
      BuildContext context) {
    return MaterialApp(
      title: 'CMED Task 1',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: snackbarKey,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

