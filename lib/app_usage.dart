import 'dart:async';

import 'package:app_usage/models.dart';
import 'package:flutter/services.dart';

class AppUsage {
  static const MethodChannel _channel = MethodChannel('app_usage');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<List<UsedApp>> get apps async {
    final List<dynamic>? usedApps =
        await _channel.invokeListMethod<dynamic>('getUsedApps');
    return usedApps?.map(UsedApp.fromJson).toList() ?? [];
  }

  static Future<String> setAppTimeLimit(String appId, Duration duration) async {
    final String? result = await _channel.invokeMethod('setAppTimeLimit', {
      'id': appId,
      'durationInMinutes': duration.inMinutes,
    });
    return result ?? 'Could not set timer.';
  }
}
