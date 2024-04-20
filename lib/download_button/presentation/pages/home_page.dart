import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:provider/provider.dart';

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
        (dynamic data) {
      log(data.toString());
      print(data.toString());
      String id = data[0];
      DownloadTaskStatus
          status = data[1];
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader
        .registerCallback(
            downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer
        .removePortNameMapping(
            'downloader_send_port');
    super.dispose();
  }

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
        child: ElevatedButton(
          onPressed:
              () async {
            await provider
                .startDownload();

            if (provider
                    .downloadState ==
                DownloadState
                    .storagePermissionError) {
              const snackBar =
                   SnackBar(
                content: Text(
                    "Please enable storage permissions to download", style:TextStyle(color: Colors.white)),
                backgroundColor:
                    (Colors
                        .indigoAccent),
                     behavior: SnackBarBehavior.floating,

              );
              ScaffoldMessenger.of(
                      context)
                  .showSnackBar(
                      snackBar);
            }
          },
          child: const Text(
              "Start Download"),
        ),
      ),
    );
  }
}
