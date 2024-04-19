import 'package:flutter/material.dart';

enum DownloadState {
  idle,
  downloading,
  finished,
  error
}

class AssetDownloadProvider extends ChangeNotifier {

  void _setState({
    required DownloadState newState,
    String errorMessage = '',
    String successMessage = '',
  }) {
    _todoState = newState;
    _errorMessage = errorMessage;
    _successMessage = successMessage;
    notifyListeners();
  }

  DownloadState _todoState = DownloadState.idle;
  String _errorMessage = '';
  String _successMessage = '';

  // Getters for current state and error message
  DownloadState get todoState => _todoState;
  String get errorMessage => _errorMessage;
  String get successMessage => _successMessage;

  Future<void> getTodos() async {
    _setState(newState: DownloadState.downloading); // Set state to fetching
    try {
      // Call GetTodosUseCase to fetch todos from repository

      // Add downloading function

      _setState(
          newState:
          DownloadState.finished); // Set state to success if fetch is successful
    } catch (e) {
      _setState(newState: DownloadState.error, errorMessage: e.toString());
      // Set state to error if fetch fails
    }
    // Reset state to idle after 5 seconds
    _setState(newState: DownloadState.idle);
  }
}
