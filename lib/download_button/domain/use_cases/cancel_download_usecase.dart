// Use case class for getting all todos
import '../../data/data_sources/download_datasource.dart';
import '../repositories/download_repository.dart';

class CancelDownloadUseCase {

  final DownloadRepository _downloadRepository;

  // Constructor with dependency injection of TodoRepository
  CancelDownloadUseCase(this._downloadRepository);

  // Method to fetch all todos asynchronously
  Future<void> call() async {
    // Await the result of fetching todos from TodoRepository

    var results = await _downloadRepository.cancelDownload();

  }
}