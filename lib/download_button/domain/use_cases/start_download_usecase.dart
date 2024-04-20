// Use case class for getting all todos
import '../../data/data_sources/download_datasource.dart';
import '../repositories/download_repository.dart';

class StartDownloadUseCase {

  final DownloadRepository _downloadRepository;

  // Constructor with dependency injection of TodoRepository
  StartDownloadUseCase(this._downloadRepository);

  // Method to fetch all todos asynchronously
  Future<Permissions> call() async {
    // Await the result of fetching todos from TodoRepository

    var results = await _downloadRepository.downloadAsset();
    return results;
  }
}