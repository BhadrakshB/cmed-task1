import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../../data/models/download_notification_model.dart';
import '../providers/asset_download/provider.dart';

class MyHomePage
    extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage>
      createState() =>
          _MyHomePageState();
}

class _MyHomePageState
    extends State<
        MyHomePage> {

  DownloadNotificationClass downloadNotificationClass = DownloadNotificationClass();

  ReceivePort _port =
      ReceivePort();

  @override
  void initState() {
    super.initState();

    IsolateNameServer
        .registerPortWithName(
            _port.sendPort,
            'downloader_send_port');
    _port.listen(
        (dynamic data) async {
          var notifications = await FlutterLocalNotificationsPlugin().getActiveNotifications();
          print(data.toString());

          downloadNotificationClass = DownloadNotificationClass(data[0], data[2], DownloadTaskStatus.fromInt(data[1]));

      if (downloadNotificationClass.status == DownloadTaskStatus.complete) {
        await Future.delayed(const Duration(seconds: 2));
        downloadNotificationClass = DownloadNotificationClass();

      }

      setState(() {});

    });

  }

  @override
  void dispose() {
    IsolateNameServer
        .removePortNameMapping(
            'downloader_send_port');
    super.dispose();
  }



  @override
  Widget build(
      BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext
              context) =>
          AssetDownloadNotifier(),
      builder: (context,
              child) =>
          _buildPage(context),
    );
  }

  Widget _buildPage(
      BuildContext context) {
    final provider = context.read<
        AssetDownloadNotifier>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
                .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(
            "Task 1: Background Download"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            downloadNotificationClass.taskId != null ? Padding(
              padding: const EdgeInsets.all(30),
              child: LinearProgressIndicator(
                value: downloadNotificationClass.progress!/100,

              ),
            ) : SizedBox(),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed:
                  () async {
                await provider
                    .startDownload();

                setState(() {

                });

                // if (provider
                //     .downloadState ==
                //     DownloadState
                //         .storagePermissionError) {
                //   const snackBar =
                //   SnackBar(
                //     content: Text(
                //         "Please enable storage permissions to download", style:TextStyle(color: Colors.white)),
                //     backgroundColor:
                //     (Colors
                //         .indigoAccent),
                //     behavior: SnackBarBehavior.floating,
                //
                //   );
                //   ScaffoldMessenger.of(
                //       context)
                //       .showSnackBar(
                //       snackBar);
                // }
              },
              child: const Text(
                  "Start Download"),
            ),

            // ElevatedButton(
            //   onPressed:
            //       () async {
            //         await provider
            //             .cancelDownload();
            //       },
            //   child: const Text(
            //       "Cancel Download"),
            // ),
          ],
        )
      ),
    );
  }
}


