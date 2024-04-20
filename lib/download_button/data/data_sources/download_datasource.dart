
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

enum Permissions {
  storageAccessDenied,
  storageAccessGranted,
}

class DownloadDataSource {
  List<String> tasks = [];

  Future<Permissions> downloadAsset() async {



    Directory? baseStorage = await getExternalStorageDirectory();
    final taskId = await FlutterDownloader.enqueue(
      url: "https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_30mb.mp4",
      savedDir: baseStorage!.path, // Path to save the downloaded file
      showNotification: true, // Show notification in foreground
      openFileFromNotification: false, // Don't open file on notification tap
      saveInPublicStorage: true,

    );

    tasks.add(taskId ?? '');
    // if (status.isGranted) {


      return Permissions.storageAccessGranted;

    // } else {
    //   return Permissions.storageAccessDenied;
    // }


  }

  Future<void> cancelDownload() async {

    FlutterDownloader.cancel(taskId: tasks.first);


  }




}