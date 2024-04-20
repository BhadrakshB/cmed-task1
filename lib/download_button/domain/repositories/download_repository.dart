


import '../../data/data_sources/download_datasource.dart';

abstract class DownloadRepository {
  // Method to download the asset
  Future<Permissions> downloadAsset();

  Future<void> cancelDownload();
}