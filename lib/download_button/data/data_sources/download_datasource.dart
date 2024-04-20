
import 'dart:io';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

enum Permissions {
  storageAccessDenied,
  storageAccessGranted,
}

class DownloadDataSource {
  List<String> tasks = [];

  Future<Permissions> downloadAsset() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      Directory? baseStorage = await getExternalStorageDirectory();
      print("Storage ka kya haal: ${baseStorage!.path}");
      final taskId = await FlutterDownloader.enqueue(
        url: "https://cdn.pixabay.com/video/2019/11/04/28707-371213524_tiny.mp4",
        savedDir: baseStorage!.path, // Path to save the downloaded file
        showNotification: true, // Show notification in foreground
        openFileFromNotification: false, // Don't open file on notification tap
      );

      tasks.add(taskId ?? '');

      return Permissions.storageAccessGranted;

    } else {
      return Permissions.storageAccessDenied;
    }


  }




}