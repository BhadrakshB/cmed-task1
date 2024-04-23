# Task 01: Large File Download App
## Project Description

This Flutter application allows users to download a large file from the internet in the background, even if they leave the app. It provides progress updates through a progress widget on the screen and notifications while the app is in the background.

## Features

- Single-screen interface with a central download button.
- Progress bar to visualize download progress.
- Background download functionality.
- Download progress notifications.
- Standard Material Design UI.

## Implementation Details

- Uses the [retrofit](https://pub.dev/packages/retrofit) package for network requests.
- Employs the [flutter_downloader](https://pub.dev/packages/flutter_downloader) package to manage download storage.
- Leverages the [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) package for background notifications.
- Adheres to best practices for state management ([Provider](https://pub.dev/packages/provider)).


