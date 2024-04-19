
import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadDataSource {
  List<String> tasks = [];

  Future<void> downloadAsset() async {
    String directory = '/storage/emulated/0/Download/';
    final taskId = await FlutterDownloader.enqueue(
      url: "https://file-examples.com/storage/feaade38c1651bd01984236/2017/04/file_example_MP4_1920_18MG.mp4",
      savedDir: directory, // Path to save the downloaded file
      showNotification: true, // Show notification in foreground
      openFileFromNotification: false, // Don't open file on notification tap
    );

    tasks.add(taskId ?? '');

  }


}