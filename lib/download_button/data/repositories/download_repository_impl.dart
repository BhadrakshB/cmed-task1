import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task1/download_button/data/data_sources/download_datasource.dart';
import 'package:task1/download_button/domain/repositories/download_repository.dart';

class DownloadRepositoryImpl extends DownloadRepository {

  final DownloadDataSource _downloadDataSource;

  DownloadRepositoryImpl(this._downloadDataSource);

  // void callback(id, status, progress) {
  //   setState(() {
  //     _downloadProgress = progress; // Update download progress UI
  //   });
  //
  //   if (status == DownloadTaskStatus.complete) {
  //     // Download completed, handle notification
  //     _showDownloadCompleteNotification();
  //   } else if (status == DownloadTaskStatus.failed) {
  //     // Download failed, handle error
  //   }
  // }

  @override
  void downloadAsset() {
    _downloadDataSource.downloadAsset();
  }

}

Future<void> _showDownloadCompleteNotification() async {
  final platform = defaultTargetPlatform;
  final pendingNotificationRequests = await FlutterLocalNotificationsPlugin().pendingNotificationRequests();

  await FlutterLocalNotificationsPlugin().show(
    0,
    "Download Complete",
    "Your file has been downloaded!",
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'download_channel',
        'Downloads',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
  );

  // Clear any pending notifications if app is opened
  if (platform == TargetPlatform.android && pendingNotificationRequests.isNotEmpty) {
    await FlutterLocalNotificationsPlugin().cancelAll();
  }
}