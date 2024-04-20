
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
    Directory? baseStorage = await getExternalStorageDirectory();
    final taskId = await FlutterDownloader.enqueue(
      // url: "https://cdn.pixabay.com/video/2019/11/04/28707-371213524_tiny.mp4",
      url: "https://testfile.org/files-5GB",
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