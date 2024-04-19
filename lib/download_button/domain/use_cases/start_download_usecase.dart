// Use case class for getting all todos
import '../repositories/download_repository.dart';

class StartDownloadUseCase {

  final DownloadRepository _downloadRepository;

  // Constructor with dependency injection of TodoRepository
  StartDownloadUseCase(this._downloadRepository);

  // Method to fetch all todos asynchronously
  void call() {
    // Await the result of fetching todos from TodoRepository
    _downloadRepository.downloadAsset();
  }
}