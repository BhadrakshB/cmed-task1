import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/asset_download/provider.dart';

class MyHomePage
    extends StatefulWidget {
  const MyHomePage(
      {super.key,});


  @override
  State<
      MyHomePage> createState() =>
      _MyHomePageState();
}

class _MyHomePageState
    extends State<
        MyHomePage> {

  @override
  Widget build(
      BuildContext context) {
    return ChangeNotifierProvider(
      create: (
          BuildContext context) =>
          AssetDownloadProvider(),
      builder: (context,
          child) =>
          _buildPage(context),
    );
  }

  Widget _buildPage(
      BuildContext context) {
    final provider = context
        .read<
        AssetDownloadProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(
            "Task 1: Background Download"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {

          },
          child: Text(
              "Start Download"),),
      ),

    );
  }
}
