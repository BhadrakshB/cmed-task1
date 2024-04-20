import 'package:flutter/material.dart';
import 'package:task1/download_button/data/data_sources/download_datasource.dart';
import 'package:task1/download_button/data/repositories/download_repository_impl.dart';
import 'package:task1/download_button/domain/repositories/download_repository.dart';
import 'package:task1/download_button/domain/use_cases/start_download_usecase.dart';

import '../../../domain/use_cases/cancel_download_usecase.dart';

enum DownloadState {
  idle,
  downloading,
  paused,
  cancelling,
  cancelled,
  finished,
  error,
  storagePermissionError,
}

class AssetDownloadNotifier
    extends ChangeNotifier {
  late final DownloadRepository
      _downloadRepository;

  AssetDownloadNotifier()
      : _downloadRepository =
            DownloadRepositoryImpl(
                DownloadDataSource());

  void _setState({
    required DownloadState
        newState,
    String errorMessage = '',
    String successMessage =
        '',
  }) {
    _downloadState = newState;
    _errorMessage =
        errorMessage;
    _successMessage =
        successMessage;
    notifyListeners();
  }

  DownloadState
      _downloadState =
      DownloadState.idle;
  String _errorMessage = '';
  String _successMessage = '';

  // Getters for current state and error message
  DownloadState
      get downloadState =>
          _downloadState;

  String get errorMessage =>
      _errorMessage;

  String get successMessage =>
      _successMessage;


  Future<void> cancelDownload() async {
    _setState(
        newState: DownloadState
            .cancelling); // Set state to fetching
    try {
      Permissions result =
      await CancelDownloadUseCase(
          _downloadRepository)
          .call();

      _setState(
          newState:
          DownloadState
              .cancelled);
    } catch (e) {
      _setState(
          newState:
          DownloadState
              .error,
          errorMessage:
          e.toString());
      // Set state to error if fetch fails
    }
    // Reset state to idle after 5 seconds
    Future.delayed(
      const Duration(seconds: 5),
          () {
        _setState(
            newState:
            DownloadState
                .idle);
      },

    );

  }

  Future<void>
      startDownload() async {
    _setState(
        newState: DownloadState
            .downloading); // Set state to fetching
    try {
      Permissions result =
          await StartDownloadUseCase(
                  _downloadRepository)
              .call();

      if (result ==
          Permissions
              .storageAccessDenied) {
        _setState(
            newState:
                DownloadState
                    .storagePermissionError);
      } else {
        _setState(
            newState:
                DownloadState
                    .finished); // Set state to success if fetch is successful
      }
    } catch (e) {
      _setState(
          newState:
              DownloadState
                  .error,
          errorMessage:
              e.toString());
      // Set state to error if fetch fails
    }
    // Reset state to idle after 5 seconds
    Future.delayed(
      const Duration(seconds: 5),
        () {
          _setState(
              newState:
              DownloadState
                  .idle);
        },

    );

  }
}
