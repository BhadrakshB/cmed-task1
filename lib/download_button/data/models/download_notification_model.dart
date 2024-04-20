import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadNotificationClass {
  String? taskId;
  DownloadTaskStatus? status;
  int progress;

  DownloadNotificationClass([this.taskId, this.progress = -1, this.status]);

}