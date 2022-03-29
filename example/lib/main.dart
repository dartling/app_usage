import 'package:app_usage/models.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:app_usage/app_usage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  List<UsedApp> _usedApps = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    List<UsedApp> usedApps;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await AppUsage.platformVersion ?? 'Unknown platform version';
      usedApps = await AppUsage.apps;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      usedApps = [];
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _usedApps = usedApps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Usage'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Running on: $_platformVersion\n'),
            ),
            ..._usedApps.map(
              (app) => ListTile(
                title: Text(app.name),
                subtitle: Text(app.id),
                trailing: Text(app.timeUsed.toString()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
